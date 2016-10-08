//
//  JTagListView.h
//  JTagList
//
//  Created by apple on 15/11/25.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTagListView : UIView

//设置字体的颜色，若button自定义，则可忽略此属性
@property (nonatomic,strong) UIColor *textColor;

//返回tag在最后的view伤的高度y的值
@property  CGFloat tagHeight;

@property (nonatomic,copy) void(^tagClick)(long index);

/**
 *  初始化标签
 *
 *  @param frame             标签列表的底部view
 *  @param tagDatasource     标签上的数据源
 *  @param topPadding        标签button上部分距离frame的值
 *  @param padding           标签button与标签button之间的距离
 *
 *  @return 返回视图
 */
-(instancetype)initWithFrame:(CGRect)frame andNameDatasource:(NSArray *)tagDatasource toppading:(float)topPadding padding:(float)padding;

/**
 *  用户自定义内部标签的样式
 */
-(void)reDraw:(NSArray *)btnArr;

@end
