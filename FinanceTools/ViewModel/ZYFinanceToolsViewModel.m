//
//  ZYFinanceToolsViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYFinanceToolsViewModel.h"

@implementation ZYFinanceToolsViewModel

- (void)requestFunctionList
{
    @try {
        [self loadDataFromFile];
    }
    @catch (NSException *exception) {
        NSLog(@"读取功能列表错误");
    }
    @finally {
        
    }
}

- (void)loadDataFromFile
{
    self.housingLoanCalculatorFunction = YES;
    self.housePropertyInquiryFunction = NO;
    self.transferInquiryFunction = NO;
    self.consultFilesFunction = NO;
    self.makeAppointmentFunction = NO;
}
@end
