//
//  BUFileDownloader.m
//  DaoTingTuShuo
//
//  Created by -3 on 14-7-2.
//  Copyright (c) 2014年  MultiMedia Lab. All rights reserved.
//

/*
#import "BUFileDownloader.h"

@interface BUFileDownloader()

@end

@implementation BUFileDownloader

static BUFileDownloader* m_sMgr = nil;

+ (BUFileDownloader*)GetInstance
{
    @synchronized(self)
    {
		if(m_sMgr == nil)
			m_sMgr = [[BUFileDownloader alloc] init];
	}
    
	return m_sMgr;
}

+ (void)ClearInstance
{
    [m_sMgr release];
    m_sMgr = nil;
}

-(void)dealloc
{
    if (m_pDownloadQueue!=nil)
    {
        [m_pDownloadQueue reset];
        [m_pDownloadQueue release];
        m_pDownloadQueue = nil;
    }
    
    [super dealloc];
}

-(id)init
{
    self = [super init];
    
    m_pDownloadQueue = [[ASINetworkQueue alloc] init];
    [m_pDownloadQueue go];
    return self;
}


//发送下载文件请求
-(void)GetFile:(NSArray*)argFileURLs
{
    //暂停队列
    [m_pDownloadQueue setSuspended:YES];
    
    NSMutableArray * arrNewURLs = [[NSMutableArray alloc] init];

    //检查文件是否已存在
    for (NSString * strFileURL in argFileURLs)
    {
        NSLog(@"Check exist %@",strFileURL);
        NSString * strFileName = [[strFileURL componentsSeparatedByString:@"/"] lastObject];
        NSString * strDownloadPath = [NSString stringWithFormat:@"%@/File",[AppConfigure GetCachePath]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:strDownloadPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:strDownloadPath
                                      withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString * strFilePath = [NSString stringWithFormat:@"%@/%@",strDownloadPath,strFileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath: strFilePath])
        {
            NSLog(@"File existed %@",strFileURL);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_FILE_DOWNLOAD_READY
                                                                object:nil
                                                              userInfo:[NSDictionary dictionaryWithObjectsAndKeys:strFileURL,@"FileURL", nil]];
        }
        else
        {
            [arrNewURLs addObject:strFileURL];

        }
    }
    
    //清除队列中等待的request  手动处理是为了防止request 调用failed
    [m_pDownloadQueue reset];
//    NSArray * arrQueue = [m_pDownloadQueue operations];
//    for(ASIHTTPRequest * pRequest in arrQueue)
//    {
//        if ([pRequest isExecuting]==NO&&[pRequest isFinished]==NO)
//        {
//            pRequest.delegate = nil;
//            [pRequest clearDelegatesAndCancel];
////            [pRequest cancel];
//        }
//    }
    
    //加入新需要下载的request
    for (NSString*strFileURL in arrNewURLs)
    {
        NSLog(@"File Create %@",strFileURL);
        NSURL* pURL =[NSURL URLWithString:strFileURL];
        NSString * strFileName = [[strFileURL componentsSeparatedByString:@"/"] lastObject];
        NSString * strDownloadPath = [NSString stringWithFormat:@"%@/File",[AppConfigure GetCachePath]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:strDownloadPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:strDownloadPath
                                      withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString * strFilePath = [NSString stringWithFormat:@"%@/%@",strDownloadPath,strFileName];

        ASIHTTPRequest * pHTTPRequest = [ASIHTTPRequest requestWithURL:pURL];
        pHTTPRequest.timeOutSeconds = 10;
        pHTTPRequest.delegate = self;
        pHTTPRequest.downloadDestinationPath = strFilePath;
        pHTTPRequest.numberOfTimesToRetryOnTimeout = 2;
        [m_pDownloadQueue addOperation:pHTTPRequest];
    }
    [arrNewURLs release];
    
    //启动队列
    [m_pDownloadQueue go];
   
}

-(void)Cancel
{
    [m_pDownloadQueue setSuspended:YES];
    //
    NSArray * arrQueue = [m_pDownloadQueue operations];
    for(ASIHTTPRequest * pRequest in arrQueue)
    {
            if ([pRequest isExecuting]==NO&&[pRequest isFinished]==NO)
            {
                pRequest.delegate = nil;
                [pRequest clearDelegatesAndCancel];
                [pRequest cancel];
            }
    }
    [m_pDownloadQueue reset];
}

-(NSString*)GetCacheFile:(NSString*)argFileUrl
{
    NSString * strFileName = [[argFileUrl componentsSeparatedByString:@"/"] lastObject];
    NSString * strDownloadPath = [NSString stringWithFormat:@"%@/File",[AppConfigure GetCachePath]];
    
    NSString * strFilePath = [NSString stringWithFormat:@"%@/%@",strDownloadPath,strFileName];
    
    return strFilePath;
}


#pragma  mark - ASIHTTPRequest Delegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished %@",request.url.description);
//    NSString * strFileName = [request.userInfo valueForKey:@"FileName"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_FILE_DOWNLOAD_READY
                                                        object:nil
                                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:request.url.description,@"FileURL", nil]];

}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_FILE_DOWNLOAD_FAILED
                                                        object:nil
                                                      userInfo:[NSDictionary dictionaryWithObjectsAndKeys:request.url.description,@"FileURL", nil]];
}

@end
 
 */
