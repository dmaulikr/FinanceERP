//
//  ZYCalculatorValueModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/2.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorValueModel.h"

@implementation ZYCalculatorValueModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+ (NSArray*)calculatorComputingFormulaArr
{
    return @[@"根据贷款金额计算",@"根据单价面积计算"];
}
+ (NSArray*)calculatorInterestArr
{
    return @[@"基础利率",@"9折",@"85折",@"7折"];
}
+ (NSArray*)calculatorMonthsArr
{
    NSMutableArray *months = [NSMutableArray arrayWithCapacity:30];
    for(int i=30;i>0;i--)
    {
        NSString *month = [NSString stringWithFormat:@"%d年(%d期)",i,i*12];
        [months addObject:month];
    }
    return months;
}
+ (NSArray*)calculatorPaymentTypeArr
{
    return @[@"等额本息",@"等额本金"];
}
+ (NSArray*)calculatorLoanRateArr
{
    NSMutableArray *months = [NSMutableArray arrayWithCapacity:7];
    for(int i=7;i>0;i--)
    {
        NSString *month = [NSString stringWithFormat:@"%d成",i];
        [months addObject:month];
    }
    return months;
}

@end
