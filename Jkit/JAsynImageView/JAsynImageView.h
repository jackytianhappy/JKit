//
//  JAsynImageView.h
//  JKit
//
//  Created by Jacky on 16/7/22.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAsynImageView : UIImageView{
    NSURLConnection *connection;
    NSMutableData *loadData;
}

//缓存图片位于沙盒中的路径
@property (nonatomic,retain) NSString *fileName;

//没有显示图片时，默认加载的图片
@property (nonatomic,retain) UIImage  *placeholderImage;

//请求图片的资源路径
@property (nonatomic,retain) NSString *imageURL;

//清理路径下的缓存图片
-(void)ClearCachedImageAll;

/**
 *  清理固定名字的图片
 *
 *  @param name 图片的名字
 */
-(void)ClearCachedImageWithName:(NSString *)name;

@end
