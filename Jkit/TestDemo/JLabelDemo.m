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
        lbl.adjustMoreLineNum = 3;
        lbl.text = @"qrqwrqrqwrwqrwqrwrwqrqwrweqrwqerwqrwqrweqrwerwrweqrwq";
        [lbl drawTheLabel];
        
        [self addSubview:lbl];
    }
    return self;
}
@end
