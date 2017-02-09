//
//  AFVideoProcessingTool.m
//  pbuGuoAnFuWuClient
//
//  Created by 1bu2bu on 16/6/1.
//  Copyright © 2016年 1bu2bu. All rights reserved.
//

#import "AFVideoProcessingTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation AFVideoProcessingTool


+ (void)VideoMovToMP4:(NSString *)argMovUrl Handled:(void (^)(NSString *mp4Url))handledMp4Url
{
    ///该类主要用于获取媒体信息，包括视频、声音等
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:argMovUrl] options:nil];
    ///视频时长
//    NSTimeInterval fDuration = (CGFloat)avAsset.duration.value / avAsset.duration.timescale;
    ///将mov地址转为mp4地址
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]){
        ///视频压缩    以高清模式压缩
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        ///输出视频地址
        NSString *strMp4Url = [[[argMovUrl componentsSeparatedByString:@"."] firstObject] stringByAppendingString:@".mp4"];
        NSFileManager *pFileManager = [NSFileManager defaultManager];
        if ([pFileManager fileExistsAtPath:strMp4Url]){
            [pFileManager removeItemAtPath:strMp4Url error:nil];
        }
        exportSession.outputURL = [NSURL fileURLWithPath:strMp4Url];
        ///输出视频格式
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        ///导出视频的时间区间
//        CMTimeRange range = CMTimeRangeMake(CMTimeMakeWithSeconds(0.0, 600), avAsset.duration);
//        exportSession.timeRange = range;
        //异步导出文件
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            if ([pFileManager fileExistsAtPath:argMovUrl]){
                [pFileManager removeItemAtPath:argMovUrl error:nil];
            }
            switch ([exportSession status])
            {
                //导出成功
                case AVAssetExportSessionStatusCompleted:
                    handledMp4Url(strMp4Url);
                    break;
                default:
                    handledMp4Url(nil);
                    break;
            }
        }];
    }
}

//获取视频第一帧的图片
- (void)movieToImageHandlerWithUrl:(NSString *)argUrl Handled:(void (^)(UIImage *movieImage))handler {
    NSURL *url = [NSURL fileURLWithPath:argUrl];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = TRUE;
    CMTime thumbTime = CMTimeMakeWithSeconds(0, 60);
    generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    AVAssetImageGeneratorCompletionHandler generatorHandler =
    ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result == AVAssetImageGeneratorSucceeded) {
            UIImage *thumbImg = [UIImage imageWithCGImage:im];
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(thumbImg);
                });
            }
        }
    };
    [generator generateCGImagesAsynchronouslyForTimes:
     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:generatorHandler];
}

@end
