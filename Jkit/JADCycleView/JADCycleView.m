//
//  JADCycleView.m
//  Jkit
//
//  Created by Jacky on 16/7/19.
//  Copyright © 2016年 jacky. All rights reserved.
//
#import "JADCycleView.h"
#import "JAsynImageView.h"
#import "JUtils.h"

//处理的标签的tag---scrollView上面的图片 tag：0,1,2.....

static CGFloat const kBottomTitleViewheight = 30; //底部标题栏背景的高度 默认
static CGFloat const kPageControlHeight = 20; //pagecontrol的高度是20 默认
static NSTimeInterval const kIntervalTime = 3; //间隔时间是3秒 默认

@interface JADCycleView()<UIScrollViewDelegate>{
    CGRect viewFrame;
    NSArray *imgArray;
    NSArray *titleArray;
    
    int currentPage; //当前页码
    
    NSTimer *cycleTimer;
    
    int leftPointer;
    int middlePointer;
    int rightPointer;
    

}

@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) JAsynImageView *imgOneInScrollview;
@property (nonatomic,strong) JAsynImageView *imgTwoInScrollview;
@property (nonatomic,strong) JAsynImageView *imgThreeInScrollview;

@end

@implementation JADCycleView
@synthesize scrollView;
-(id)initWithFrame:(CGRect)frame ImageSource:(NSArray *)imgArr TitleSources:(NSArray *)titleArr CycleMode:(CycleMode)mode AndIsAutoCycle:(IsAutoCycle)autoCycleMode{
    if (self = [super initWithFrame:frame]) {
        //初始化数据
        self.cycleMode = mode;
        self.isAutoCycle = autoCycleMode;
        self.autoTimeInterval = kIntervalTime; //自动轮转播放

        imgArray   = [[NSArray alloc]initWithArray:imgArr];
        titleArray = [[NSArray alloc]initWithArray:titleArr];
        viewFrame  = frame;

        //内部初始化scrollview
        [self innerInitScrollView];

        //设置广告图片
        switch (self.cycleMode) {
            case LimitedCycle://有限轮转
                [self initScrollViewDataInLimitedCycle];
                break;
            default://无限轮转
                [self initScrollViewDataInEndLess];
                break;
        }
        
        //设置广告底部文字背景View
        [self initBottomTitleView:imgArr];
        
        //轮播的模式
        [self autoCycleAction];
    }
    return self;
}


#pragma mark -endlessCycle action
-(void)makeTheScrollViewEndless{
    //即使快速滑动的时候这边也是能够执行到的 在这边进行位置的重置 置换图片位置 更正轮转
    //1.计算出当前的偏移量 计算目前的页码位置
    int m = self.scrollView.contentOffset.x / viewFrame.size.width; // m = 0 向左滑动 1没动 2向右滑动
    switch (m) {
        case 0://向左滑动
            //重新改变pointer的值
            rightPointer  = middlePointer;
            middlePointer = leftPointer;
            leftPointer = (int)(leftPointer+imgArray.count -1)%imgArray.count;
            break;
        case 1://没动
            break;
        default://向右滑动
            //重新改变pointer的值
            leftPointer = middlePointer;
            middlePointer = rightPointer;
            rightPointer = (int)(rightPointer + 1 + imgArray.count)%imgArray.count;
            break;

    }

    [self makeContentImgView:self.imgTwoInScrollview andTheIndex:middlePointer];
    [self.scrollView setContentOffset:CGPointMake(viewFrame.size.width, 0)];
    [self makeContentImgView:self.imgOneInScrollview andTheIndex:leftPointer];
    [self makeContentImgView:self.imgThreeInScrollview andTheIndex:rightPointer];
}

#pragma mark -Observer the scrollview
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    //有限轮转和
    switch (self.cycleMode) {
        case EndLessCycle: //无限轮转
            [self endLessRedraw];
            break;
            
        default: //有限轮转
            [self limitedRedraw];
            break;
    }
}
/**
 *  无限轮转时的重绘
 */
-(void)endLessRedraw{
    if ((scrollView.contentOffset.x <= 1)|| (scrollView.contentOffset.x >= viewFrame.size.width*2)){
        [self makeTheScrollViewEndless];
        self.bottomTitleLbl.text = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:middlePointer]];
        self.pageControl.currentPage = middlePointer;
        [self autoCycleAction];
    }
}

-(void)limitedRedraw{
    currentPage = self.scrollView.contentOffset.x/viewFrame.size.width;
    self.bottomTitleLbl.text = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:currentPage]];
    self.pageControl.currentPage = currentPage;
    [self autoCycleAction];
}


#pragma mark -init scrollView
/**
 *  初始化scrollView
 */
-(void)innerInitScrollView{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height)];
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    
    [scrollView addObserver:self
                 forKeyPath:@"contentOffset"
                    options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                    context:@"this is a context"];
}

/**
 *  初始化scrollview的内部数据（有限循环情况下）
 */
-(void)initScrollViewDataInLimitedCycle{
    if (!imgArray||0 == imgArray.count) {
        return;
    }
    scrollView.contentSize = CGSizeMake(viewFrame.size.width*imgArray.count, viewFrame.size.height);
    //TO DO 需要重构
    for (int i = 0; i<imgArray.count; i++) {
        //有限循环下的时候进行直接绘制
        JAsynImageView *view = [[JAsynImageView alloc]initWithFrame:CGRectMake(i*viewFrame.size.width, 0, viewFrame.size.width, viewFrame.size.height)];
        view.tag = i;
        [self makeContentImgView:view andTheIndex:i];
        view.clipsToBounds = YES;//防止图片超出边界
        view.userInteractionEnabled = YES;//防止图片超出边界
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapGuester:)]];
        [scrollView addSubview:view];
    }
    currentPage = 0;
}

/**
 *  初始化scrollview的内部数据（无限循环情况下）
 */
-(void)initScrollViewDataInEndLess{
    if (!imgArray||0 == imgArray.count) {
        return;
    }
    scrollView.contentSize = CGSizeMake(viewFrame.size.width*3, viewFrame.size.height);
    //TO DO 需要重构
    for (int i = 0; i<3 ; i++) {
        switch (i) {
            case 0:
                self.imgOneInScrollview = [[JAsynImageView alloc]initWithFrame:CGRectMake(i*viewFrame.size.width, 0, viewFrame.size.width, viewFrame.size.height)];
                self.imgOneInScrollview.tag = i;
                [self makeContentImgView:self.imgOneInScrollview andTheIndex:(int)(imgArray.count-1)];
                self.imgOneInScrollview.clipsToBounds = YES;//防止图片超出边界
                self.imgOneInScrollview.userInteractionEnabled = YES;//防止图片超出边界
                [self.imgOneInScrollview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapGuester:)]];
                [scrollView addSubview:self.imgOneInScrollview];
                break;
            case 1:
                self.imgTwoInScrollview = [[JAsynImageView alloc]initWithFrame:CGRectMake(i*viewFrame.size.width, 0, viewFrame.size.width, viewFrame.size.height)];
                self.imgTwoInScrollview.tag = i;
                [self makeContentImgView:self.imgTwoInScrollview andTheIndex:0];
                self.imgTwoInScrollview.clipsToBounds = YES;//防止图片超出边界
                self.imgTwoInScrollview.userInteractionEnabled = YES;
                [self.imgTwoInScrollview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapGuester:)]];
                [scrollView addSubview:self.imgTwoInScrollview];
                break;
            default:
                self.imgThreeInScrollview = [[JAsynImageView alloc]initWithFrame:CGRectMake(i*viewFrame.size.width, 0, viewFrame.size.width, viewFrame.size.height)];
                self.imgThreeInScrollview.tag = i;
                [self makeContentImgView:self.imgThreeInScrollview andTheIndex:(imgArray.count>1?1:0)];
                self.imgThreeInScrollview.clipsToBounds = YES;//防止图片超出边界
                self.imgThreeInScrollview.userInteractionEnabled = YES;
                [self.imgThreeInScrollview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapGuester:)]];
                [scrollView addSubview:self.imgThreeInScrollview];
                break;
        }
    }
    
    //初始化指针
    middlePointer = 0;
    leftPointer = (int)(imgArray.count - 1);
    rightPointer = (imgArray.count>1?1:0);
    
    [scrollView setContentOffset:CGPointMake(viewFrame.size.width, 0)];//设置初始值，使得显示的是正中间的位置

}

-(void)makeContentImgView:(JAsynImageView *)imgView andTheIndex:(int)index{
    if ([kJUtils isNetworkUrl:[NSString stringWithFormat:@"%@",[imgArray objectAtIndex:index]]]) {
        imgView.imageURL = [NSString stringWithFormat:@"%@",[imgArray objectAtIndex:index]];
    }else{
        imgView.image = [UIImage imageNamed:[imgArray objectAtIndex:index]];
    }
}

/**
 *  初始化底部文字的view
 */
-(void)initBottomTitleView:(NSArray *)countArray{
    self.bottomTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, viewFrame.size.height - kBottomTitleViewheight, viewFrame.size.width, kBottomTitleViewheight)];
    self.bottomTitleView.backgroundColor = [UIColor blackColor];
    self.bottomTitleView.alpha = 0.5;
    [self addSubview:self.bottomTitleView];
    
    //底部文字
    [self initBottomTitleLbl];
    
    //初始化pageControl
    [self initPageControl:countArray];
}

//底部显示的文字
-(void)initBottomTitleLbl{
    [self.bottomTitleLbl removeFromSuperview];
    self.bottomTitleLbl.frame         = CGRectMake(0, 0, self.bottomTitleView.frame.size.width, self.bottomTitleView.frame.size.height);
    self.bottomTitleLbl.font          = [UIFont systemFontOfSize:17.];
    self.bottomTitleLbl.text          = @"底部标题区域";
    self.bottomTitleLbl.textAlignment = NSTextAlignmentCenter;
    self.bottomTitleLbl.textColor     = [UIColor whiteColor];
    self.bottomTitleLbl.text          = [titleArray objectAtIndex:0];
    [self.bottomTitleView addSubview:self.bottomTitleLbl];
}

//初始化pageControl
-(void)initPageControl:(NSArray *)countArray{
    [self.pageControl removeFromSuperview];
    CGFloat pageControlX = self.bottomTitleView.frame.size.width - [countArray count]*kPageControlHeight -5; //默认右侧显示
    CGFloat height = 0;
    if(!self.pageControlHeight){
        //默认宽度
        height = kPageControlHeight;
    }else{
        //用户手动设置
        height = self.pageControlHeight;
    }
    switch (self.pageControlMode) {
        case pageControlLeft://pageControl在页面的左边
            pageControlX = [countArray count]*height + 5;
            break;
        case PageControlCenter://pageControl在页面的中间
            pageControlX = self.bottomTitleView.frame.size.width/2 -[countArray count]*height/2;
            break;
        default://pageControl在页面的右边 默认
            pageControlX = self.bottomTitleView.frame.size.width - [countArray count]*height -5;
            break;
    }
    self.pageControl.frame         = CGRectMake(pageControlX, self.bottomTitleView.frame.size.height/2-height/2, [countArray count]*height, height);
    self.pageControl.numberOfPages = [countArray count];
    [self.bottomTitleView addSubview:self.pageControl];
}

-(void)setBottomTitleViewHeight:(CGFloat)bottomTitleViewHeight{
    _bottomTitleViewHeight = bottomTitleViewHeight;
    
    //重新定义新的高度
    CGRect rect                = self.bottomTitleView.frame;
    rect.origin.y              = viewFrame.size.height - _bottomTitleViewHeight;
    rect.size.height           = _bottomTitleViewHeight;
    self.bottomTitleView.frame = rect;
    
    //重新设置底部文字的高度
    [self initBottomTitleLbl];
}
/**
 *  初始化轮播
 */
-(void)autoCycleAction{
    [cycleTimer invalidate];
    cycleTimer = nil;
    if (self.isAutoCycle == AutoCycle) {
        //自动滚动
        switch (self.cycleMode) {
            case LimitedCycle://有限轮播下的自动滚动
                cycleTimer = [NSTimer timerWithTimeInterval:self.autoTimeInterval target:self selector:@selector(timerRepeatActionInLimitedCycleMode) userInfo:nil repeats:YES];
                break;
            default:
                cycleTimer = [NSTimer timerWithTimeInterval:self.autoTimeInterval target:self selector:@selector(timerRepeatActionInEndlessCycleMode) userInfo:nil repeats:YES];
                break;
        }
        [[NSRunLoop currentRunLoop]addTimer:cycleTimer forMode:NSDefaultRunLoopMode];
    }
}

#pragma mark -helper functions

/**
 *  重新设置ImgView的ContentMode
 */
-(void)resetImgModeInScrollView{
    for (int i = 0; i<imgArray.count; i++) {
        if (self.imgModeInJADCycleView != ScaleToFit) {
            self.imgOneInScrollview.contentMode = UIViewContentModeScaleAspectFill;
            self.imgTwoInScrollview.contentMode = UIViewContentModeScaleAspectFill;
            self.imgThreeInScrollview.contentMode = UIViewContentModeScaleAspectFill;
        }else{
            self.imgOneInScrollview.contentMode = UIViewContentModeScaleAspectFit;
            self.imgTwoInScrollview.contentMode = UIViewContentModeScaleAspectFit;
            self.imgThreeInScrollview.contentMode = UIViewContentModeScaleAspectFit;
        }
    }
}

/**
 *  将数据源数组添加首尾元素
 *
 *  @param middleArray 数据源数组
 *
 *  @return 第一个元素为数据源数组的最后一个 中间为数据源数组 最后一元素是数据源数组的第一个元素
 */
-(NSArray *)addHeaderAndFooterArray:(NSArray *)middleArray{
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    if (!middleArray||([middleArray count]==0)) {
        return nil;
    }
    [temp addObject:[middleArray lastObject]]; //左侧添加最后一个元素
    for (int i=0; i<middleArray.count; i++) {
        [temp addObject:[middleArray objectAtIndex:i]];
    }
    [temp addObject:[middleArray firstObject]]; //右侧添加第一个元素
    
    return temp;
}
//设置点击的动作
-(void)imageTapGuester:(UIGestureRecognizer *)sender{
    switch (self.cycleMode) {
        case LimitedCycle: //有限循环
            [self initTapBlock:currentPage];
            break;
        default://无限循环
            [self initTapBlock:middlePointer];
            break;
    }
}
-(void)initTapBlock:(int)index{
    if (self.imageSelected) {
        self.imageSelected(index);
    }
}


/**
 *  有限轮播下的timer动作
 */
-(void)timerRepeatActionInLimitedCycleMode{
    [self.scrollView setContentOffset:CGPointMake(((currentPage+1)%imgArray.count)*viewFrame.size.width, 0) animated:YES];
}

/**
 *  无限轮播下的timer动作
 */
-(void)timerRepeatActionInEndlessCycleMode{
    [self.scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x+viewFrame.size.width,0) animated:YES];
}

//-(NSArray *)countArray{
//    NSMutableArray *temp = [[NSMutableArray alloc]init];
//    switch (self.cycleMode) {
//        case LimitedCycle:
//            return imgArray;
//            break;
//        default:
//            if (imgArray.count<3) {
//                return nil;
//                break;
//            }
//            for (int i =0; i<imgArray.count-2; i++) {
//                [temp addObject:imgArray[i]];
//            }
//            return temp;
//            break;
//    }
//}

#pragma mark -set methods
-(void)setImgModeInJADCycleView:(ImgModeInJADCycleView)imgModeInJADCycleView{
    _imgModeInJADCycleView = imgModeInJADCycleView;
    
    [self resetImgModeInScrollView];
}


//重制pagecontrol时需要进行布局上的重新定制
-(void)setPageControlHeight:(CGFloat)pageControlHeight{
    _pageControlHeight = pageControlHeight;

    [self initPageControl:imgArray];
}

//调整pagecontrol的时候进行调整
-(void)setPageControlMode:(PageControlMode)pageControlMode{
    _pageControlMode = pageControlMode;
    
    [self initPageControl:imgArray];
}

-(void)setAutoTimeInterval:(NSTimeInterval)autoTimeInterval{
    _autoTimeInterval = autoTimeInterval;
    
    [self autoCycleAction];
}


#pragma mark -lazy load
-(UILabel *)bottomTitleLbl{
    if (_bottomTitleLbl == nil) {
        _bottomTitleLbl = [[UILabel alloc]init];
        [self.bottomTitleView addSubview:_bottomTitleLbl];
    }
    return _bottomTitleLbl;
}

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        [self.bottomTitleView addSubview:_pageControl];
    }
    return _pageControl;
}
@end
