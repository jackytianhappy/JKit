//
//  JLabel.m
//  JKit
//
//  Created by Jacky on 16/8/10.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JLabel.h"

@implementation JLabel

-(void)drawTheLabel{
    switch (self.wrapMode) {
        case AdjustConfigLine:{
            break;
        }
        case MoreLine:{
            [self makeMoreLine];//make the content to fit the width to fill the label in more line
            break;
        }
        default:{ //OneLineMode
            //doing nothing, you can set the adjustsFontSizeToFitWidth 使得字体能够适应一行的大小
            break;
        }
    }
}

-(void)makeMoreLine{
    if (!self.text) {
        #ifdef DEBUG
            NSLog(@"you dont have a value for the label");
        #else
        #endif
    }else{
        [self makeMoreLineDetailAction];
    }
}

-(void)makeMoreLineDetailAction{
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = CGSizeMake(self.frame.size.width, 500);

    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName,nil];
    CGSize labelSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;

    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, labelSize.width, labelSize.height)];
}


#pragma mark -get and setter



@end
