//
//  SXBaseDetailView.h
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/15.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import "AFBaseTableView.h"
#import "MJRefresh.h"
#import "NSString+IntValue.h"
#import "BUAFHttpRequest.h"
#import "AFBaseDetailHeaderView.h"
#import "AFCommentData.h"
//#import "SXLoginTool.h"
#import "AFCommentCell.h"

#define SEND_COMMENT @"SendComment"

@protocol AFBaseDetailViewDelegate <NSObject>

/**
 *  当评论的时候，如果用户没有登录，会想让用户登录，让后才可以发表评论
 */
- (void)Login;

///举报评论
- (void)InformComment:(NSInteger)argCommentId Reason:(NSString *)argReason;

@end

/**
 *  详情页面
 */
@interface AFBaseDetailView : AFBaseTableView<UITextViewDelegate,BUAFHttpRequestDelegate,AFBaseDetailHeaderViewDelegate,AFCommentCellDelegate>

{
    @public
    AFBaseDetailHeaderView *m_pBaseDetailHeaderV;    ///透视图
    @private
    UILabel *m_pAllComments;    ///全部评论
    UITextView *m_pCommentText;   ///要发表的评论
    UIView *m_pBottomView;   ///底部的发表评论调
    UIButton *m_pSendBtn;     ///发送评论按钮
    UIActivityIndicatorView *m_pActivityIndicatorV;     ///活动指示器
    
    BUAFHttpRequest *m_pSendCommentRequest;   ///发表评论的请求
    
    /**
     *  取出的的评论数据，当有值时，表示为对别人的评论进行评论，当值为空时，表示使用户自己在发表评论
     */
    AFCommentData *m_pCommentData;    ///评论数据
    
    /**
     *  发表评论时，接口需要的参数
     */
    NSString *m_strDetailNewsUrl;    ///详细信息的请求接口
    NSString *m_strIdType;           ///详细信息的id类型
}

@property(nonatomic,weak)id<AFBaseDetailViewDelegate>propDelegate;


/**
 *  新闻的id
 */
@property(nonatomic,assign)NSInteger propNewsId;

/**
 *  用于设置头部视图的数据
 *
 *  @param argData    数据model
 */
- (void)SetHeaderData:(id)argData;


#pragma mark -- 子类必须调用的方法
/**
 *  设置表视图的头部视图
 *
 *  @param argClass 头部视图的映射(继承自SXBaseDetailHeaderView)
 */
- (void)SetupTableHeaderView:(Class)argClass;


/**
 *  提交评论
 *
 *  @param argUrl    接口url
 *  @param argIdType 属于那种类型的id（新闻或路况）
 */
- (void)SetSendCommentParam:(NSString *)argUrl IdType:(NSString *)argIdType;

@end
