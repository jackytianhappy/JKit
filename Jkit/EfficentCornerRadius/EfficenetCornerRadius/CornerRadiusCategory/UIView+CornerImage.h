//
//  UIView+CornerImage.h
//  JKit
//
//  Created by Jacky on 16/10/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

//裁剪成功后进行的回调
typedef void(^CornerImageCallback)(UIImage *cornerImage);


@interface UIView (CornerImage)

//默认0  仅对生成原型图片和矩形图片有效
@property (nonatomic, assign) CGFloat borderWidth;


//当小于0时，不会添加边框。默认为0.仅对生成圆形图片和矩形图片有效
@property (nonatomic, assign) CGFloat pathWidth;

//边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
@property (nonatomic, strong) UIColor *borderColor;

//Path颜色，默认为白色。仅对生成圆形图片和矩形图片有效
@property (nonatomic, strong) UIColor *pathColor;

/**
 *	内部默认是会缓存corner所生成的圆角或者添加曲线之类的，如果view需要动态地调整，则
 *  每次复用时，应该设置它为YES,则不会缓存。
 *  默认为NO
 */
@property (nonatomic, assign) BOOL shouldRefreshCache;


//如需要复用  异步裁剪后 得到的图片可做其他用途
-(void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;

//添加圆角
-(void)addCornerRadius:(CGFloat)cornerRadius;

-(void)addCornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize;

-(void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize backgroundColor:(UIColor *)backgroundColor;

-(UIImage *)setImage:(id)image size:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale onCliped:(CornerImageCallback)callback;

- (UIImage *)setImage:(id)image isEqualScale:(BOOL)isEqualScale onCliped:(CornerImageCallback)callback;

- (UIImage *)setCornerImage:(id)image
                           size:(CGSize)targetSize
                   isEqualScale:(BOOL)isEqualScale
                 backgrounColor:(UIColor *)backgroundColor
                       onCliped:(CornerImageCallback)callback;

// 背景颜色为白色
- (UIImage *)setCornerImage:(id)image
                           size:(CGSize)targetSize
                   isEqualScale:(BOOL)isEqualScale
                       onCliped:(CornerImageCallback)callback;
//控件本身大小已经确定
- (UIImage *)setCornerImage:(id)image
                   isEqualScale:(BOOL)isEqualScale
                       onCliped:(CornerImageCallback)callback;




- (UIImage *)setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
          backgroundColor:(UIColor *)backgroundColor
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(CornerImageCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认取最顶层父视图的背景色，若为透明，则取本身背景色，若也为透明，则取白色、isEqualScale=YES
 */
- (UIImage *)setImage:(id)image
                     size:(CGSize)targetSize
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(CornerImageCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认取最顶层父视图的背景色，若为透明，则取本身背景色，若也为透明，则取白色。如果控件本身大小确定，
 * 可以直接使用此API来生成与控件大小相同的图片来填充。
 */
- (UIImage *)setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
             isEqualScale:(BOOL)isEqualScale
                 onCliped:(CornerImageCallback)callback;
/**
 * 生成任意圆角的图片来填充控件。默认取最顶层父视图的背景色，若为透明，则取本身背景色，若也为透明，则取白色、isEqualScale=YES。如果控件本身大小确定，
 * 可以直接使用此API来生成与控件大小相同的图片来填充。
 */
- (UIImage *)setImage:(id)image
             cornerRadius:(CGFloat)cornerRaidus
               rectCorner:(UIRectCorner)rectCorner
                 onCliped:(CornerImageCallback)callback;



@end
