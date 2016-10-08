//
//  JCycleLoading.h
//  JKit
//
//  Created by Jacky on 16/7/26.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCycleLoading : UIView

@property (nonatomic,assign) CGFloat     cycleLineWidth;//环形圆圈的宽度

@property (nonatomic,strong) UIColor     *cycleLineColor;//环形圆圈的颜色

@property (nonatomic,strong) UIColor     *cycleInnerColor;//环形圆圈的颜色

@property (nonatomic,strong) NSString    *unit;//中间数字的单位 如:元，秒

@property (nonatomic,strong) UILabel     *countLbl;//通过这个控件修改中甲你胡子字体颜色等信息

@property (nonatomic,strong) UIImageView *centetBgImgView;//数字环中间图片，默认是透明色

/**
 *  初始化控件
 *
 *  @param frame      此frame是整个空间底层view的frame，非圆形圈的位置，圆形圈的位置始终位于此底层view的正中间
 *  @param radius     圆形圈的半径
 *  @param totalTime  动画执行的时间
 *  @param totalCount 内部区域数字的终止值，即最大值（传非数字的字符串，将不显示）
 *
 *  @return 返回视图（外部转圈和中间的文字部分，若不需要文字部分，toalcount参数传非数字字符串）
 */
-(instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius finshTime:(NSTimeInterval)totalTime AndFinishNumber:(CGFloat)totalCount;

/**
 *  开始执行动画 注:若需要改变界面元素的属性，需在此方法之前
 */
-(void)startAnimation;

@end
