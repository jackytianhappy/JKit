//
//  JADCycleViewDemo.m
//  Jkit
//
//  Created by Jacky on 16/7/22.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JADCycleViewDemo.h"
#import "JADCycleView.h"

@implementation JADCycleViewDemo

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *imgArr   = [[NSArray alloc]initWithObjects:@"JADCycleTest1",@"http://img3.3lian.com/2013/v8/86/d/101.jpg",@"JADCycleTest3", nil];
        NSArray *titleArr = [[NSArray alloc]initWithObjects:@"这里是title 1",@"这里是title 2",@"这里是title 3", nil];
        
        JADCycleView *adCycleView         = [[JADCycleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight/3) ImageSource:imgArr  TitleSources:titleArr CycleMode:EndLessCycle AndIsAutoCycle:NotAutoCycle];
        adCycleView.imgModeInJADCycleView = ScaleToFill;
        adCycleView.pageControlMode       = PageControlRight;
        [self addSubview:adCycleView];
        
        adCycleView.imageSelected = ^(int index){
            NSLog(@"这里输出我们的值：%d",index);
        };
    }
    return self;
}

@end
