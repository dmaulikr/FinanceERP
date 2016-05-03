//
//  ZYCalculatorViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/31.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorViewModel.h"

@interface ZYCalculatorViewModel ()



@end

@implementation ZYCalculatorViewModel

+ (ZYCalculatorViewModel*)viewModelWithType:(ZYCalculatorType)type
{
    ZYCalculatorViewModel *viewModel = [[ZYCalculatorViewModel alloc] initWithType:type];
    return viewModel;
}
- (instancetype)initWithType:(ZYCalculatorType)type
{
    self = [super init];
    if (self) {
        _calculatorType = type;
        _valueModel = [[ZYCalculatorValueModel alloc] init];///初始化数据
        [self blendModel];
    }
    return self;
}
- (void)blendModel
{
    RACChannelTo(self,calculatorComputingFormulaSelected) = RACChannelTo(_valueModel,calculatorComputingFormulaValue);
    
    
    RACChannelTo(self,calculatorPaymentTypeSelected) = RACChannelTo(_valueModel,calculatorPaymentTypeValue);
    
    
    [[RACChannelTo(self,calculatorMonthsSelected) map:^id(NSNumber *value) {
        return @((30-[value longLongValue])*12);///年数 转换 为月数（期）
    }] subscribe:RACChannelTo(_valueModel,calculatorMonthsValue)];
    
    
    [[RACChannelTo(self,calculatorInterestSelected) map:^id(NSNumber *value) {
        switch (value.longLongValue) {
            case 0:
                return @(1);
                break;
            case 1:
                return @(0.9);
                break;
            case 2:
                return @(0.85);
                break;
            case 3:
                return @(0.7);
                break;
            default:
                return @(1);
                break;
        }
    }] subscribe:RACChannelTo(_valueModel,calculatorInterestValue)];
    
    
    [[RACChannelTo(self,calculatorLoanRateSelected) map:^id(NSNumber *value) {
        return @(7-value.longLongValue);//由于展示的时候第一个为7成 需要倒序 然后1就代表1成 以此类推
    }] subscribe:RACChannelTo(_valueModel,calculatorLoanRateValue)];
    
    
    
    [[RACChannelTo(self, calculatorTotleMoney) map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorTotleMoneyValue)];
    
    [[RACChannelTo(self, calculatorArea) map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorAreaValue)];
    
    [[RACChannelTo(self, calculatorBussinessTotleMoney) map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorBussinessTotleMoneyValue)];
    
    [[RACChannelTo(self, calculatorPublicFundsTotleMoney)  map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorPublicFundsTotleMoneyValue)];
    
    [[RACChannelTo(self, calculatorBussinessInterestRate) map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorBussinessInterestRateValue)];
    
    [[RACChannelTo(self, calculatorPublicFundsInterestRate) map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorPublicFundsInterestRateValue)];
    
    [[RACChannelTo(self, calculatorInterestRate) map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorInterestRateValue)];
    
    [[RACChannelTo(self, calculatorPricePerCentiare) map:^id(NSString *value) {
        return @([value floatValue]);
    }] subscribe:RACChannelTo(_valueModel,calculatorPricePerCentiareValue)];
    
    [[RACObserve(self, calculatorType) map:^id(id value) {
        return value;
    }] subscribe:RACChannelTo(_valueModel,calculatorType)];
    
    self.calculatorComputingFormulaSelected = ZYCalculatorComputingTypePrice;
}

- (NSString *)computeError
{
    NSString *tip = nil;
    if(self.calculatorTotleMoney.length==0&&self.calculatorType != ZYCalculatorTypeAdmixture&&self.calculatorComputingFormulaSelected != ZYCalculatorComputingTypeArea)
    {
        tip = @"请输入贷款总额";
    }
    if(self.calculatorArea.length==0&&self.calculatorComputingFormulaSelected==ZYCalculatorComputingTypeArea&&self.calculatorType != ZYCalculatorTypeAdmixture)
    {
        tip = @"请输入房屋面积";
    }
    if(self.calculatorPricePerCentiare.length==0&&self.calculatorComputingFormulaSelected==ZYCalculatorComputingTypeArea&&self.calculatorType != ZYCalculatorTypeAdmixture)
    {
        tip = @"请输入每平米价格";
    }
    if(self.calculatorInterestRate.length==0&&self.calculatorType != ZYCalculatorTypeAdmixture)
    {
        tip = @"请输入贷款利率";
    }
    if(self.calculatorBussinessTotleMoney.length==0&&self.calculatorType == ZYCalculatorTypeAdmixture)
    {
        tip = @"请输入商业贷款总额";
    }
    if(self.calculatorBussinessInterestRate.length==0&&self.calculatorType == ZYCalculatorTypeAdmixture)
    {
        tip = @"请输入商业贷款利率";
    }
    if(self.calculatorPublicFundsTotleMoney.length==0&&self.calculatorType == ZYCalculatorTypeAdmixture)
    {
        tip = @"请输入公积金贷款总额";
    }
    if(self.calculatorPublicFundsInterestRate.length==0&&self.calculatorType == ZYCalculatorTypeAdmixture)
    {
        tip = @"请输入公积金贷款利率";
    }
    return tip;
}
- (ZYCalculatorValueModel*)getValueModel
{
    return self.valueModel;
}
@end
