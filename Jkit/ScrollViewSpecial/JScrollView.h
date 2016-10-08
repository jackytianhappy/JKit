//
//  JScrollView.h
//  JKit
//
//  Created by Jacky on 16/9/9.
//  Copyright © 2016年 jacky. All rights reserved.
//  这个暂时不具有通用性 暂时只是供于项目中使用
//
//

#import <UIKit/UIKit.h>

//@protocol JScrollViewDelegate;
//@protocol JScrollViewDataSource;


@interface JScrollView : UIView
//@property (nonatomic,assign) id<JScrollViewDelegate> delegate;
//@property (nonatomic,assign) id<JScrollViewDataSource> dataSource;

//数据源方法
//Fix Me 三个以上的数据源显示更加合理；
@property (nonatomic,strong) NSArray *dataSource;

-(instancetype)initWithFrame:(CGRect)frame;

@end


//@protocol JScrollViewDataSource <NSObject>
//@required
//-(NSArray *)jScrollView:(JScrollView *)jScrollView;
//@end
//
//@protocol JScrollViewDelegate <NSObject>
//
//@end
