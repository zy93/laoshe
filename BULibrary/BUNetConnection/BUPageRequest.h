//
//  BUPageRequest.h
//  pbuSymbolTechPaiPaiJing
//
//  Created by Xue Yan on 15-8-6.
//  Copyright (c) 2015年 周杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUAFHttpRequest.h"

@interface BUPageRequest : NSObject <BUAFHttpRequestDelegate>
{
    NSString* m_strIndexKey;
    NSString* m_strPageCountKey;
    NSMutableArray* m_arrRequests;
    NSString* m_strUrl;
    NSDictionary* m_dicParameters;
    NSString* m_strRequestTag;
    
    BUAFHttpRequest* m_pRequest;
}

@property (assign) NSInteger propIndex;
@property (assign) NSInteger propPageCount;

@property (assign) BOOL propSilent;
@property (nonatomic, strong)  NSString* propRequestTag;
@property (nonatomic, strong) Class propDataClass;
@property (weak, nonatomic) id<BUAFHttpRequestDelegate> propDelegate;

-(id)initWithUrl:(NSString*)argUrl andTag:(NSString*)argTag;
-(void)SetParamValue:(NSString *)argValue forKey:(NSString *)argKey;

-(void)RequestFromStart;
-(void)RequestMore;

@end
