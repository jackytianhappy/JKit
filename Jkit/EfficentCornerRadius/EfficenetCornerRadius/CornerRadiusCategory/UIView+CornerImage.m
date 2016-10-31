//
//  UIView+CornerImage.m
//  JKit
//
//  Created by Jacky on 16/10/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "UIView+CornerImage.h"
#import "CornerImageManager.h"
#import <objc/runtime.h>

@interface CornerImage : NSObject

@property (nonatomic, strong) UIImage *leftUpImage;
@property (nonatomic, strong) UIImage *leftDownImage;
@property (nonatomic, strong) UIImage *rightUpImage;
@property (nonatomic, strong) UIImage *rightDownImage;

@end

@implementation CornerImage

@end

@interface CornerImageView : UIImageView

@end

@implementation CornerImageView

@end

@interface CornerBorderLayer : CAShapeLayer

@end

@implementation CornerBorderLayer

@end

@interface CornerImageManager (CornerImages)

@end

@implementation CornerImageManager
- (NSCache *)sharedCornerImages {
    return [CornerImageManager shared].sharedCache;
}

- (NSString *)hashKeyWithColor:(UIColor *)color radius:(CGFloat)radius border:(CGFloat)border borderColor:(UIColor *)borderColor targetSize:(CGSize)targetSize {
    const CGFloat *colors = CGColorGetComponents(color.CGColor);
    NSUInteger count = CGColorGetNumberOfComponents(color.CGColor);
    
    NSMutableString *hashStr = [NSMutableString string];
    
    for (NSUInteger index = 0; index < count; index ++) {
        [hashStr appendString:[NSString stringWithFormat:@"%@", @(colors[index])]];
    }
    
    if (borderColor) {
        const CGFloat *colors = CGColorGetComponents(borderColor.CGColor);
        NSUInteger count = CGColorGetNumberOfComponents(borderColor.CGColor);
        
        for (NSUInteger index = 0; index < count; index ++) {
            [hashStr appendString:[NSString stringWithFormat:@"%@", @(colors[index])]];
        }
    }
    [hashStr appendString:[NSString stringWithFormat:@"%@", @(radius)]];
    [hashStr appendString:[NSString stringWithFormat:@"%@", @(border)]];
    
    if (targetSize.width > 0) {
        [hashStr appendString:[NSString stringWithFormat:@"%@", @(targetSize.width)]];
    }
    
    if (targetSize.height > 0) {
        [hashStr appendString:[NSString stringWithFormat:@"%@", @(targetSize.height)]];
    }
    
    return [NSString stringWithFormat:@"%@", @([hashStr hash])];
}


- (NSString *)hashKeyWithColor:(UIColor *)color
                            radius:(CGFloat)radius
                            border:(CGFloat)border
                        targetSize:(CGSize)targetSize {
    return [self hashKeyWithColor:color
                               radius:radius
                               border:border
                          borderColor:nil
                           targetSize:targetSize];
}

- (CornerImage *)cornerImageWithColor:(UIColor *)color
                                       radius:(CGFloat)radius
                                       border:(CGFloat)border
                                   targetSize:(CGSize)targetSize {
    NSString *key = [[CornerImageManager shared] hashKeyWithColor:color
                                                                  radius:radius
                                                                  border:border
                                                              targetSize:targetSize];
    
    CornerImage *image = [[[CornerImageManager shared] sharedCornerImages] objectForKey:key];
    
    if (image == nil) {
        UIImage *cornerImage = nil;
        
        radius *= [UIScreen mainScreen].scale;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef contextRef = CGBitmapContextCreate(NULL,
                                                        radius,
                                                        radius,
                                                        8,
                                                        4 * radius,
                                                        colorSpace,
                                                        kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault);
        
        if (contextRef) {
            CGContextSetFillColorWithColor(contextRef, color.CGColor);
            CGContextMoveToPoint(contextRef, radius, 0);
            CGContextAddLineToPoint(contextRef, 0, 0);
            CGContextAddLineToPoint(contextRef, 0, radius);
            CGContextAddArc(contextRef,
                            radius,
                            radius,
                            radius,
                            180 * (M_PI / 180.0f),
                            270 * (M_PI / 180.0f),
                            0);
            
            CGContextFillPath(contextRef);
            
            CGImageRef imageCG = CGBitmapContextCreateImage(contextRef);
            cornerImage = [UIImage imageWithCGImage:imageCG];
            
            CGContextRelease(contextRef);
            CGColorSpaceRelease(colorSpace);
            CGImageRelease(imageCG);
            
            CGImageRef imageRef = cornerImage.CGImage;
            
            UIImage *leftUpImage = [[UIImage alloc] initWithCGImage:imageRef
                                                              scale:[UIScreen mainScreen].scale
                                                        orientation:UIImageOrientationRight];
            UIImage *rightUpImage = [[UIImage alloc] initWithCGImage:imageRef
                                                               scale:[UIScreen mainScreen].scale
                                                         orientation:UIImageOrientationLeftMirrored];
            UIImage *rightDownImage = [[UIImage alloc] initWithCGImage:imageRef
                                                                 scale:[UIScreen mainScreen].scale
                                                           orientation:UIImageOrientationLeft];
            UIImage *leftDownImage = [[UIImage alloc] initWithCGImage:imageRef
                                                                scale:[UIScreen mainScreen].scale
                                                          orientation:UIImageOrientationUp];
            
            image = [[CornerImage alloc] init];
            image.leftDownImage = leftDownImage;
            image.leftUpImage = leftUpImage;
            image.rightUpImage = rightUpImage;
            image.rightDownImage = rightDownImage;
            
            [[[CornerImageManager shared] sharedCornerImages] setObject:image forKey:key];
        }
    }
    
    return image;
}
@end

static const char *s_image_borderColorKey = "s_image_borderColorKey";
static const char *s_image_borderWidthKey = "s_image_borderWidthKey";
static const char *s_image_pathColorKey = "s_image_pathColorKey";
static const char *s_image_pathWidthKey = "s_image_pathWidthKey";
static const char *s_image_shouldRefreshCache = "s_image_shouldRefreshCache";

@implementation UIView (CornerImage)

- (BOOL)hyb_shouldRefreshCache {
    NSNumber *shouldRefresh = objc_getAssociatedObject(self, s_image_shouldRefreshCache);
    
    if ([shouldRefresh respondsToSelector:@selector(boolValue)]) {
        return shouldRefresh.boolValue;
    }
    return NO;
}

- (void)set_shouldRefreshCache:(BOOL)shouldRefreshCache {
    objc_setAssociatedObject(self,
                             s_image_shouldRefreshCache,
                             @(shouldRefreshCache),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Border
- (CGFloat)borderWidth {
    NSNumber *borderWidth = objc_getAssociatedObject(self, s_image_borderWidthKey);
    
    if ([borderWidth respondsToSelector:@selector(doubleValue)]) {
        return borderWidth.doubleValue;
    }
    
    return 0;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    objc_setAssociatedObject(self,
                             s_image_borderWidthKey,
                             @(borderWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)pathWidth {
    NSNumber *width = objc_getAssociatedObject(self, s_image_pathWidthKey);
    
    if ([width respondsToSelector:@selector(doubleValue)]) {
        return width.doubleValue;
    }
    
    return 0;
}

- (void)setPathWidth:(CGFloat)pathWidth {
    objc_setAssociatedObject(self,
                             s_image_pathWidthKey,
                             @(pathWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)pathColor {
    UIColor *color = objc_getAssociatedObject(self, s_image_pathColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor whiteColor];
}

- (void)setPathColor:(UIColor *)pathColor {
    objc_setAssociatedObject(self,
                             s_image_pathColorKey,
                             pathColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIColor *)borderColor {
    UIColor *color = objc_getAssociatedObject(self, s_image_borderColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor lightGrayColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self,
                             s_image_borderColorKey,
                             borderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius size:(CGSize)targetSize {
    [self addCorner:corner cornerRadius:cornerRadius size:targetSize backgroundColor:nil];
}


- (UIColor *)_private_color:(UIColor *)backgroundColor {
    UIColor *bgColor = nil;
    if (backgroundColor == nil || CGColorEqualToColor(backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
        UIView *superview = self.superview;
        while (superview.backgroundColor == nil || CGColorEqualToColor(superview.backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
            if (!superview) {
                break;
            }
            
            superview = [superview superview];
        }
        
        bgColor = superview.backgroundColor;
    } else {
        bgColor = backgroundColor;
    }
    
    if (bgColor == nil) {
        bgColor = self.backgroundColor;
    }
    
    if (CGColorEqualToColor(bgColor.CGColor, [UIColor clearColor].CGColor)) {
        bgColor = [UIColor whiteColor];
    }
    
    return bgColor;
}






+ (UIImage *)imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    UIGraphicsBeginImageContextWithOptions(targetSize, cornerRadius == 0, [UIScreen mainScreen].scale);
    
    CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
    UIImage *finalImage = nil;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    if (cornerRadius == 0) {
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextFillRect(context, targetRect);
            
            targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
            CGContextStrokeRect(context, targetRect);
        } else {
            CGContextFillRect(context, targetRect);
        }
    } else {
        targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextDrawPath(context, kCGPathFillStroke);
        } else {
            CGContextDrawPath(context, kCGPathFill);
        }
    }
    
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}





- (NSString *)lastBorderImageKey {
    return objc_getAssociatedObject(self, "lastBorderImageKey");
}

- (void)setLastBorderImageKey:(NSString *)key {
    objc_setAssociatedObject(self,
                             "lastBorderImageKey",
                             key,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
