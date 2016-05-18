//
//  ZYCustomerDetailViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerDetailViewModel.h"

@implementation ZYCustomerDetailViewModel
- (NSArray*)customerDetailTabTitles
{
    if(_customerDetailTabTitles==nil)
    {
        _customerDetailTabTitles = @[@"工作信息",@"社保信息",@"家庭信息",@"开户信息",@"公司信息",@"关系人信息",@"征信记录"];
    }
    return _customerDetailTabTitles;
}
+ (RACSignal*)customerEducationArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYEducationModel getUsingLKDBHelper] search:[ZYEducationModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)workTitleArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYWorkTitleModel getUsingLKDBHelper] search:[ZYWorkTitleModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)incomeTypeArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYIncomeTypeModel getUsingLKDBHelper] search:[ZYIncomeTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)incomeDayArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:31];
        for(int i=1;i<=31;i++)
        {
            [arr addObject:[NSString stringWithFormat:@"%d日",i]];
        }
        [subscriber sendNext:arr];
        [subscriber sendCompleted];
        return nil;
    }];
    return signal;
}
@end
