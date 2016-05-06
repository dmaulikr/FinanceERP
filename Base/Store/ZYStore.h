//
//  ZYStore.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYStore : NSObject

+ (void)copyDBWhenNotExit;
+ (void)updateDB;
+ (void)copyDB;

- (void)creatData;
@end
