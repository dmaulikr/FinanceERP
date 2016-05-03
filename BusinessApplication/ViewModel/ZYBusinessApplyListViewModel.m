//
//  ZYBusinessApplyListViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessApplyListViewModel.h"

@implementation ZYBusinessApplyListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _foreclosureHouse = YES;
        _downPaymentMortgage = YES;
        _houseMortgage = YES;
        _customerFundMortgage = YES;
        _creditMortgage = YES;
    }
    return self;
}

@end
