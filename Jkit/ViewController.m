//
//  ViewController.m
//  JKit
//
//  Created by Jacky on 16/7/19.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "ViewController.h"
#import "JTagListViewDemo.h"
#import "JADCycleViewDemo.h"
#import "JAsynImageView.h"
#import "JAsynImageViewDemo.h"
#import "JCycleLoading.h"
#import "JCycleLoadingDemo.h"
#import "LabelAdjustWidth.h"
#import "UIView+HandyLayout.h"
#import "JButton/JButton.h"
#import "JScrollView.h"


@interface ViewController(){
    JCycleLoading *cycle;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //演示JTagListView
    //[self initJTagListView];
    
    //演示JADCycleView ,.,.,.,
    //[self initJADCycleView];

    //演示本地库异步加载图片
    //[self initJAsynImage];
    
    //演示画圆环
    //[self initJCycleLoading];
    
    //label自适应布局的演示
    //[self initWithLabelAdjustWidth];
    
    
    //手动布局框架
    //[self testTheAutoLayout];
    
    //自定义button
    //[self JButtonDemo];
    
    //初始化轮转图
    [self initJScrollView];
    
}


/**
 *  初始化轮转demo 两遍留白的空间
 */
-(void)initJScrollView{
    
//    NSArray *nameArray = [[NSArray alloc]initWithObjects:@"JADCycleTest1",@"JADCycleTest2",@"JADCycleTest3", nil];
//    
//    JScrollView *scrollview = [[JScrollView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 200) AndDataSource:nameArray];
//    [self.view addSubview:scrollview];
    
    
    JScrollView *jscrollView = [[JScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    [self.view addSubview:jscrollView];
    
}

/**
 *  label 自适应
 */
-(void)initWithLabelAdjustWidth{
    LabelAdjustWidth *label = [[LabelAdjustWidth alloc]initWithFrame:self.view.frame];
    [self.view addSubview:label];
}

/**
 *  旋转等待控件
 */
-(void)initJCycleLoading{
    JCycleLoadingDemo *demo = [[JCycleLoadingDemo alloc]initWithFrame:self.view.frame];
    [self.view addSubview:demo];
}

/**
 *  测试异步加载图片
 */
-(void)initJAsynImage{
    JAsynImageViewDemo *view =  [[JAsynImageViewDemo alloc]initWithFrame:self.view.frame];
    [self.view addSubview:view];
}

/**
 *  初始化tagView
 */
-(void)initJTagListView{
    JTagListViewDemo *tagDemo = [[JTagListViewDemo alloc]initWithFrame:self.view.frame];
    [self.view addSubview:tagDemo];
}

/**
 *  初始化广告轮转页
 */
-(void)initJADCycleView{
    JADCycleViewDemo *adDemo = [[JADCycleViewDemo alloc]initWithFrame:self.view.frame];
    [self.view addSubview:adDemo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testTheAutoLayout{
    //手动布局框架
    //UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 100, 200)];
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMakeAutolayout(0,0,100,100,true,true)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    NSLog(@"输出现在的比例值:%f",ScaleX_Autolayout);
    NSLog(@"输出现在的最大值:%f",CGRectGetWidth(view.frame));
    
    //输出常用属性值 通过
    //    NSLog(@"输出现在的width%f",view.width);
    //    NSLog(@"输出现在的height%f",view.height);
    //    NSLog(@"输出现在的y%f",view.y);
    //    NSLog(@"输出现在的x%f",view.x);
    //    NSLog(@"输出现在的originx%f",view.origin.x);
    //    NSLog(@"输出现在的originy%f",view.origin.y);
    //    NSLog(@"输出现在的centerX%f",view.centerX);
    //    NSLog(@"输出现在的centerY%f",view.centerY);
    //    NSLog(@"输出现在的top%f",view.top);
    //    NSLog(@"输出现在的left%f",view.left);
    //    NSLog(@"输出现在的right%f",view.right);
    //    NSLog(@"输出现在的bottom%f",view.bottom);
    
    //    view.width = 200; //通过
    //    view.height = 100; //通过
    //    view.x = 100; //通过
    //    view.y = 100; //通过
    //    view.origin = CGPointMake(100, 100); //通过
    //    view.centerX = 0;//通过
    //    view.centerY = 0;//通过
    //    view.top = 90; //通过
    //    view.bottom = 200;//通过
    //    view.left = 0;//通过
    //    view.right = 100;//通过
    //    [view setWidthEqualToView:self.view];//通过
    //    [view setHeightEqualToView:self.view];//通过
    //    [view setXEqualToView:self.view];//通过
    //    [view setCenterPoint:CGPointMake(self.view.center.x, self.view.center.y)];//通过
    //    [view setYEqualToView:self.view];//通过
    //    [view setOriginEqualToView:self.view];//通过
    //    [view setCenterXEqualToView:self.view];//通过
    //    [view setCenterYEqualToView:self.view]; //通过
    //    [view setCenterEqualToView:self.view];//通过
    
    //    [view setTop:20 fromView:self.view];//通过
    //    [view setLeft:20 fromView:self.view];//通过
    //    [view setRight:20 fromView:self.view];//通过
    //    [view setBottom:20 fromView:self.view]; //通过
    

    //    ScaleX_Autolayout 横向变化的比例
    //    ScaleY_Autolayout 纵向变化比例
    
    //    此方法覆盖CGRectmake方法，会根据屏幕尺寸进行放大缩小 bool型的值用于控制该方向上是否进行放缩
    //    CGRectMakeAutolayout(CGFloat x, CGFloat y, CGFloat width, CGFloat height, BOOL layoutWidth, BOOL layoutHeight)
    
    
    //  计算放缩后的高度
    //  GetHeightAutolayout(CGFloat height)
    
    //    GetWidthAutolayout(CGFloat width)
    //    CGRectGetMinXAutolayout(CGRect rect)
    //    CGRectGetMinYAutolayout(CGRect rect)
    //    CGRectGetWidthAutolayout(CGRect rect)
    //    CGRectGetHeightAutolayout(CGRect rect)
    //    CGPointMakeAutolayout(CGFloat x, CGFloat y)
    //    CGSizeMakeAutolayout(CGFloat width, CGFloat height)
}


-(void)JButtonDemo{
    JButton *btn             = [[JButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100) title:@"测试案例" iamge:[UIImage imageNamed:@"JADCycleTest2"] handler:^(UIButton *sender) {
        NSLog(@"你点击了这张图片");
    }];
    btn.imageView.contentMode = UIViewContentModeScaleToFill;//设置图片的显示方式
    //btn.direction = Horizontal; //设置水平方向 水平方向显示按钮一般按钮前方有个icon，可设置图片右对齐，文字左对齐以达到效果
    //btn.titleLabel.textAlignment = NSTextAlignmentLeft; //水平方向时进行调整字体对其方式
    //btn.titleLabel.font = [UIFont systemFontOfSize:5];
    btn.backgroundColor       = [UIColor redColor];
    [self.view addSubview:btn];
    
    
    JButton *btn1             = [[JButton alloc]initWithFrame:CGRectMake(120, 100, 100, 100) title:@"测试案例" iamge:[UIImage imageNamed:@"JADCycleTest2"] handler:^(UIButton *sender) {
        NSLog(@"你点击了这张图片1");
    }];
    btn1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn1.backgroundColor       = [UIColor redColor];
    [self.view addSubview:btn1];
    
    
    JButton *btn2             = [[JButton alloc]initWithFrame:CGRectMake(240, 100, 100, 100) title:@"测试案例" iamge:[UIImage imageNamed:@"JADCycleTest2"] handler:^(UIButton *sender) {
        NSLog(@"你点击了这张图片1");
    }];
    btn2.lblRatio              = 0.5;
    btn2.titleLabel.font       = [UIFont systemFontOfSize:17];
    btn2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:btn2];
    
    
    //水平方向
    JButton *btn3       = [[JButton alloc]initWithFrame:CGRectMake(0, 220, 100, 30) title:@"测试案例" iamge:[UIImage imageNamed:@"JADCycleTest2"] handler:^(UIButton *sender) {
        NSLog(@"你点击了这张图片");
    }];
    btn3.direction       = Horizontal;//设置水平方向 水平方向显示按钮一般按钮前方有个icon，可设置图片右对齐，文字左对齐以达到效;
    btn3.titleLabel.font = [UIFont systemFontOfSize:15];
    btn3.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn3];
    
    
    JButton *btn4             = [[JButton alloc]initWithFrame:CGRectMake(0, 220, 100, 30) title:@"测试案例" iamge:[UIImage imageNamed:@"JADCycleTest2"] handler:^(UIButton *sender) {
        NSLog(@"你点击了这张图片");
    }];
    btn4.direction             = Horizontal;//设置水平方向 水平方向显示按钮一般按钮前方有个icon，可设置图片右对齐，文字左对齐以达到效;
    btn4.layer.cornerRadius    = 5;
    btn4.layer.masksToBounds   = YES;
    btn4.imageView.contentMode = UIViewContentModeRight;
    btn4.titleLabel.font       = [UIFont systemFontOfSize:15];
    btn4.backgroundColor       = [UIColor redColor];
    [self.view addSubview:btn4];
    
    
    JButton *btn5                = [[JButton alloc]initWithFrame:CGRectMake(120, 220, 100, 30) title:@"测试案例" iamge:[UIImage imageNamed:@"JADCycleTest2"] handler:^(UIButton *sender) {
        NSLog(@"你点击了这张图片");
    }];
    btn5.direction                = Horizontal;//设置水平方向 水平方向显示按钮一般按钮前方有个icon，可设置图片右对齐，文字左对齐以达到效;
    btn5.lblRatio                 = 0.4;
    [btn5 setBackgroundImage:[UIImage imageNamed:@"JADCycleTest1"] forState:UIControlStateNormal];
    btn.imageView.contentMode     = UIViewContentModeScaleAspectFit;
    btn5.titleLabel.font          = [UIFont systemFontOfSize:11];
    btn5.backgroundColor          = [UIColor redColor];
    btn5.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn5.padding                  = 5; //设置左侧的边距
    [self.view addSubview:btn5];
}

@end

