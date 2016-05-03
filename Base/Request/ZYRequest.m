//
//  ZYRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRequest.h"
#import <YTKNetworkConfig.h>
@implementation ZYRequest

+ (instancetype)request
{
    ZYRequest *request = [[[self class] alloc] init];
    return request;
}
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}
- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{
             @"Type":@"application/json",
             @"Content-Type":@"application/json;charset=utf-8",
             @"charset":@"utf-8",
             @"Accept-Version":@"api_v1",
            };
}

@end
