//
//  SXBaseDetailHeaderView.m
//  pbuShanXiSecurityTrafficClient
//
//  Created by 1bu2bu on 15/12/15.
//  Copyright © 2015年 1bu2bu. All rights reserved.
//

#import "AFBaseDetailHeaderView.h"
//#import "BUCheckBigImageView.h"

@implementation AFBaseDetailHeaderView

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self AddSubviews];
        self.backgroundColor = [AppConfigure WhiteColor];
    }
    return self;
}

- (void)AddSubviews
{
    m_pNewsTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 * [AppConfigure GetLengthAdaptRate], 10 * [AppConfigure GetLengthAdaptRate], self.width - 20 * [AppConfigure GetLengthAdaptRate], SIZE_HEIGHT(20))];
    m_pNewsTitle.textColor = [AppConfigure BlackColor];
    m_pNewsTitle.font = [UIFont fontWithName:[AppConfigure BoldFont] size:20];
    m_pNewsTitle.numberOfLines = 0;
    m_pNewsTitle.backgroundColor = [UIColor clearColor];
    
    [self addSubview:m_pNewsTitle];
    
    m_pNewsFrom = [[UILabel alloc]init];
    m_pNewsFrom.textColor = [AppConfigure GrayColor];
    m_pNewsFrom.font = [UIFont fontWithName:[AppConfigure RegularFont] size:13];
    m_pNewsFrom.backgroundColor = [UIColor clearColor];
    [self addSubview:m_pNewsFrom];
    
    m_pNewsWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.width, 1)];
    m_pNewsWeb.backgroundColor = [UIColor clearColor];
//    m_pNewsWeb.dataDetectorTypes = UIDataDetectorTypeAll;
    m_pNewsWeb.scrollView.scrollEnabled = NO;
    [m_pNewsWeb addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    m_pNewsWeb.userInteractionEnabled = YES;
    m_pNewsWeb.delegate = self;
    [self addSubview:m_pNewsWeb];

}

- (void)dealloc
{
    [m_pNewsWeb removeObserver:self forKeyPath:@"scrollView.contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGSize sTitleSize = [m_pNewsTitle sizeThatFits:CGSizeMake(self.width - 20 * [AppConfigure GetLengthAdaptRate], 200.0f)];
    CGRect rTitleFrame = m_pNewsTitle.frame;
    rTitleFrame.size = sTitleSize;
    m_pNewsTitle.frame = rTitleFrame;
    
    m_pNewsFrom.frame = CGRectMake(10 * [AppConfigure GetLengthAdaptRate], m_pNewsTitle.bottom + 10 * [AppConfigure GetLengthAdaptRate], self.width - 20 * [AppConfigure GetLengthAdaptRate], SIZE_HEIGHT(13));
    
    CGRect frame = m_pNewsWeb.frame;
    frame.origin.y = m_pNewsFrom.bottom + 20 * [AppConfigure GetLengthAdaptRate];
    frame.size.height = m_pNewsWeb.scrollView.contentSize.height;
    m_pNewsWeb.frame = frame;
    if (self.propDel != nil && [self.propDel respondsToSelector:@selector(ChangeDetailNewsHeaderHeight:)])
    {
        [self.propDel ChangeDetailNewsHeaderHeight:m_pNewsWeb.bottom + 10 * [AppConfigure GetLengthAdaptRate]];
    }
}

- (void)SetData:(id)argData
{
    
}

- (CGFloat)GetViewHeight
{
    return m_pNewsWeb.bottom + 10 * [AppConfigure GetLengthAdaptRate];
}

#pragma mark -- UIWebViewDelegate method
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *strJSS = @"function click(imagesrc){var url=\"ClickImage::\"+imagesrc;document.location = url;} ";
    [m_pNewsWeb stringByEvaluatingJavaScriptFromString:strJSS];
    NSString *strJS = @"function setImageClickFunction(){ var objs = document.getElementsByTagName(\"img\"); for(var i=0;i<objs.length;i++) {var src = objs[i].src;objs[i].onclick=function(){click(this.src);}}}";
    [m_pNewsWeb stringByEvaluatingJavaScriptFromString:strJS];
    [m_pNewsWeb stringByEvaluatingJavaScriptFromString:@"setImageClickFunction();"];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *path=[[request URL] absoluteString];
    if([path hasPrefix:@"clickimage::"])
    {
        NSArray * arrItems = [path componentsSeparatedByString:@"::"];
        NSString * strImageUrl = [arrItems lastObject];
        if (strImageUrl!=nil&&[strImageUrl hasPrefix:@"http"])
        {
            [self ShowBigImage:strImageUrl];
        }
        return NO;
    }
    return YES;
}

#pragma mark -- private mthod
- (void)ShowBigImage:(NSString *)argUrl
{
//    UIResponder *next = self;
//    while (next != Nil)
//    {
//        next = [next nextResponder];
//        if ([next isKindOfClass:[UIViewController class]])
//        {
//            UIViewController *pVC = (UIViewController *)next;
//            BUCheckBigImageView *pBigImageV = [[BUCheckBigImageView alloc]initWithFrame:pVC.view.frame];
//            [pBigImageV StartReviewImages:nil WithUrl:[NSURL URLWithString:argUrl]];
//            [pVC.view addSubview:pBigImageV];
//            break;
//        }
//    }
}

@end
