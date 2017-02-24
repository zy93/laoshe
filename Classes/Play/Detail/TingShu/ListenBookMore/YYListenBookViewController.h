//
//  ViewController.h
//  bookMore
//
//  Created by 张雨 on 2017/2/21.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUCustomViewController.h"

@interface YYListenBookViewController : BUCustomViewController

@property (nonatomic, strong) NSArray *m_pDataArr;

-(void)ClickCheckBookWithId:(NSString *)mId;

@end

