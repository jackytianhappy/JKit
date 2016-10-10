//
//  JLabelDemo.m
//  JKit
//
//  Created by Jacky on 16/10/10.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JLabelDemo.h"
#import "JLabel.h"

@implementation JLabelDemo

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        JLabel *lbl = [[JLabel alloc]initWithFrame:CGRectMake(0, 100, 100, 40)];
        lbl.wrapMode = AdjustConfigLine;
        lbl.adjustConfigLineNum = 4;
        lbl.text = @"qrqwrqrqwrwqrwqrwrwqrqwrweqrwqerwqrwqrweqrwerwrweqrwq";
        [lbl drawTheLabel];  //属性配置好了进行绘画UILable
        [self addSubview:lbl];
        
        JLabel *lbl1 = [[JLabel alloc]initWithFrame:CGRectMake(0, 200, 100, 40)];
        lbl1.wrapMode = OneLine;
        lbl1.text = @"qrqwrqrqwrwqrwqrwrwqrqwrweqrwqerwqrwqrweqrwerwrweqrwq";
        [lbl1 drawTheLabel];
        [self addSubview:lbl1];
        
        JLabel *lbl2 = [[JLabel alloc]initWithFrame:CGRectMake(0, 300, 100, 40)];
        lbl2.wrapMode = MoreLine;
        lbl2.text = @"qrqwrqrqwrwqrwqrwrwqrqwrweqrwqerwqrwqrweqrwerwrweqrwq";
        [lbl2 drawTheLabel];
        [self addSubview:lbl2];
        
        
    }
    return self;
}
@end
