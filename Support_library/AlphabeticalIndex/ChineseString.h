//
//  ChineseString.h
//  ChineseSort
//
//  Created by Bill on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QYCityData;

@interface ChineseString : NSObject

@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;
@property (nonatomic, strong)QYCityData *relationData;

//-----  返回tableview右方indexArray
+(NSMutableArray*)indexArray:(NSArray*)stringArr;
//-----  返回联系人
+(NSMutableArray*)letterSortArray:(NSArray*)stringArr;

///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

//排序data
+(NSMutableArray*)SortArrayWithData:(NSArray *)argArr;

@end
