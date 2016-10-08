//
//  JButton.m
//  JKit
//
//  Created by Jacky on 16/8/16.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JButton.h"

//竖直方向显示时图片和文字的比例
static const float kTitleRatio = 0.2;

@interface JButton(){
    CGFloat finalRatio;
    NSString *btnTitle;
    JButton *btn;
}


@end

@implementation JButton

-(id)initWithFrame:(CGRect)frame title:(NSString *)title iamge:(UIImage *)image handler:(tapHandler)handler{
    btnTitle = title;//便于每次改变属性后进行重新绘制
    finalRatio = kTitleRatio;
    
    btn                          = [super initWithFrame:frame];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.font          = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.imageView.contentMode    = UIViewContentModeScaleAspectFit;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    btn.handler                  = handler;
    [btn addTarget:btn action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


-(void)btnTapped:(UIButton *)sender{
    if (self.handler) {
        self.handler(sender);
    }
}


#pragma mark - 调整内部ImageView和label的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    switch (_direction) {
        case Horizontal://水平
            return CGRectMake(_padding?_padding:0,0,_padding?(contentRect.size.width*finalRatio -_padding):contentRect.size.width*finalRatio,contentRect.size.height);
            break;
        default://垂直 默认
            return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1-finalRatio));
            break;
    }
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    switch (_direction) {
        case Horizontal://水平
            return CGRectMake(contentRect.size.width*finalRatio, 0, contentRect.size.width*(1-finalRatio), contentRect.size.height);
            break;
            
        default://垂直 默认
            return CGRectMake(0, contentRect.size.height * (1-finalRatio), contentRect.size.width, contentRect.size.height * finalRatio);
            break;
    }
}


#pragma mark - setter overWrite
-(void)setDirection:(direction)direction{
    _direction = direction;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    
}

-(void)setLblRatio:(CGFloat)lblRatio{
    _lblRatio = lblRatio;
    finalRatio = lblRatio;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
}

-(void)setPadding:(CGFloat)padding{
    _padding = padding;
    [btn setTitle:btnTitle forState:UIControlStateNormal];
}
@end
