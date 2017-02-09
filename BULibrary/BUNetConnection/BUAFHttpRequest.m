//
//  BUAFHttpRequest.m
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-7-11.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import "BUAFHttpRequest.h"
#import "BUBaseResponseData.h"
#import "AppConfigure.h"

@implementation BUShowErrorMsg

static BUShowErrorMsg *_instance;
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)GetInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (void)ShowErrorMessage:(NSString*)argError
{
    if (m_pAlertView.visible == NO)
    {
        m_pAlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                  message:argError delegate:nil
                                        cancelButtonTitle:@"知道了"
                                        otherButtonTitles:nil, nil];
        [m_pAlertView show];
    }
}
@end


@interface BUAFHttpRequest ()
{
    NSString* m_strUrl;                     // record the url;
    NSString* m_strRequestTag;              // the variable to record the reqeust tag
    NSDictionary* m_dicParameters;          // the vairable to record the parameters
    NSDictionary* m_dicImageParas;          // The variable to record the parameters of type UIImage;
    BUBaseResponseData* m_pResponseData;                // The response data
    AFHTTPSessionManager* m_pRequestManager; // The AFHTTPrequest operation manager;
    NSURLSessionDataTask* m_pRequest;        // The post operation
}

@end


@implementation BUAFHttpRequest

@synthesize propUrl = m_strUrl;
@synthesize propParameters = m_dicParameters;
@synthesize propResponseData = m_pResponseData;
@synthesize propRequestTag = m_strRequestTag;

- (void)Init
{
    m_dicParameters = [[NSMutableDictionary alloc] init];
    m_dicImageParas = [[NSMutableDictionary alloc] init];
    m_pRequestManager = [AFHTTPSessionManager manager];
     /*! 设置请求超时时间 */
    m_pRequestManager.requestSerializer.timeoutInterval = 30;
    m_pRequestManager.responseSerializer.acceptableContentTypes =  [m_pRequestManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
}

- (id)initWithShareUrl:(NSString *)argUrl andTag:(NSString *)argTag
{
    self = [super init];
    [self Init];
    m_strUrl = argUrl;
    m_strRequestTag = argTag;
    return self;
}

-(id)initWithUrl:(NSString *)argUrl andTag:(NSString *)argTag
{
    self = [super init];
    [self Init];
    m_strUrl = [NSString stringWithFormat:@"%@%@", [AppConfigure GetWebServiceDomain],argUrl];
    m_strRequestTag = argTag;
    return self;
}

- (void)SetParamValue:(NSString*)argValue forKey:(NSString *)argKey;
{
    [m_dicParameters setValue:argValue forKey:argKey];
}

- (void)AddImageData:(UIImage*)argImage forKey:(NSString *)argKey;
{
    [m_dicImageParas setValue:argImage forKey:argKey];
}

-(void)PostAsynchronous
{
    [self Cancel];
    if([m_dicImageParas count] == 0)
    {
        m_pRequest = [m_pRequestManager POST:m_strUrl parameters:m_dicParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self RequestSucceedWithResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self RequestFailureWithError:error];
        }];
    }
    else
    {
        m_pRequest = [m_pRequestManager POST:m_strUrl parameters:m_dicParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSArray* arrKeys = m_dicImageParas.allKeys;
            for( NSString* strKey in arrKeys)
            {
                UIImage* pImage = [m_dicImageParas objectForKey:strKey];
                NSData *imageData = UIImageJPEGRepresentation(pImage, 0.7);
                [formData appendPartWithFileData:imageData
                                            name:strKey
                                        fileName:@"test.jpg"
                                        mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self RequestSucceedWithResponseObject:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self RequestFailureWithError:error];
        }];
    }
}

-(void)GetAsynchronous
{
    [self Cancel];
    m_pRequest = [m_pRequestManager GET:m_strUrl parameters:m_dicParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self RequestSucceedWithResponseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self RequestFailureWithError:error];
    }];
}

-(void)Cancel
{
    if(m_pRequest != nil)
        [m_pRequest cancel];
}

- (BOOL)proRequestRunning
{
    if (m_pRequest.state == NSURLSessionTaskStateRunning) {
        return YES;
    } else {
        return NO;
    }
}

//#pragma mark -- private method
///**
// *  获取token值
// *
// *  @param argToken token值
// */
//- (void)GetToken:(void(^)(NSString *token))argToken Failed:(void(^)(NSString *errMsg))argErrMsg
//{
//    NSLog(@"%@",[BUShowErrorMsg GetInstance].propToken);
//    
//    AFHTTPSessionManager *pRequestManager = [AFHTTPSessionManager manager];
//    pRequestManager.responseSerializer.acceptableContentTypes =  [m_pRequestManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
//    [pRequestManager POST:[NSString stringWithFormat:@"%@/appFunction!getToken.action",[AppConfigure GetWebServiceDomain]] parameters:@{@"secret":@"fhajhfjakfafhka"} progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSData *serializedData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:serializedData options:NSJSONReadingAllowFragments error:nil];
//        if ([responseJSON[@"errCode"] integerValue] == 0)
//        {
//            NSDictionary *tokenJson = responseJSON[@"map"];
//            NSString *token = tokenJson[@"token"];
//            [BUShowErrorMsg GetInstance].propToken = token;
//            argToken(token);
//        }
//        else
//        {
//            NSString *token = [BUShowErrorMsg GetInstance].propToken;
//            if (![token isEqualToString:@""] && token != nil)
//            {
//                argToken(token);
//            }
//            else
//            {
//                argErrMsg(@"网络异常，请检查网络后重新尝试");
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSString *token = [BUShowErrorMsg GetInstance].propToken;
//        if (![token isEqualToString:@""] && token != nil)
//        {
//            argToken(token);
//        }
//        else
//        {
//            argErrMsg(@"网络异常，请检查网络后重新尝试");
//        }
//    }];
//}

- (void)RequestSucceedWithResponseObject:(id)responseObject
{
    NSData *serializedData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    id responseJSON = [NSJSONSerialization JSONObjectWithData:serializedData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@---%@-----%@", responseObject, m_strRequestTag,m_strUrl);
    m_pResponseData =[RMMapper objectWithClass:[BUBaseResponseData class] fromDictionary:responseJSON];
    
    if(m_pResponseData.stateCode >= 1001 && m_pResponseData.stateCode <= 1029)
    {
        switch (m_pResponseData.stateCode) {
/*            case 1001:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"参数验证失败"];
                break;
            case 1002:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"客户端Token验证失败"];
                break;
            case 1003:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"数据库操作失败"];
                break;
            case 1004:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"用户不存在"];
                break;
            case 1005:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"重复注册"];
                break;
            case 1006:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"验证码错误"];
                break;
            case 1007:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"已经有存在的邀约"];
                break;
            case 1008:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"邀约码不存在"];
                break;
            case 1009:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"邀约已经过期"];
                break;
            case 1010:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"邀约不存在"];
                break;
            case 1011:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"你没有参加该活动"];
                break;
            case 1012:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"签到距离大于1000米"];
                break;
            case 1013:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"签到时间小于开始活动前15分钟"];
                break;
            case 1014:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"签到时间大于活动开始后15分钟"];
                break;
            case 1015:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"提现金额大于账户余额"];
                break;
            case 1016:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"活动已经开始"];
                break;
            case 1017:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"活动已经关闭"];
                break;
            case 1018:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"你已参加该活动"];
                break;
            case 1019:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"你已被临时限用"];
                break;
            case 1020:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"你已被封号"];
                break;
            case 1021:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"你已被屏蔽"];
                break;
            case 1022:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"参与活动的性别不符"];
                break;
            case 1023:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"参与活动的性别不符"];
                break;
            case 1024:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"旧密码错误"];
                break;
            case 1025:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"支付密码错误"];
                break;
            case 1026:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"订单不存在"];
                break;
            case 1027:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"订单已经支付"];
                break;
            case 1028:
                [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"红包不存在"];
            break;*/
            default:
                break;
        }
        NSLog(@"%@",m_pResponseData.errorMsg);
        if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(RequestErrorHappened:withErrorMsg:)])
        {
            [self.propDelegate RequestErrorHappened:self withErrorMsg:[NSString stringWithFormat:@"%i",m_pResponseData.stateCode]];
        }
    }
    else if([m_pResponseData class] == [BUBaseResponseData class])
    {
        NSArray* arrData =  [m_pResponseData ParseDataArray:self.propDataClass];
        if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestSucceeded: withResponseData:)])
        {
            [self.propDelegate RequestSucceeded:m_strRequestTag withResponseData:arrData];
        }
    }
    else
    {
        NSArray* arrData = [[NSArray alloc] initWithObjects:m_pResponseData, nil];
        if((self.propDelegate != nil) && [self.propDelegate respondsToSelector:@selector(RequestSucceeded: withResponseData:)])
        {
            [self.propDelegate RequestSucceeded:m_strRequestTag withResponseData:arrData];
        }
    }
}

- (void)RequestFailureWithError:(NSError *)error
{
    NSLog(@"%@", error);
    if (error.code == -1009  || error.code == -1005 || error.code == -1003 || error.code == -1001)
    {
        [[BUShowErrorMsg GetInstance] ShowErrorMessage:@"网络异常，请检查网络后重试!"];
    }
    if(self.propDelegate != nil && [self.propDelegate respondsToSelector:@selector(RequestErrorHappened:withErrorMsg:)])
    {
        [self.propDelegate RequestErrorHappened:self withErrorMsg:@""];
    }
}

@end
