//
//  YYRichTextDetailView.m
//  YongYuanDeLaoShe
//
//  Created by 自知之明、 on 17/2/20.
//  Copyright © 2017年 cn.hanyan. All rights reserved.
//

#import "YYRichTextDetailView.h"

@interface YYRichTextDetailView ()<UIScrollViewDelegate,UIWebViewDelegate>
{
    UIScrollView *m_pScrollView;
    UIWebView *m_pWebView;
    NSString *m_strContent;
}

@end

@implementation YYRichTextDetailView

-(id)initWithFrame:(CGRect)frame andContent:(NSString *)argContent
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        m_strContent = argContent;
        [self CreateSubViews];
    }
    return self;
}

#pragma mark - private methods
-(void)CreateSubViews
{
    m_pScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    m_pScrollView.delegate = self;
    [self addSubview:m_pScrollView];
    
    m_pWebView = [[UIWebView alloc] initWithFrame:m_pScrollView.bounds];
    m_pWebView.delegate = self;
    m_pWebView.scrollView.scrollEnabled = NO;
    [m_pScrollView addSubview:m_pWebView];
    [m_pWebView loadHTMLString:m_strContent baseURL:nil];
}

#pragma mark - WebView Delegate
//当网页视图已经开始加载一个请求后，得到通知。
-(void)webViewDidStartLoad:(UIWebView*)webView
{
    
}
//当网页视图结束加载一个请求之后，得到通知。
-(void)webViewDidFinishLoad:(UIWebView*)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    NSLog(@"size: %f, %f", fittingSize.width, fittingSize.height);
    m_pScrollView.contentSize = CGSizeMake(self.width, webView.bottom);
}
//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型。
-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error
{
    
}


@end
