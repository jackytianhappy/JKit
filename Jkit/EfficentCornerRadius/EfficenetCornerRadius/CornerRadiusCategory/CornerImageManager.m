//
//  CornerImageManager.m
//  JKit
//
//  Created by Jacky on 16/10/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "CornerImageManager.h"
#import <CommonCrypto/CommonDigest.h>

#ifdef DEBUG
#define LOG(format, ...) fprintf(stdout, ">> "format"\n", ##__VA_ARGS__)
#else
#define LOG(format, ...)
#endif

static inline NSUInteger CacheCostForImage(UIImage *image) {
    return image.size.height * image.size.width * image.scale * image.scale;
}


@interface CornerImageManager()

@property (nonatomic,strong) NSCache *cache;
@property (nonatomic,strong) dispatch_queue_t serialQueue;
@property (nonatomic,strong) NSFileManager *fileManager;

@end

@implementation CornerImageManager
+(instancetype)shared{
    static CornerImageManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    
    return manager;
}

-(NSCache *)sharedCache{
    return self.cache;
}

-(instancetype)init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCaches) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        self.shouldCache = YES; //默认开启
        self.totalCostInMemory = 60 * 1024 * 1024; //默认60M
        _cache = [[NSCache alloc]init];
        _cache.totalCostLimit = self.totalCostInMemory;
        _serialQueue = dispatch_queue_create("com.jacky.cornerImage_queue", DISPATCH_QUEUE_SERIAL);
        dispatch_sync(self.serialQueue, ^{
            self.fileManager = [[NSFileManager alloc]init];
        });
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

-(void)clearCaches{
    [self.cache removeAllObjects];
}


+(UIImage *)conerImageFromDiskWithKey:(NSString *)key{
    if (key && key.length) {
        NSString *subpath = [self md5:key];
        
        UIImage *image = nil;
        if ([CornerImageManager shared].shouldCache) {
            image = [[CornerImageManager shared].cache objectForKey:subpath];
            
            if (image) {
                return image;
            }
            
            NSString *path = [[self cachePath] stringByAppendingPathComponent:subpath];
            image = [UIImage imageWithContentsOfFile:path];
            
            return image;
        }
    }
    return nil;
}

+(void)cornerImageFromDiskWithKey:(NSString *)key completion:(CacheCornerImage)completion{
    if(key && key.length ){
        dispatch_async([CornerImageManager shared].serialQueue, ^{
            NSString *subpath = [self md5:key];
            
            UIImage *image = nil;
            if ([CornerImageManager shared].shouldCache) {
                image = [[CornerImageManager shared].cache objectForKey:subpath];
                
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (completion) {
                            completion(image);
                        }
                    });
                    return ;
                }
                
                NSString *path = [[self cachePath] stringByAppendingPathComponent:subpath];
                image = [UIImage imageWithContentsOfFile:path];
                
                if (image!= nil && [CornerImageManager shared].shouldCache) {
                    NSUInteger cost = CacheCostForImage(image);
                    [[CornerImageManager shared].cache setObject:image forKey:subpath cost:cost];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(image);
                    }
                });
            }
        });
    }else{
        if (completion) {
            completion(nil);
        }
    }
}



+(void)storeCornerImage:(UIImage *)cornerImage toDiskWithKey:(NSString *)key{
    if (cornerImage == nil || key == nil || key.length == 0) {
        return;
    }
    
    NSString *subpath = [self md5:key];
    
    if ([CornerImageManager shared].shouldCache) {
        NSUInteger cost = CacheCostForImage(cornerImage);
        [[CornerImageManager shared].cache setObject:cornerImage forKey:subpath cost:cost];
    }
    
    dispatch_async([CornerImageManager shared].serialQueue, ^{
        if (![[CornerImageManager shared].fileManager fileExistsAtPath:[self cachePath] isDirectory:nil]) {
            NSError *error = nil;
            BOOL isOK = [[CornerImageManager shared].fileManager createDirectoryAtPath:[self cachePath] withIntermediateDirectories:YES attributes:nil error:&error];
            if (isOK && error == nil) {
#ifdef CornerImage
                NSLog(@"create folder CornerImages ok");
#endif
            }else{
                return ;
            }
        }
        
        @autoreleasepool {
            NSString *path = [[self cachePath]stringByAppendingPathComponent:subpath];
            
            NSData *data = UIImageJPEGRepresentation(cornerImage, 1.);
            BOOL isOK = [[CornerImageManager shared].fileManager createFileAtPath:path contents:data attributes:nil];
            
            if (isOK) {
#ifdef CornerImage
                NSLog(@"save cliped image to disk ok, key path is %@", path);
#endif
            }else{
#ifdef CornerImage
                NSLog(@"save cliped image to disk fail, key path is %@", path);
#endif
            }
        }
    });
}

+(void)clearCornerImagesCache{
    dispatch_async([CornerImageManager shared].serialQueue, ^{
        [[CornerImageManager shared].cache removeAllObjects];
        
        NSString *directoryPath  = [self cachePath];
        
        if ([[CornerImageManager shared].fileManager fileExistsAtPath:directoryPath isDirectory:nil]) {
            NSError *error = nil;
            [[CornerImageManager shared].fileManager removeItemAtPath:directoryPath error:&error];
            
            if (error) {
#ifdef CornerImage
                NSLog(@"clear caches error: %@", error);
#endif
            } else {
#ifdef CornerImage
                NSLog(@"clear caches ok");
#endif
            }
        }
    });
}


+(unsigned long long)imagesCacheSize{
    NSString *directoryPath = [self cachePath];
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[CornerImageManager shared].fileManager fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[CornerImageManager shared].fileManager contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[CornerImageManager shared].fileManager attributesOfItemAtPath:path
                                                                                                      error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;

}



#pragma mark -private method
+ (NSString *)cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/JCornerImages"];
}


+ (NSString *)md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}





@end
