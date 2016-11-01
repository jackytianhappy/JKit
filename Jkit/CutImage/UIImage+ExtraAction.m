//
//  UIImage+ExtraAction.m
//  JKit
//
//  Created by Jacky on 16/11/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "UIImage+ExtraAction.h"

@implementation UIImage (ExtraAction)


-(UIImage *)cutImageWithRectSize:(CGSize)size necessryPoint:(CGPoint)point{
    NSLog(@"image width = %f,height = %f",self.size.width,self.size.height);
    
    CGPoint newPoint;
    
    //传参判断 必要点错误
    if(point.x > self.size.width || point.y > self.size.height ){
        return nil;
    }
    
    CGFloat finalWidth,finalHeight,finalX,finalY;
    
    CGFloat ratioOrigin = self.size.width/self.size.height;//目标图片的横纵比
    CGFloat ratioTarget = size.width/size.height;//目标图片的横纵比

    if (ratioOrigin > ratioTarget) {
        //将原图截成目标图   截取原图的宽
        CGFloat cutWidth = self.size.width - self.size.height * ratioTarget;
        if(self.size.width/2 > point.x){//偏左
            //截取右边
            if((self.size.width - point.x) - point.x > cutWidth){//直接进行右边的截取
                finalX = 0;
            }else{
                finalX = (0 - (self.size.width - point.x) - point.x - cutWidth)/2;
            }
        }else{//偏右
            //截取左边
            if(point.x - (self.size.width - point.x)>cutWidth){//直接在左边进行截取
                finalX = cutWidth;
            }else{
                finalX = cutWidth - (0- (point.x - (self.size.width - point.x) - cutWidth))/2;
            }
        }
        finalY = 0;
        finalHeight = self.size.height;
        finalWidth  = self.size.width - cutWidth;
        
    }else{
         CGFloat cutHeight = self.size.height - self.size.width / ratioTarget;
        //将原图截成目标图   截取原图的高
        if (point.y > (self.size.height - point.y)) {//偏下
            if((point.y - (self.size.height - point.y) - cutHeight) > 0){//直接截取上面
                finalY = cutHeight;
            }else{
                finalY = cutHeight - (0-(point.y - (self.size.height - point.y) - cutHeight))/2;
            }
        }else{//偏上
            if ((self.size.height - point.y) - point.y - cutHeight >0) {//直接截取下面
                finalY = 0;
            }else{
                finalY = (0-(point.y - (self.size.height - point.y) - cutHeight))/2;
            }
        }
        finalX = 0;
        finalHeight = self.size.height - cutHeight;
        finalWidth  = self.size.width;
        
    }
    
    newPoint = CGPointMake(point.x - finalX, point.y - finalY);
    
    CGRect cutRect = CGRectMake(finalX, finalY, finalWidth, finalHeight);
    
    CGImageRef cgimg = CGImageCreateWithImageInRect([self CGImage], cutRect);
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);//用完一定要释放，否则内存泄露
    
    
    
    return newImg;
}

@end
