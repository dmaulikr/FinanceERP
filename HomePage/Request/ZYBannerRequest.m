//
//  ZYBannerRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBannerRequest.h"

@implementation ZYBannerRequest
- (NSString *)requestUrl {
    return  @"/getAdvPicList.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 24*60*60;
}
@end
