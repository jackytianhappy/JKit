//
//  JButton.h
//  JKit
//
//  Created by Jacky on 16/8/16.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapHandler)(UIButton *sender);

typedef enum{
    Vertical,
    Horizontal
}direction;

@interface JButton : UIButton

@property (nonatomic,assign) CGFloat padding; //水平方向时,最前方的间隙

@property (nonatomic,assign) CGFloat lblRatio; //水平活着垂直方向上的图片占整体的比例

@property (nonatomic,assign) direction direction; // 按钮显示的方向

@property (nonatomic,strong) tapHandler handler; //点击事件

-(id)initWithFrame:(CGRect)frame title:(NSString *)title iamge:(UIImage *)image handler:(tapHandler)handler;

@end
