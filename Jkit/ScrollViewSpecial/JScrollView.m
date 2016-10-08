//
//  JScrollView.m
//  JKit
//
//  Created by Jacky on 16/9/9.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JScrollView.h"
#import "JAsynImageView.h"
#import "JUtils.h"

@interface JScrollView()<UIScrollViewDelegate>{
    float pageWidth;
    float pageHalfPadding;
    
    float direction; //记录滑动的方向
    float oringinOffsetX; //原先的偏移X
    
    //用于判断读取位置的指针
    int preMiddleTwo;
    int preMiddleOne;
    int middle;
    int afterMiddleOne;
    int afterMiddleTwo;
}

@property (nonatomic,strong) UIScrollView *scrollView;

//添加五个imageView
@property (nonatomic,strong) UIImageView *middleImg;
@property (nonatomic,strong) UIImageView *preMiddleOneImg;
@property (nonatomic,strong) UIImageView *preMiddleTwoImg;
@property (nonatomic,strong) UIImageView *afterMiddleTwoImg;
@property (nonatomic,strong) UIImageView *afterMiddleOneImg;

@end

@implementation JScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        pageWidth = kScreenWidth*0.8;
        pageHalfPadding = 0.1*kScreenWidth;
        direction = 0;
        oringinOffsetX = 0;
        
        //模拟数据初始化
        self.dataSource = [[NSArray alloc]initWithObjects:@"JADCycleTest1",@"JADCycleTest2",@"JADCycleTest3",@"JADCycleTest1",@"JADCycleTest2",@"JADCycleTest3",@"JADCycleTest1",@"JADCycleTest2",@"JADCycleTest3", nil];
        
        //初始化现在的指针
        middle = 0;
        preMiddleOne = (unsigned)[self.dataSource count]-1;
        preMiddleTwo = (unsigned)([self.dataSource count] -1 + self.dataSource.count - 1)% self.dataSource.count;
        afterMiddleOne = (0+1)%self.dataSource.count;
        afterMiddleTwo = (0+2)%self.dataSource.count;
        
        NSLog(@"输出现在的各个参数的值middle:%d,preMiddleOne:%d,preMiddleTwo:%d,afterMiddleOne:%d,afterMiddleTwo:%d,",middle,preMiddleOne,preMiddleTwo,afterMiddleOne,afterMiddleTwo);
        
        [self addSubview:self.scrollView];
        //初始化界面
        [self initScrollViewData:preMiddleTwo AndPositionIndex:0 AndImageView:self.preMiddleTwoImg];
        [self initScrollViewData:preMiddleOne AndPositionIndex:1 AndImageView:self.preMiddleOneImg];
        [self initScrollViewData:middle AndPositionIndex:2 AndImageView:self.middleImg];
        [self initScrollViewData:afterMiddleOne AndPositionIndex:3 AndImageView:self.afterMiddleOneImg];
        [self initScrollViewData:afterMiddleTwo AndPositionIndex:4 AndImageView:self.afterMiddleTwoImg];
    
        [self.scrollView setContentOffset:CGPointMake(-pageHalfPadding + pageWidth*2, 0)];
        
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}

#pragma mark - oberver action
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.scrollView.contentOffset.x == (pageWidth*3 - pageHalfPadding)) {//向左移动
        NSLog(@"向左移动");
    }
    if (self.scrollView.contentOffset.x == pageWidth - pageHalfPadding){//向右移动
        //NSLog(@"向右移动");
        NSLog(@"输出现在的各个参数的值middle:%d,preMiddleOne:%d,preMiddleTwo:%d,afterMiddleOne:%d,afterMiddleTwo:%d,",middle,preMiddleOne,preMiddleTwo,afterMiddleOne,afterMiddleTwo);
        //进行界面的重置
        afterMiddleTwo = afterMiddleOne;
        afterMiddleOne = middle;
        middle = preMiddleOne;
        preMiddleOne = preMiddleTwo;
        preMiddleTwo = (preMiddleTwo+self.dataSource.count -1)%self.dataSource.count;
        
        self.preMiddleOneImg.image = [UIImage imageNamed:self.dataSource[preMiddleOne]];
        self.preMiddleTwoImg.image = [UIImage imageNamed:self.dataSource[preMiddleTwo]];
        self.middleImg.image = [UIImage imageNamed:self.dataSource[middle]];
        self.afterMiddleOneImg.image = [UIImage imageNamed:self.dataSource[afterMiddleOne]];
        self.afterMiddleTwoImg.image = [UIImage imageNamed:self.dataSource[afterMiddleTwo]];
        
        [self.scrollView setContentOffset:CGPointMake(-pageHalfPadding + pageWidth*2, 0)];
        
        
    }
    
    
}


#pragma mark -private
-(void)initScrollViewData:(int)pointerIndex AndPositionIndex:(int)positionIndex AndImageView:(UIImageView *)imageView{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(pageWidth*positionIndex, 0, kScreenWidth*0.8, 200)];
    imageView.image = [UIImage imageNamed:[self.dataSource objectAtIndex:pointerIndex]];
    [self.scrollView addSubview:imageView];
}

#pragma mark -Scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    direction = self.scrollView.contentOffset.x - oringinOffsetX;
    oringinOffsetX = self.scrollView.contentOffset.x;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self customPage:self.scrollView];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self customPage:self.scrollView];
}
- (void)customPage:(UIScrollView *)scrollView{
    NSInteger index = (scrollView.contentOffset.x + pageWidth)/pageWidth;
    if (direction > 0) {
        if(index < 4){
            [scrollView setContentOffset:CGPointMake(index * pageWidth - pageHalfPadding, 0) animated:YES];
        }else{
            [scrollView setContentOffset:CGPointMake(4 * pageWidth - pageHalfPadding, 0) animated:YES];
        }
    }else{
        if ((index - 1)>0) {
            [scrollView setContentOffset:CGPointMake((index-1) * pageWidth - pageHalfPadding, 0) animated:YES];
        }else{
            [self.scrollView setContentOffset:CGPointMake(-pageHalfPadding, 0) animated:YES];
        }
    }
}



#pragma mark -lazy load
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.contentSize = CGSizeMake(pageWidth*5, 200);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

@end
