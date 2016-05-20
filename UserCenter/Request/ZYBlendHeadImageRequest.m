//
//  ZYBlendHeadImageRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBlendHeadImageRequest.h"

@implementation ZYBlendHeadImageRequest
- (NSString *)requestUrl {
    return  @"/uploadPhoto.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",
             @"file_id"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 0;
}
@end
