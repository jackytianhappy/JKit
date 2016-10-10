//
//  JLabel.h
//  JKit
//
//  Created by Jacky on 16/8/10.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

//显示字体的模式
typedef NS_ENUM(NSInteger,WrapMode){
    OneLine, //默认 单行显示 多余的显示省略号...
    MoreLine, //折行显示
    AdjustConfigLine //折行显示，默认折行两行，多余的...，需要指定更多行 需要进行属性设置
};


@interface JLabel : UILabel
//显示模式
//需要进行的显示模式
@property (nonatomic,assign) WrapMode wrapMode;
//AdjustMoreLine模式下需要进行的行数显示
@property (nonatomic,assign) NSInteger adjustMoreLineNum;

//此方法必须调用，确保能够进行正常的赋值操作
-(void)drawTheLabel;

@end
