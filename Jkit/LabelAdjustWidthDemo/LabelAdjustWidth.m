//
//  LabelAdjustWidth.m
//  JKit
//
//  Created by Jacky on 16/8/12.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "LabelAdjustWidth.h"

@interface LabelAdjustWidth()

@property (nonatomic,strong) UILabel *titleLbl;

@end

@implementation LabelAdjustWidth

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSString *s = @"123456789123456789123456789123456789123456789123456789123456789123456789";
        
        self.titleLbl.numberOfLines = 0;
        self.titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLbl.textColor = [UIColor blackColor];
        UIFont *font  =[UIFont fontWithName:@"Arial" size:12];
        CGSize size = CGSizeMake(320, 400);
        //CGSize labelSize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        CGSize labelSize = [s boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
        
        [self.titleLbl setFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
        self.titleLbl.font = [UIFont fontWithName:@"Arial" size:12];
        self.titleLbl.text = s;
        
        
        
    }
    
    return self;
}




#pragma mark - lazy load
-(UILabel *)titleLbl{
    if (_titleLbl == nil) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0 , 0)];
        
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

@end
