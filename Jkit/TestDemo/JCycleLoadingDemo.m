//
//  JCycleLoadingDemo.m
//  JKit
//
//  Created by Jacky on 16/7/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JCycleLoadingDemo.h"
#import "JCycleLoading.h"


@interface JCycleLoadingDemo(){
    JCycleLoading *cycle;
}

@property (nonatomic,strong) UITextField *selfDefineRadius;

@property (nonatomic,strong) UITextField *selfDefineFinishTime;

@property (nonatomic,strong) UITextField *selfFinishNumber;

@property (nonatomic,strong) UITextField *selfUnit;

@property (nonatomic,strong) UIButton *animationBtn;

@end

@implementation JCycleLoadingDemo

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initTheCustomerControl];
        
        [self initTheCycleLoadingView];
    }
    return self;
}

-(void)disAppearTheKeyboard{
    [self.selfDefineRadius resignFirstResponder];
    [self.selfDefineFinishTime resignFirstResponder];
    [self.selfFinishNumber resignFirstResponder];
    [self.selfUnit resignFirstResponder];
}

-(void)initTheCustomerControl{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disAppearTheKeyboard)]];
    
    self.selfDefineRadius.placeholder  = @"请输入圆的半径";
    self.selfDefineRadius.keyboardType = UIKeyboardTypeNumberPad;
    self.selfDefineRadius.borderStyle  = UITextBorderStyleBezel;
    
    self.selfDefineFinishTime.placeholder  = @"请输入动画执行时间";
    self.selfDefineFinishTime.keyboardType = UIKeyboardTypeNumberPad;
    self.selfDefineFinishTime.borderStyle  = UITextBorderStyleBezel;
    
    self.selfFinishNumber.placeholder  = @"请输入中间最大数";
    self.selfFinishNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.selfFinishNumber.borderStyle  = UITextBorderStyleBezel;
    
    self.selfUnit.placeholder = @"请输入单位（可选）";
    self.selfUnit.borderStyle = UITextBorderStyleBezel;

    [self.animationBtn setTitle:@"重新绘制(其他属性不列举)" forState:UIControlStateNormal];
    [self.animationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.animationBtn setBackgroundColor:[UIColor blueColor]];
    [self.animationBtn addTarget:self action:@selector(reDraw) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)reDraw{
    [cycle removeFromSuperview];
    cycle = nil;

    CGFloat radius       = [self.selfDefineRadius.text floatValue];
    CGFloat finishTime   = [self.selfDefineFinishTime.text floatValue];
    CGFloat finishNumber = [self.selfFinishNumber.text floatValue];
    
    cycle = [[JCycleLoading alloc]initWithFrame:CGRectMake(0, 200, self.frame.size.width, 200) radius:radius finshTime:finishTime AndFinishNumber:finishNumber];
    [self addSubview:cycle];
    
    if (self.selfUnit) {
        cycle.unit = self.selfUnit.text;
    }
    
    //自定义字体大小
    [cycle startAnimation];
    
}


-(void)initTheCycleLoadingView{
    cycle = [[JCycleLoading alloc]initWithFrame:CGRectMake(0, 200, self.frame.size.width, 200) radius:100 finshTime:2 AndFinishNumber:2000];
    [self addSubview:cycle];
    /////////////界面属性的设置必须在动画执行之前 可选///////////////////////
    cycle.cycleLineWidth        = 7;//可选 默认5
    cycle.unit                  = @"元";//可选 数字后面的单位
    cycle.countLbl.font         = [UIFont systemFontOfSize:17];//可选 设置字体颜色等等信息
    cycle.countLbl.textColor    = [UIColor blueColor];//可选 设置字体颜色等等信息 默认黑色
    cycle.backgroundColor       = [UIColor clearColor];//可选 默认透明色
    cycle.cycleLineColor        = [UIColor purpleColor];//可选 根据美工选择色彩 默认红色
    cycle.centetBgImgView.image = [UIImage imageNamed:@"JADCycleTest1"];//可选 开发者根据美工提供的图片设置 为圆形背景图 默认透
    //cycle.cycleInnerColor = [UIColor yellowColor];//可选 与背景图片根据美工需求
    /////////////界面属性的设置必须在动画执行之前 可选///////////////////////
    [cycle startAnimation];
    
}


#pragma mark -lazy load 
-(UITextField *)selfDefineRadius{
    if (_selfDefineRadius == nil) {
        _selfDefineRadius = [[UITextField alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width/2 -40, 40)];
        [self addSubview:_selfDefineRadius];
    }
    return _selfDefineRadius;
}

-(UITextField *)selfDefineFinishTime{
    if (_selfDefineFinishTime == nil) {
        _selfDefineFinishTime = [[UITextField alloc]initWithFrame:CGRectMake(self.frame.size.width/2+20, CGRectGetMinY(_selfDefineRadius.frame),  self.frame.size.width/2 -40, 40)];
        [self addSubview:_selfDefineFinishTime];
    }
    return _selfDefineFinishTime;
}

-(UITextField *)selfFinishNumber{
    if (_selfFinishNumber == nil) {
        _selfFinishNumber = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.selfDefineRadius.frame)+10, self.frame.size.width/2 -40, 40)];
        [self addSubview:_selfFinishNumber];
    }
    return _selfFinishNumber;
}

-(UITextField *)selfUnit{
    if (_selfUnit == nil) {
        _selfUnit = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selfFinishNumber.frame)+40, CGRectGetMinY(self.selfFinishNumber.frame),self.frame.size.width/2 -40, 40)];
        
        [self addSubview:_selfUnit];
        
    }
    return _selfUnit;
}


-(UIButton *)animationBtn{
    if (_animationBtn == nil) {
        _animationBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.selfUnit.frame)+10, self.frame.size.width-40, 40)];
        
        [self addSubview:_animationBtn];
        
    }
    return _animationBtn;
}

@end

