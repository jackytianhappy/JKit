//
//  JTagListViewDemo.m
//  Jkit
//
//  Created by Jacky on 16/7/22.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JTagListViewDemo.h"
#import "JTagListView.h"

@interface JTagListViewDemo(){
    CGFloat height;
}

@property (nonatomic,strong) JTagListView *tagView;

@end

@implementation JTagListViewDemo

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initJTagListView];
    }
    return self;
}

-(void)initJTagListView{
    UIButton *btnOne = [[UIButton alloc]initWithFrame:CGRectMake(0, 30, 70, 20)];
    [btnOne setTitle:@"400宽度" forState:UIControlStateNormal];
    btnOne.tag = 400;
    [btnOne setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnOne addTarget:self action:@selector(initpage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnOne];
    
    
    UIButton *btnTwo = [[UIButton alloc]initWithFrame:CGRectMake(75, 30, 70, 20)];
    [btnTwo setTitle:@"300宽度" forState:UIControlStateNormal];
    btnTwo.tag = 300;
    [btnTwo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnTwo addTarget:self action:@selector(initpage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnTwo];
    
    UIButton *btnThree= [[UIButton alloc]initWithFrame:CGRectMake(150, 30, 70, 20)];
    [btnThree setTitle:@"200宽度" forState:UIControlStateNormal];
    btnThree.tag = 200;
    [btnThree setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnThree addTarget:self action:@selector(initpage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnThree];
    
    
    UIButton *widthBtn = [[UIButton alloc]initWithFrame:CGRectMake(225, 30, 70, 20)];
    [widthBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [widthBtn setTitle:@"height" forState:UIControlStateNormal];
    [widthBtn addTarget:self action:@selector(showHeight) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:widthBtn];
}


-(void)showHeight{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提醒" message:[NSString stringWithFormat:@"最后一个tag的底部y是%f",height] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    
    [alert show];
}



-(void)initpage:(UIButton *)btn{
    [self.tagView removeFromSuperview];
    NSArray *tempName = @[@"欢迎提出宝贵的意见",@"作者jacky",@"欢迎补充功能",@"iOS developer",@"大家还有什么需诶去呢",@"多多指教",@"进行补充",@"提高控件质量",@"最后欢迎fork"];
    
    
    //初始化数据
    self.tagView = [[JTagListView alloc]initWithFrame:CGRectMake(0, 100, btn.tag, 300) andNameDatasource:tempName toppading:5 padding:5];
    
    
    
    self.tagView.backgroundColor = [UIColor purpleColor];
    NSMutableArray *afdsa = [[NSMutableArray alloc]init];
    for (int i = 0; i<tempName.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor blackColor];
//        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        //开发者自己根据美工需求自定义按钮统一外观（不包括按钮内容）
        [afdsa addObject:btn];
    }
    [self.tagView reDraw:afdsa];
    
    CGRect frame = self.tagView.frame;
    frame.size.height = self.tagView.tagHeight;
    self.tagView.frame = frame;
    
    [self addSubview:self.tagView];
    height = self.tagView.tagHeight;
    //点击操作
    _tagView.tagClick =^(long index){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"友情提醒" message:tempName[index] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        
        [alert show];
    };
    
}



@end
