//
//  SXBaseDetailNewsController.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/16.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import "BUCustomViewController.h"
#import "NSString+IntValue.h"
#import "BUAFHttpRequest.h"
#import "AFBaseDetailView.h"

#define REQUEST_DETAIL_NEWS @"DetailNews"
#define REQUEST_COMMENTS @"Comments"

@interface AFBaseDetailNewsController : BUCustomViewController<BUAFHttpRequestDelegate,AFBaseTableViewDelegate>
{
    AFBaseDetailView *m_pBaseDetailV;     ///
    
    BUAFHttpRequest *m_pDetailNewsRequest;   ///城市路况详情的请求
    BUAFHttpRequest *m_pCommentRequest;    ///评论请求
    BUAFHttpRequest *m_pInformCommentRequest;    ///举报评论的请求
    
    NSString *m_strDetailNewsUrl;    ///详细信息的请求接口
    NSString *m_strCommentUrl;       ///相关评论的请求接口
    NSString *m_strInformUrl;    ///举报相关评论的请求接口
    Class m_classData;               ///详细信息的数据model映射
    NSString *m_strIdType;           ///详细信息的id类型
    
    NSString *m_strShareUrl;     ///分享的网址
}

@property(nonatomic,assign)NSInteger propNewsId;   ///新闻id
@property(nonatomic,assign)NSString *propShareTitle;    ///分享的标题
@property(nonatomic,copy)NSString *propShareImageUrl; ///分享的图片链接
@property(nonatomic,copy)NSString *propShareConten;   ///分享的内容

/**
 *  添加控制器主视图
 *
 *  @param argClass 主视图类的映射
 */
- (void)AddMainView:(Class)argClass;

/**
 *  开始请求数据
 *
 *  @param argDetailNewsUrl 详细信息的接口url
 *  @param argDataClass     详细信息的数据model类的映射
 *  @param argCommentUrl    相关评论的数据请求接口
 *  @param argIdType        详细信息的id类型
 *  @param argInformUrl 举报的请求接口
 */
- (void)StartRequestDataWithParam:(NSString*)argDetailNewsUrl DetailNewsDataClass:(Class)argDataClass CommentUrl:(NSString*)argCommentUrl NewsIdType:(NSString*)argIdType InformUrl:(NSString *)argInformUrl;

@end
