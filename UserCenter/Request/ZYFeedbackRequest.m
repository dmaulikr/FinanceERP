//
//  ZYFeedbackRequest.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFeedbackRequest.h"

@implementation ZYFeedbackRequest
- (NSString *)requestUrl {
    return  @"/problemFeedback.action";
}
- (id)requestArgument {
    return [self mj_keyValues];
}
+ (NSArray*)mj_allowedPropertyNames
{
    return @[@"user_id",
             @"feedback_content",
             @"problem_source"];
}
- (NSInteger)cacheTimeInSeconds
{
    return 0;
}
@end
