//
//  AFVideoProcessingTool.h
//  pbuGuoAnFuWuClient
//
//  Created by 1bu2bu on 16/6/1.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFVideoProcessingTool : NSObject

/**
 *  将mov格式的视频转换为MP4格式的视频   并压缩
 *
 *  @param argMovUrl mov格式视频的本地地址
 */
+ (void)VideoMovToMP4:(NSString *)argMovUrl Handled:(void (^) (NSString *mp4Url))handledMp4Url;

//获取视频第一帧的图片
- (void)movieToImageHandlerWithUrl:(NSString *)argUrl Handled:(void (^)(UIImage *movieImage))handler;

@end
