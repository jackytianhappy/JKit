//
//  JUtils.h
//  JKit
//
//  Created by Jacky on 16/7/25.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kJUtils  [JUtils shareJUtils]

@interface JUtils : NSObject

+(JUtils *)shareJUtils;
/**
 *  判断字符串是不是网络请求类
 *
 *  @param text 所判断的字符串
 *
 *  @return 判断的结果值
 */
-(BOOL)isNetworkUrl:(NSString *)text;

@end
