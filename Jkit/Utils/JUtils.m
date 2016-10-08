//
//  JUtils.m
//  JKit
//
//  Created by Jacky on 16/7/25.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JUtils.h"

@implementation JUtils

+(JUtils *)shareJUtils{
    static JUtils *jUtils = nil;
    @synchronized (self) {
        if (jUtils == nil) {
            jUtils = [[JUtils alloc]init];
        }
        return jUtils;
    }
}

-(BOOL)isNetworkUrl:(NSString *)text{
    return ([text containsString:@"http"]||[text containsString:@"https"]);
}

@end
