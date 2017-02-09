//
//  ChineseString.m
//  ChineseSort
//
//  Created by Bill on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChineseString.h"
#import "pinyin.h"

@implementation ChineseString

@synthesize string;
@synthesize pinYin;

#pragma mark - 返回tableview右方 indexArray
+(NSMutableArray*)indexArray:(NSArray*)stringArr
{
    NSMutableArray *tempArray = [self returnSortChineseArrar:stringArr];
    NSMutableArray *A_Result=[NSMutableArray array];
    NSString *tempString ;
    
//    for (ChineseString *ddd in tempArray) {
//        DLog(@"&&&& == %@",ddd.pinYin);
//    }
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
//        DLog(@"66666 == %@",pinyin);
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    
//    DLog(@"**** == %@",A_Result);
    
    return A_Result;
}

#pragma mark - 返回联系人
+(NSMutableArray*)letterSortArray:(NSArray*)stringArr
{
    NSMutableArray *tempArray = [self returnSortChineseArrar:stringArr];
    NSMutableArray *LetterResult=[NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString ;
    //拼音分组
    for (NSString* object in tempArray) {
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        NSString *string = ((ChineseString*)object).string;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:string];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:string];
        }
    }
    return LetterResult;
}


//过滤指定字符串   里面的指定字符根据自己的需要添加
+(NSString*)removeSpecialCharacter: (NSString *)str
{
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡&curren;|&sect;&uml;「」『』￠￢￣~@#&*（）——+|《》$_€"]];
//    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡¤|§¨「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound)
    {
        return [self removeSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}

///////////////////
//
//返回排序好的字符拼音
//
///////////////////
+(NSMutableArray*)returnSortChineseArrar:(NSArray*)stringArr
{
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringArr count];i++)
    {
        ChineseString *chineseString=[[ChineseString alloc]init];
        chineseString.string=[NSString stringWithString:[stringArr objectAtIndex:i]];
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([predicate evaluateWithObject:chineseString.string]) {
            //首字母大写
            chineseString.pinYin = [chineseString.string capitalizedString] ;
        }
        else {
            if(![chineseString.string isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseString.string.length;j++){
                    
                    char firstLetter = pinyinFirstLetter([chineseString.string characterAtIndex:j]);
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",firstLetter]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin = pinYinResult;
            }
            else {
                chineseString.pinYin=@"";
            }
        }
        
        [chineseStringsArray addObject:chineseString];
    }

    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];

    return chineseStringsArray;
}

#pragma mark - 返回一组字母排序数组
+(NSMutableArray*)SortArray:(NSArray*)stringArr
{
    NSMutableArray *tempArray = [self returnSortChineseArrar:stringArr];
    
    //把排序好的内容从ChineseString类中提取出来
    NSMutableArray *result=[NSMutableArray array];
    for(int i=0;i<[stringArr count];i++){
        [result addObject:((ChineseString*)[tempArray objectAtIndex:i]).string];
    }
    return result;
}

//add
#pragma mark - 返回data数组
+(NSMutableArray*)SortArrayWithData:(NSArray *)argArr
{
    NSMutableArray *tempArray = [self GetSortChineseArr:argArr];
    NSMutableArray *LetterResult=[NSMutableArray array];
    NSMutableArray *item = [NSMutableArray array];
    NSString *tempString ;
    //拼音分组
    for (NSString* object in tempArray) {
        if(((ChineseString*)object).pinYin.length ==0)
        {
            continue;
        }
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        //        NSString *string = ((ChineseString*)object).string;
        QYCityData *pData = ((ChineseString*)object).relationData;
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            //分组
            item = [NSMutableArray array];
            [item  addObject:pData];
            [LetterResult addObject:item];
            //遍历
            tempString = pinyin;
        }else//相同
        {
            [item  addObject:pData];
        }
    }
    return LetterResult;
}

+(NSMutableArray *)GetSortChineseArr:(NSArray *)argArr
{
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[argArr count];i++)
    {
        ChineseString *chineseString=[[ChineseString alloc]init];
        QYCityData *pData = argArr[i];
        
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([predicate evaluateWithObject:chineseString.string]) {
            //首字母大写
            chineseString.pinYin = [chineseString.string capitalizedString] ;
            chineseString.relationData = pData;
        }
        else {
            if(![chineseString.string isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseString.string.length;j++){
                    
                    char firstLetter = pinyinFirstLetter([chineseString.string characterAtIndex:j]);
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",firstLetter]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin = pinYinResult;
                chineseString.relationData = pData;
            }
            else {
                chineseString.pinYin=@"";
                chineseString.relationData = pData;
            }
        }
        
        [chineseStringsArray addObject:chineseString];
    }
    
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringsArray;
}
@end
