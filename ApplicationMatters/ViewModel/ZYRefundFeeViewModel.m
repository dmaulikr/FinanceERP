//
//  ZYRefundFeeViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYRefundFeeViewModel.h"

@implementation ZYRefundFeeViewModel

- (void)getFeeInfo
{
    ZYFeeInfoRequest *request = [ZYFeeInfoRequest request];
    request.user_id = [ZYUser user].pid;
    request.pid = self.model.pid;
    request.project_id = self.model.project_id;
    request.type = self.type;
    self.loading = YES;
    [[[ZYRoute route] feeInfoRequest:request] subscribeNext:^(id x) {
        self.loading = NO;
        ZYFeeModel *fee = x;
        self.money = [NSString stringWithFormat:@"%.2f",fee.return_fee];
        self.accountName = fee.account_name;
        self.account = fee.account;
        self.accountBank = fee.bank_name;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
    } completed:^{
        
    }];
}
- (void)refundFeeRequest
{
    ZYRefundFeeRequest *request = [ZYRefundFeeRequest request];
    request.user_id = [ZYUser user].pid;
    request.pid = self.model.pid;
    request.project_id = self.model.project_id;
    request.type = self.type;
    request.return_fee = [self.money floatValue];
    request.account_name = self.accountName;
    request.account = self.account;
    request.bank_name = self.accountBank;
    
    self.loading = YES;
    [[[ZYRoute route] refundFeeRequest:request] subscribeNext:^(id x) {
        self.loading = NO;
        self.error = x;
        self.success = YES;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
        self.success = NO;
    } completed:^{
        
    }];
}

@end
