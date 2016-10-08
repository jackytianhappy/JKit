//
//  JCycleLoading.m
//  JKit
//
//  Created by Jacky on 16/7/26.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JCycleLoading.h"

@interface JCycleLoading(){
    NSTimeInterval durationTime;
    CGFloat numberCount;
    CGFloat cycleRadius;
    CGFloat countTime;
    CGRect viewFrame;
}
@property (nonatomic,strong) CAShapeLayer *progressLayer;

@property (nonatomic,strong) NSTimer      *timer;

@end

@implementation JCycleLoading

-(instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius finshTime:(NSTimeInterval )totalTime AndFinishNumber:(CGFloat )totalCount{
    if (self = [super initWithFrame:frame]) {
        countTime    = 0;
        viewFrame    = frame;
        durationTime = totalTime;
        numberCount  = totalCount;
        cycleRadius  = radius;
        
    }
    return self;
}

-(void)startAnimation{
    //外部线段区域
    [self addTheCycleLine];
    [self addTheCycleLineAnimation];
    
    //中间背景图片的区域
    [self addTheCenterView];
    
    //内部数字区域
    [self addTheNumber];
    
    [self bringSubviewToFront:self.countLbl];
}

/**
 *  添加中间的背景区域
 */
-(void)addTheCenterView{
    _centetBgImgView.layer.masksToBounds = YES;
    _centetBgImgView.layer.cornerRadius  = _centetBgImgView.frame.size.width/2;
}

/**
 *  添加圆圈的线
 */
-(void)addTheCycleLine{
    self.progressLayer      = [CAShapeLayer layer];
    if (cycleRadius) {
        self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewFrame.size.width/2, viewFrame.size.height/2) radius:cycleRadius startAngle:-1*M_PI/2 endAngle:-5*M_PI/2 clockwise:NO].CGPath;
    }else{
        self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(viewFrame.size.width/2, viewFrame.size.height/2) radius:100 startAngle:-1*M_PI/2 endAngle:-5*M_PI/2 clockwise:NO].CGPath;
    }
    
    if (self.cycleInnerColor) {
        self.progressLayer.fillColor   = self.cycleInnerColor.CGColor;
    }else{
        self.progressLayer.fillColor   = [UIColor clearColor].CGColor;
    }

    if (self.cycleLineColor) {
        self.progressLayer.strokeColor = self.cycleLineColor.CGColor;
    }else{
        self.progressLayer.strokeColor = [UIColor redColor].CGColor;
    }

    if (self.cycleLineWidth) {
        self.progressLayer.lineWidth   = self.cycleLineWidth;
    }else{
        self.progressLayer.lineWidth   = 5;
    }
    
    self.progressLayer.lineCap  = kCALineCapRound;
    self.progressLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:self.progressLayer];
}


/**
 *  添加圆圈线的动画
 */
-(void)addTheCycleLineAnimation{
    CABasicAnimation *pathAnimation   = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration            = durationTime;
    pathAnimation.fromValue           = @(0);
    pathAnimation.toValue             = @(1);
    pathAnimation.removedOnCompletion = YES;
    [self.progressLayer addAnimation:pathAnimation forKey:nil];
}

/**
 *添加中间的数字的布局区域
 */
-(void)addTheNumber{
    self.countLbl.text          = [self addTheLastStringOfNum:@"0"];
    self.countLbl.textAlignment = NSTextAlignmentCenter;
    self.timer                  = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(go) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

/**
 *  循环执行的操作
 */
-(void)go{
    countTime += 0.01;
    if (countTime >durationTime) {
        self.countLbl.text = [self addTheLastStringOfNum:[NSString stringWithFormat:@"%.2f",numberCount]];
        [self.timer invalidate];
        self.timer = nil;
        if ([self.countLbl.text isEqualToString:@"0.00"]) {
            self.countLbl.text = @"";
        }
        return;
    }
    self.countLbl.text = [self addTheLastStringOfNum:[NSString stringWithFormat:@"%.2f",countTime/durationTime*numberCount]];
    if ([self.countLbl.text isEqualToString:@"0.00"]) {
        self.countLbl.text = @"";
    }
}

#pragma mark - Helper function
/**
 *  辅助函数，拼接数字最后的单位
 *
 *  @param Number 数字
 *
 *  @return 数字+单位
 */
-(NSString *)addTheLastStringOfNum:(NSString *)Number{
    if (self.unit) {
        return [NSString stringWithFormat:@"%@%@",Number,self.unit];
    }else{
        return Number;
    }
}

#pragma mark - lazy load
-(UILabel *)countLbl{
    if (_countLbl == nil) {
        _countLbl = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - cycleRadius/sqrt(2), self.frame.size.height/2 - cycleRadius/sqrt(2), cycleRadius*sqrt(2), cycleRadius*sqrt(2))];
        [self addSubview:_countLbl];
    }
    return _countLbl;
}


-(UIImageView *)centetBgImgView{
    if (_centetBgImgView == nil) {
        _centetBgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(viewFrame.size.width/2-(cycleRadius - self.progressLayer.lineWidth/2), viewFrame.size.height/2-(cycleRadius - self.progressLayer.lineWidth/2), (cycleRadius - self.progressLayer.lineWidth/2)*2, (cycleRadius - self.progressLayer.lineWidth/2)*2)];
        [self addSubview:_centetBgImgView];
    }
    return _centetBgImgView;
}

@end
