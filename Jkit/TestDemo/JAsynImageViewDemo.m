//
//  JAsynImageViewDemo.m
//  JKit
//
//  Created by Jacky on 16/7/25.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JAsynImageViewDemo.h"
#import "JAsynImageView.h"

@implementation JAsynImageViewDemo

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initJAsynImageView];
    }
    
    return self;
}

-(void)initJAsynImageView{
    JAsynImageView *imageView  = [[JAsynImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    [self addSubview:imageView];
    imageView.placeholderImage = [UIImage imageNamed:@"JADCycleTest1"];
    imageView.imageURL         = @"http://img3.3lian.com/2013/v8/86/d/101.jpg";
    //[imageView ClearCachedImageAll];
    //[imageView ClearCachedImageWithName:@"101"];
}

@end
