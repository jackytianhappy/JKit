//
//  JTagListView.m
//  JTagList
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "JTagListView.h"


//字体大小
static const float fontSize = 15; //默认 通过重绘方法改变
//标签的高度
static const float tagHeight = 20; //标签的高度值 通过重绘方法改变

//tag标签内部文字两边的距离
static const float tagInnerPadding = 5;

@interface JTagListView(){
    CGRect viewFrame;
    NSArray *dataSource;
    NSArray *colorDatasource;
    
    float tagTopPadding;
    float tagPadding;
}

@property (nonatomic,strong) UIView *subView;

@end


@implementation JTagListView

-(instancetype)initWithFrame:(CGRect)frame andNameDatasource:(NSArray *)tagDatasource toppading:(float)topPadding padding:(float)padding{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDataWithFrame:frame andNameDatasource:tagDatasource toppading:topPadding padding:padding];
        
        [self drawTheView];
    }
    return self;
}

/**
 *  初始化数据
 *
 *  @param frame             标签列表的底部view
 *  @param tagDatasource     标签上的数据源
 *  @param topPadding        标签button上部分距离frame的值
 *  @param padding           标签button与标签button之间的距离
 */
-(void)initDataWithFrame:(CGRect)frame andNameDatasource:(NSArray *)tagDatasource toppading:(float)topPadding padding:(float)padding{
    viewFrame     = frame;
    dataSource    = tagDatasource;

    tagTopPadding = topPadding;
    tagPadding    = padding;

    self.subView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self addSubview:self.subView];
}

/**
 *  用户自定义标签样式等等
 */
-(void)reDraw:(NSArray *)btnArr{
    for (UIView *view in [self.subView subviews]) {
        [view removeFromSuperview];
    }

    //重新绘制
    CGFloat lastPositionX   = 0;
    CGFloat lastPositionY   = 0;
    CGFloat computeTagWidth = 0;
    
    for (int i =0 ; i<dataSource.count; i++) {
        UIButton *btn   = btnArr[i];
        CGRect frame    = btn.frame;
        computeTagWidth = btn.titleLabel.font.pointSize*[self convertToInt:[NSString stringWithFormat:@"%@",dataSource[i]]] + tagInnerPadding*2;
        
        if ((lastPositionX + tagPadding + computeTagWidth)>viewFrame.size.width) {
            lastPositionX = 0;
            lastPositionY +=(tagPadding + tagHeight);
        }
        
        frame     = CGRectMake(lastPositionX+tagPadding, lastPositionY+tagTopPadding, computeTagWidth, tagHeight);
        btn.frame = frame;
        [btn setTitle:dataSource[i] forState:UIControlStateNormal];
        
        //action
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        lastPositionX = CGRectGetMaxX(btn.frame);
        [self.subView addSubview:btn];
    }
    
    _tagHeight = lastPositionY + tagHeight + tagTopPadding*2;
    
}

/**
 *  系统默认样式
 */
-(void)drawTheView{
    CGFloat lastPositionX   = 0;
    CGFloat lastPositionY   = 0;
    CGFloat computeTagWidth = 0;
    
    for (int i =0 ; i<dataSource.count; i++) {
        computeTagWidth = fontSize*[self convertToInt:[NSString stringWithFormat:@"%@",dataSource[i]]] + tagInnerPadding*2;
        
        if ((lastPositionX + tagPadding + computeTagWidth)>viewFrame.size.width) {
            lastPositionX = 0;
            lastPositionY +=(tagPadding + tagHeight);
        }
        
        UIButton *btn           = [[UIButton alloc]initWithFrame:CGRectMake(lastPositionX+tagPadding, lastPositionY+tagTopPadding, computeTagWidth, tagHeight)];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius  = tagHeight*0.5;
        btn.titleLabel.font     = [UIFont systemFontOfSize:fontSize];
        
        [btn setBackgroundColor:[self getRandomColor:colorDatasource]];
        [btn setTitleColor:(self.textColor == nil?[UIColor whiteColor]:self.textColor) forState:UIControlStateNormal];
        [btn setTitle:dataSource[i] forState:UIControlStateNormal];
        
        //action
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        lastPositionX = CGRectGetMaxX(btn.frame);
        [self.subView addSubview:btn];
    }

    _tagHeight = lastPositionY + tagHeight + tagTopPadding;
}


#pragma mark -action
-(void)btnClick:(UIButton *)btn{
    if (self.tagClick) {
        self.tagClick(btn.tag);
    }

}

#pragma mark - private help function
-(UIColor *)getRandomColor:(NSArray *)colorArray{
    if (colorArray == nil || colorArray.count == 0) {
        colorArray = @[
                       [UIColor colorWithRed:94/255.0 green:180/255.0 blue:108/255.0 alpha:1.0],
                       [UIColor colorWithRed:190/255.0 green:118/255.0 blue:192/255.0 alpha:1.0],
                       [UIColor colorWithRed:94/255.0 green:122/255.0 blue:213/255.0 alpha:1.0],
                       [UIColor colorWithRed:195/255.0 green:121/255.0 blue:195/255.0 alpha:1.0],
                       [UIColor colorWithRed:233/255.0 green:195/255.0 blue:108/255.0 alpha:1.0]
                       ];
    }
    int index = rand() % ((int)colorArray.count);
    
    return colorArray[index];
}

- (int)convertToInt:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
    
}

@end
