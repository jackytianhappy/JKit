//
//  UIView+HandyLayout.m
//  JKit
//
//  Created by Jacky on 16/8/12.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "UIView+HandyLayout.h"

@implementation UIView (HandyLayout)

//简化常用属性访问与修改
-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(CGFloat)centerX{
    return self.center.x;
}

-(CGFloat)centerY{
    return self.center.y;
}

-(CGFloat)top{
    return self.frame.origin.y;
}

-(CGFloat)left{
    return self.frame.origin.x;
}

-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}


//修改常用属性
//view的宽度
-(void)setWidth:(CGFloat)width{
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    self.frame   = frame;
}

-(void)setWidthEqualToView:(UIView *)view{
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, view.frame.size.width, self.frame.size.height);
    self.frame   = frame;
}

//view的高度
-(void)setHeight:(CGFloat)height{
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    self.frame   = frame;
}
-(void)setHeightEqualToView:(UIView *)view{
    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width , view.frame.size.height);
    self.frame   = frame;
}

//view的x的位置
-(void)setX:(CGFloat)x{
    CGRect frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.frame   = frame;
}
-(void)setXEqualToView:(UIView *)view{
    CGRect frame = CGRectMake(view.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.frame   = frame;
}


//view的y的位置
-(void)setY:(CGFloat)y{
    CGRect frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
    self.frame   = frame;
}
-(void)setYEqualToView:(UIView *)view{
    CGRect frame = CGRectMake(self.frame.origin.x, view.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.frame   = frame;
}


//view的origin改变
-(void)setOrigin:(CGPoint)point{
    CGRect frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
    self.frame   = frame;
}
-(void)setOriginEqualToView:(UIView *)view{
    CGRect frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, self.frame.size.width, self.frame.size.height);
    self.frame   = frame;
}

//view改变center的位置
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x       = centerX;
    self.center    = center;
}
-(void)setCenterXEqualToView:(UIView *)view{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.x       = view.center.x;
    self.center    = center;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y       = centerY;
    self.center    = center;
}
-(void)setCenterYEqualToView:(UIView *)view{
    CGPoint center = CGPointMake(self.centerX, self.centerY);
    center.y       = view.center.y;
    self.center    = center;
}
-(void)setCenterPoint:(CGPoint)centerPoint{
    CGPoint center = CGPointMake(self.frame.origin.x, self.frame.origin.y);
    center.y       = centerPoint.y;
    center.x       = centerPoint.x;
    self.center    = center;
}
-(void)setCenterEqualToView:(UIView *)view{
    CGPoint center = CGPointMake(self.frame.origin.x, self.frame.origin.y);
    center.y       = view.center.y;
    center.x       = view.center.x;
    self.center    = center;
}

//改变上下左右间距
-(void)setTop:(CGFloat)top fromView:(UIView *)view{
    self.y = view.bottom + top;
}
-(void)setBottom:(CGFloat)bottom fromView:(UIView *)view{
    self.y = view.top - bottom - self.height;
}
-(void)setLeft:(CGFloat)left fromView:(UIView *)view{
    self.x = view.right + left;
}
-(void)setRight:(CGFloat)right fromView:(UIView *)view{
    self.x = view.left - right - self.width;
}

@end
