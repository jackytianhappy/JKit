//
//  CornerImageManager.h
//  JKit
//
//  Created by Jacky on 16/10/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CacheCornerImage)(UIImage *image);


@interface CornerImageManager : NSObject

//允许存储的最大值 默认设置为 60M
@property (nonatomic,assign) NSUInteger totalCostInMemory;

//是否存入cache 默认设置为YES
@property (nonatomic,assign) BOOL shouldCache;

//供内部使用 外部尽量不使用
@property (nonatomic,strong,readonly) NSCache *sharedCache;

+(instancetype)shared;

//从磁盘上进行读取的 不存储到内存 防止内存暴涨
+(UIImage *)conerImageFromDiskWithKey:(NSString *)key;

//按照键值从磁盘上进行存取 优先从缓存中进行读取 没有的话再到磁盘上进行读取 异步操作
+(void)cornerImageFromDiskWithKey:(NSString *)key completion:(CacheCornerImage)completion;

//按照键值将圆角图片裁剪后存储到本地 异步操作
+(void)storeCornerImage:(UIImage *)cornerImage toDiskWithKey:(NSString *)key;

//计算本地缓存大小
+(unsigned long long)imagesCacheSize;

//清除本地缓存
+(void)clearCornerImagesCache;


@end
