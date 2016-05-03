//
//  ZYReadModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/22.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYReadModel.h"

@implementation ZYReadModel
+ (LKDBHelper*)getUsingLKDBHelper
{
    static LKDBHelper* helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"QFDB" ofType:@"db"];
        helper = [[LKDBHelper alloc] initWithDBPath:path];
    });
    return helper;
}
@end
