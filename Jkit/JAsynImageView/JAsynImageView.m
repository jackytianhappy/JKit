//
//  JAsynImageView.m
//  JKit
//
//  Created by Jacky on 16/7/22.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "JAsynImageView.h"

@interface JAsynImageView(){
    NSString *tmpPath;//图片存放文件夹位置
}

@end

@implementation JAsynImageView
@synthesize imageURL         = _imageURL;
@synthesize placeholderImage = _placeholderImage;
@synthesize fileName         = _fileName;

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //默认此类的存放路径
        NSArray *path    = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir = [path objectAtIndex:0];
        tmpPath          = [docDir stringByAppendingPathComponent:@"JAsynImage"];
    }
    return self;
}


-(void)setPlaceholderImage:(UIImage *)placeholderImage{
    if (placeholderImage != _placeholderImage) {
        _placeholderImage = placeholderImage;
        self.image        = _placeholderImage;//设置默认图片
    }
}

-(void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    if (self.imageURL) {
         //设置图片的缓存地址
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:tmpPath]) {
            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSArray *lineArray = [self.imageURL componentsSeparatedByString:@"/"];
        self.fileName      = [NSString stringWithFormat:@"%@/%@",tmpPath,[lineArray objectAtIndex:[lineArray count]-1]];
        
        //对图片是否下载进行判断，没有下载，则进行网络请求。
        if (![[NSFileManager  defaultManager] fileExistsAtPath:_fileName]) {
            //本地不存在缓存，进行下载
            [self asyLoadImage];
        }else{
            //本地缓存中已经存在图片，直接进行展示
            self.image = [UIImage imageWithContentsOfFile:_fileName];
        }
    }
}

/**
 *  异步加载图片
 */
-(void)asyLoadImage{
    if(self.imageURL == nil){
        return;
    }
    NSURL *url = [NSURL URLWithString:self.imageURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //将文件存储起来
        BOOL Result = [data writeToFile:_fileName atomically:YES];
        //显示文件
        if (Result) {
            self.image = [UIImage imageWithData:data];
        }else{
            //NSLog(@"失败了");
        }
        
    }];
}

#pragma mark -Clear Image Action
/**
 *  清理路径下的缓存
 */
-(void)ClearCachedImageAll{
    //获取文件路径下的内容
    NSEnumerator *e = [self objectsUnderTheDir];
    NSString *fileName = @"";
    
    while (fileName = [e nextObject]) {
        [[NSFileManager defaultManager]removeItemAtPath:tmpPath error:NULL];
    }
}
/**
 *  清理固定名字的图片
 *
 *  @param name 欲删除图片名字
 */
-(void)ClearCachedImageWithName:(NSString *)name{
    //获取文件路径下的内容
    NSEnumerator *e    = [self objectsUnderTheDir];
    NSString *fileName = @"";
    NSArray *tempArray = [[NSArray alloc]init];
    
    while (fileName = [e nextObject]) {
        tempArray = [fileName componentsSeparatedByString:@"."];
        if ([name isEqualToString:[NSString stringWithFormat:@"%@",tempArray[0]]]) {
            [[NSFileManager defaultManager]removeItemAtPath:[NSString stringWithFormat:@"%@/%@",tmpPath,fileName] error:NULL];
        }
    }
}

-(NSEnumerator *)objectsUnderTheDir{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:tmpPath error:NULL];

    return [contents objectEnumerator];
}

@end

