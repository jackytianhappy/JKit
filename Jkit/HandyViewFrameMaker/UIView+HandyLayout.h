//
//  UIView+HandyLayout.h
//  JKit
//
//  Created by Jacky on 16/8/12.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 手动布局代码适配准则，目前UI，UE基本只出iPhone 5 尺寸的的图
 * 此扩展类的实现控件适配的方式：iphone4，5采用同一套尺寸
 * iPhone 6与plus 横宽比与iPhone 5等比例缩放即可
 * 各版本比例
 * iPhone5，    AutolayoutScaleX = 1，AutolayoutScaleY = 1；
 * iPhone6，    AutolayoutScaleX = 1.171875，AutolayoutScaleY = 1.17429577；
 * iPhone6Plus，AutolayoutScaleX = 1.29375， AutolayoutScaleY = 1.295774；
 */
#define Delegate_Autolayout     ([[UIApplication sharedApplication] delegate])
#define ScreenWidth_Autolayout  ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight_Autolayout ([[UIScreen mainScreen] bounds].size.height)
#define ScaleX_Autolayout ((ScreenHeight_Autolayout > 480.0) ? (ScreenWidth_Autolayout / 320.0) : 1.0)
#define ScaleY_Autolayout ((ScreenHeight_Autolayout > 480.0) ? (ScreenHeight_Autolayout / 568.0) : 1.0)


CG_INLINE CGRect
CGRectMakeAutolayout(CGFloat x, CGFloat y, CGFloat width, CGFloat height, BOOL layoutWidth, BOOL layoutHeight)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = y;
    rect.size.width = (layoutWidth ? (width * ScaleX_Autolayout) : width);
    rect.size.height = (layoutHeight ? (height * ScaleY_Autolayout) : height);
    
    return rect;
}

CG_INLINE CGFloat
GetHeightAutolayout(CGFloat height)
{
    CGFloat autoHeight = height * ScaleY_Autolayout;
    return autoHeight;
}

CG_INLINE CGFloat
GetWidthAutolayout(CGFloat width)
{
    CGFloat autoWidth = width * ScaleX_Autolayout;
    return autoWidth;
}

CG_INLINE CGFloat
CGRectGetMinXAutolayout(CGRect rect)
{
    CGFloat x = rect.origin.x * ScaleX_Autolayout;
    return x;
}

CG_INLINE CGFloat
CGRectGetMinYAutolayout(CGRect rect)
{
    CGFloat y = rect.origin.y * ScaleX_Autolayout;
    return y;
}

CG_INLINE CGFloat
CGRectGetWidthAutolayout(CGRect rect)
{
    CGFloat width = rect.size.width * ScaleX_Autolayout;
    return width;
}

CG_INLINE CGFloat
CGRectGetHeightAutolayout(CGRect rect)
{
    CGFloat height = rect.size.height * ScaleX_Autolayout;
    return height;
}

CG_INLINE CGPoint
CGPointMakeAutolayout(CGFloat x, CGFloat y)
{
    CGPoint point;
    point.x = x * ScaleX_Autolayout;
    point.y = y * ScaleY_Autolayout;
    
    return point;
}

CG_INLINE CGSize
CGSizeMakeAutolayout(CGFloat width, CGFloat height)
{
    CGSize size;
    size.width = width * ScaleX_Autolayout;
    size.height = height * ScaleY_Autolayout;
    
    return size;
}


@interface UIView (HandyLayout)
//纯手动访问元素布局等属性
//简化常用属性访问
-(CGFloat)width;
-(CGFloat)height;
-(CGFloat)x;
-(CGFloat)y;
-(CGPoint)origin;

-(CGFloat)centerX;
-(CGFloat)centerY;

-(CGFloat)top;
-(CGFloat)left;
-(CGFloat)right;
-(CGFloat)bottom;

//简化常用属性赋值
//view的宽度
-(void)setWidth:(CGFloat)width;
-(void)setWidthEqualToView:(UIView *)view;

//view的高度
-(void)setHeight:(CGFloat)height;
-(void)setHeightEqualToView:(UIView *)view;

//view的起始位置x
-(void)setX:(CGFloat)x;
-(void)setXEqualToView:(UIView *)view;

//view的y的位置
-(void)setY:(CGFloat)y;
-(void)setYEqualToView:(UIView *)view;

//view的origin改变
-(void)setOrigin:(CGPoint)point;
-(void)setOriginEqualToView:(UIView *)view;

//改变view的centerX
-(void)setCenterX:(CGFloat)centerX;
-(void)setCenterXEqualToView:(UIView *)view;

//改变view的centerY
-(void)setCenterY:(CGFloat)centerY;
-(void)setCenterYEqualToView:(UIView *)view;

//改变view的center位置
-(void)setCenterPoint:(CGPoint)centerPoint;
-(void)setCenterEqualToView:(UIView *)view;

//两者在同一坐标系下的情况
//改变顶部位置的间距
-(void)setTop:(CGFloat)top fromView:(UIView *)view;

//改变左侧位置的间距
-(void)setLeft:(CGFloat)left fromView:(UIView *)view;

//改变右侧位置的间距
-(void)setRight:(CGFloat)right fromView:(UIView *)view;

//改变下方位置的间距
-(void)setBottom:(CGFloat)bottom fromView:(UIView *)view;





@end
