//
//  JADCycleView.h
//  Jkit
//
//  Created by Jacky on 16/7/19.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片显示的模式
typedef enum {
    ScaleToFill,//全屏显示
    ScaleToFit//等比例显示
}ImgModeInJADCycleView;

//是否支持无线滚动
typedef enum {
    EndLessCycle,//无限轮播
    LimitedCycle //有限轮播
}CycleMode;

//是否是自动滚动
typedef enum {
    AutoCycle,//默认自动滚动
    NotAutoCycle //手动滑动
}IsAutoCycle;

//广告页码的位置
typedef enum {
    PageControlRight, //右侧
    PageControlCenter, //中间
    pageControlLeft
}PageControlMode;


@interface JADCycleView : UIView

//点击事件
@property (nonatomic,copy) void(^imageSelected)(int index);

//轮播模式 无限轮播/有限轮播
@property (nonatomic,assign) CycleMode cycleMode;

//是否自动滚动
@property (nonatomic,assign) IsAutoCycle isAutoCycle;
//自动轮播时间间隔 默认时间间隔事3秒
@property (nonatomic,assign) NSTimeInterval autoTimeInterval;


//scrollview
//滑动的scrollView
@property (nonatomic,strong) UIScrollView *scrollView;
//设置显示的轮转图片的形式
@property (nonatomic,assign) ImgModeInJADCycleView imgModeInJADCycleView;


//TitleView
//底部的title的背景view
@property (nonatomic,strong) UIView *bottomTitleView;
//titleView的高度 默认情况下是 kBottomTitleViewheight = 30
@property (nonatomic,assign) CGFloat bottomTitleViewHeight;
//底部文字的Label
@property (nonatomic,strong) UILabel *bottomTitleLbl;
//底部Pagecontrol的位置
@property (nonatomic,assign) PageControlMode pageControlMode;
//底部Pagecontrol的高度
@property (nonatomic,assign) CGFloat pageControlHeight;

/**
 *  初始化广告栏目方法
 *
 *  @param frame    广告栏的大小及位置
 *  @param imgArr   广告栏的图像数据源
 *  @param titleArr 广告栏的底部标题栏目
 *
 *  @return 返回JADCycleView
 */
-(id)initWithFrame:(CGRect)frame ImageSource:(NSArray *)imgArr TitleSources:(NSArray *)titleArr CycleMode:(CycleMode)mode AndIsAutoCycle:(IsAutoCycle)autoCycleMode;


@end
