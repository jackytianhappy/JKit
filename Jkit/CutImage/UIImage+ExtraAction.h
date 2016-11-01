//
//  UIImage+ExtraAction.h
//  JKit
//
//  Created by Jacky on 16/11/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ExtraAction)

//size目标尺寸
//point 必要点的坐标 这个点尽量在图片中间 但是必须存在
-(UIImage *)cutImageWithRectSize:(CGSize)size necessryPoint:(CGPoint)point;

@end
