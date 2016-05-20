//
//  ZYFeedbackViewViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFeedbackViewViewModel.h"

@implementation ZYFeedbackViewViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)feedbackRequest
{
    if(self.feedbackText.length<5)
    {
        self.error = @"请输入五个字以上";
        return;
    }
    
    ZYFeedbackRequest *request = [ZYFeedbackRequest request];
    request.user_id = [ZYUser user].pid;
    request.feedback_content = self.feedbackText;
    request.problem_source = 3;
    self.loading = YES;
    _feedbackSuccess = NO;
    [[[ZYRoute route] feedback:request] subscribeNext:^(id x) {
        self.loading = NO;
        self.error = x;
        self.feedbackSuccess = YES;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
        self.feedbackSuccess = NO;
    } completed:^{
        
    }];
}

@end
