//
//  ZYCalculatorResultViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorResultViewModel.h"

@implementation ZYCalculatorResultViewModel

+ (ZYCalculatorResultViewModel*)viewModelWithType:(ZYCalculatorType)type
{
    ZYCalculatorResultViewModel *viewModel = [[ZYCalculatorResultViewModel alloc] init];
    viewModel.calculatorType = type;
    return viewModel;
}
- (ZYCaclulatorResultModel*)modelAtIndex:(NSInteger)index
{
    return self.dataSource[index];
}

- (NSString *)totleMoneyContent
{
    if(self.calculatorType==ZYCalculatorTypeAdmixture)///混合贷款 总额计算
    {
        
        _totleMoneyContent = [NSString stringWithFormat:@"贷款总额:%@",[NSNumber showPriceWithTenThousand:[_valueModel.calculatorBussinessTotleMoneyValue floatValue]+[_valueModel.calculatorPublicFundsTotleMoneyValue floatValue]]];
    }
    else
    {
        CGFloat totleMoney = 0.0;
        if(_valueModel.calculatorComputingFormulaValue==ZYCalculatorComputingTypePrice)///按照面积计算
        {
            totleMoney = [_valueModel.calculatorTotleMoneyValue floatValue];
        }
        else if(_valueModel.calculatorComputingFormulaValue==ZYCalculatorComputingTypeArea)///按照面积计算
        {
            totleMoney = [_valueModel.calculatorAreaValue floatValue]*[_valueModel.calculatorPricePerCentiareValue floatValue]*(_valueModel.calculatorLoanRateValue/10.f)/10000.f;///换算成万元
        }
        _totleMoneyContent = [NSString stringWithFormat:@"贷款总额:%@",[NSNumber showPriceWithTenThousand:totleMoney]];
    }
    return _totleMoneyContent;
}
- (NSString *)totlePaymentContent
{
    _totleInterestContent = [NSString stringWithFormat:@"还款总额:%@",[NSNumber showPriceWithTenThousand:[self computeTotalPayment]]];
    return _totleInterestContent;
    return _totlePaymentContent;
}
- (NSString *)paymentMonthContent
{
    _paymentMonthContent = [NSString stringWithFormat:@"还款月数:%ld个月",(long)_valueModel.calculatorMonthsValue];
    return _paymentMonthContent;
}
- (NSString *)totleInterestContent
{
    _totleInterestContent = [NSString stringWithFormat:@"利息总额:%@",[NSNumber showPriceWithTenThousand:[self computeTotalInterest]]];
    return _totleInterestContent;
}
- (NSString *)paymentPerMonthContent
{
    if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
    {
        _paymentPerMonthContent = [NSString stringWithFormat:@"每期还款:%@",[NSNumber showPriceWithTenThousand:[self computePaymentPerMonth]]];
    }
    else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金
    {
        _paymentPerMonthContent = [NSString stringWithFormat:@"每期本金:%@",[NSNumber showPriceWithTenThousand:[self computePaymentPerMonth]]];
    }
    return _paymentPerMonthContent;
}
- (NSString *)bussinessInterestRateContent
{
    if(self.calculatorType==ZYCalculatorTypeBusinessLoan)///非混合贷款 总额计算
    {
        _bussinessInterestRateContent = [NSString stringWithFormat:@"商业利率:%@％",_valueModel.calculatorInterestRateValue];
    }
    else if(self.calculatorType==ZYCalculatorTypePublicFunds)
    {
        _bussinessInterestRateContent = [NSString stringWithFormat:@"公积金利率:%@％",_valueModel.calculatorInterestRateValue];
    }
    else
    {
        _bussinessInterestRateContent = [NSString stringWithFormat:@"商业利率:%@％",_valueModel.calculatorBussinessInterestRateValue];
    }
    return _bussinessInterestRateContent;
}
- (NSString *)publicFundsInterestRateContent
{
    if(self.calculatorType==ZYCalculatorTypeAdmixture)
    {
        _publicFundsInterestRateContent = [NSString stringWithFormat:@"公积金利率:%@％",_valueModel.calculatorPublicFundsInterestRateValue];
    }
    else
    {
        _publicFundsInterestRateContent = @"";
    }
    return _publicFundsInterestRateContent;
}

- (CGFloat)computeTotalInterest
{
    CGFloat totleMoney = 0.0;
    if(_valueModel.calculatorComputingFormulaValue==ZYCalculatorComputingTypePrice)///按照面积计算
    {
        totleMoney = [_valueModel.calculatorTotleMoneyValue floatValue];
    }
    else if(_valueModel.calculatorComputingFormulaValue==ZYCalculatorComputingTypeArea)///按照面积计算
    {
        totleMoney = [_valueModel.calculatorAreaValue floatValue]*[_valueModel.calculatorPricePerCentiareValue floatValue]*(_valueModel.calculatorLoanRateValue/10.f)/10000.f;
    }
    return [self computeTotalPayment]-totleMoney;
}
- (CGFloat)computePaymentPerMonth
{
    CGFloat paymentPerMonth;
    if(self.calculatorType == ZYCalculatorTypeBusinessLoan||self.calculatorType == ZYCalculatorTypePublicFunds)/// 非混合贷款
    {
        CGFloat totleMoney = 0.0;
        if(_valueModel.calculatorComputingFormulaValue==ZYCalculatorComputingTypePrice)///按照金额
        {
            totleMoney = [_valueModel.calculatorTotleMoneyValue floatValue];
        }
        else if(_valueModel.calculatorComputingFormulaValue==ZYCalculatorComputingTypeArea)///按照面积计算
        {
            totleMoney = [_valueModel.calculatorAreaValue floatValue]*[_valueModel.calculatorPricePerCentiareValue floatValue]*(_valueModel.calculatorLoanRateValue/10.f)/10000.f;
        }
        
        CGFloat monthLoanRate = [_valueModel.calculatorInterestRateValue floatValue]*_valueModel.calculatorInterestValue/12.f/100;///月利率 利率均未带百分号
        NSInteger month = _valueModel.calculatorMonthsValue;
        if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
        {
            paymentPerMonth = (totleMoney*monthLoanRate*pow((1+monthLoanRate),month))/(pow((1+monthLoanRate),month)-1);
        }
        else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金 计算出的每月应还本金
        {
            paymentPerMonth = totleMoney/month;
        }
    }
    else if (self.calculatorType == ZYCalculatorTypeAdmixture)
    {
        CGFloat totleMoney = [_valueModel.calculatorBussinessTotleMoneyValue floatValue];
        
        CGFloat paymentPerMonthBussiness = 0.0;
        CGFloat monthLoanRate = [_valueModel.calculatorBussinessInterestRateValue floatValue]*_valueModel.calculatorInterestValue/12.f/100;///月利率 利率均未带百分号 商业贷款可以打折
        NSInteger month = _valueModel.calculatorMonthsValue;
        if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
        {
            paymentPerMonthBussiness = (totleMoney*monthLoanRate*pow((1+monthLoanRate),month))/(pow((1+monthLoanRate),month)-1);
        }
        else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金 计算出的每月应还本金
        {
            paymentPerMonthBussiness = totleMoney/month;
        }
        
        totleMoney = [_valueModel.calculatorPublicFundsTotleMoneyValue floatValue];
        
        CGFloat paymentPerMonthPublic = 0.0;
        monthLoanRate = [_valueModel.calculatorPublicFundsInterestRateValue floatValue]/12.f/100;///月利率 利率均未带百分号 商业贷款可以打折
        if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
        {
            paymentPerMonthPublic = (totleMoney*monthLoanRate*pow((1+monthLoanRate),month))/(pow((1+monthLoanRate),month)-1);
        }
        else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金 计算出的每月应还本金
        {
            paymentPerMonthPublic = totleMoney/month;
        }
        paymentPerMonth = paymentPerMonthBussiness+paymentPerMonthPublic;
    }
    return paymentPerMonth;
}
- (CGFloat)computeTotalPayment
{
    CGFloat totlePayment;///房贷总利息计算
    if(self.calculatorType == ZYCalculatorTypeBusinessLoan||self.calculatorType == ZYCalculatorTypePublicFunds)/// 非混合贷款
    {
        CGFloat totleMoney = 0.0;
        if(_valueModel.calculatorComputingFormulaValue ==ZYCalculatorComputingTypePrice)///按照金额计算
        {
            totleMoney = [_valueModel.calculatorTotleMoneyValue floatValue];
        }
        else if(_valueModel.calculatorComputingFormulaValue ==ZYCalculatorComputingTypeArea)///按照面积计算
        {
            totleMoney = [_valueModel.calculatorAreaValue floatValue]*[_valueModel.calculatorPricePerCentiareValue floatValue]*(_valueModel.calculatorLoanRateValue/10.f)/10000.f;
        }
        
        CGFloat monthLoanRate = [_valueModel.calculatorInterestRateValue floatValue]*_valueModel.calculatorInterestValue/12.f/100.f;///月利率 利率均未带百分号
        NSInteger month = _valueModel.calculatorMonthsValue;
        if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
        {
            totlePayment = (totleMoney*month*monthLoanRate*pow((1+monthLoanRate),month))/(pow((1+monthLoanRate),month)-1);
        }
        else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金
        {
            totlePayment = (month+1)*totleMoney*monthLoanRate/2.f+totleMoney;
        }
    }
    else if (self.calculatorType == ZYCalculatorTypeAdmixture)
    {
        CGFloat totleMoney = [_valueModel.calculatorBussinessTotleMoneyValue floatValue];
        
        CGFloat totlePaymentBussiness = 0.0;
        CGFloat monthLoanRate = [_valueModel.calculatorBussinessInterestRateValue floatValue]*_valueModel.calculatorInterestValue/12.f/100;///月利率 利率均未带百分号 商业贷款可以打折
        NSInteger month = _valueModel.calculatorMonthsValue;
        if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
        {
            totlePaymentBussiness = (totleMoney*month*monthLoanRate*pow((1+monthLoanRate),month))/(pow((1+monthLoanRate),month)-1);
        }
        else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金 计算出的每月应还本金
        {
            totlePaymentBussiness = (month+1)*totleMoney*monthLoanRate/2.f+totleMoney;
        }
        
        totleMoney = [_valueModel.calculatorPublicFundsTotleMoneyValue floatValue];
        
        CGFloat totlePaymentPublic = 0.0;
        monthLoanRate = [_valueModel.calculatorPublicFundsInterestRateValue floatValue]/12.f/100;///月利率 利率均未带百分号 商业贷款可以打折
        if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
        {
            totlePaymentPublic = (totleMoney*month*monthLoanRate*pow((1+monthLoanRate),month))/(pow((1+monthLoanRate),month)-1);
        }
        else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金 计算出的每月应还本金
        {
            totlePaymentPublic = (month+1)*totleMoney*monthLoanRate/2.f+totleMoney;
        }
        totlePayment = totlePaymentBussiness+totlePaymentPublic;
    }
    return totlePayment;
}
- (void)computePaymentAllMonth
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:30];
    if(self.calculatorType == ZYCalculatorTypeBusinessLoan||self.calculatorType == ZYCalculatorTypePublicFunds)/// 非混合贷款
    {
        CGFloat totleMoney = 0.0;
        if(_valueModel.calculatorComputingFormulaValue ==ZYCalculatorComputingTypePrice)///按照金额计算
        {
            totleMoney = [_valueModel.calculatorTotleMoneyValue floatValue];
        }
        else if(_valueModel.calculatorComputingFormulaValue ==ZYCalculatorComputingTypeArea)///按照面积计算
        {
            totleMoney = [_valueModel.calculatorAreaValue floatValue]*[_valueModel.calculatorPricePerCentiareValue floatValue]*(_valueModel.calculatorLoanRateValue/10.f)/10000.f;
        }
        
        CGFloat monthLoanRate = [_valueModel.calculatorInterestRateValue floatValue]*_valueModel.calculatorInterestValue/12.f/100;///月利率 利率均未带百分号
        NSInteger month = _valueModel.calculatorMonthsValue;
        CGFloat hasPayment = 0.0;
        CGFloat lastMoney = totleMoney;///剩余本金
        for (int i=0; i<month; i++) {
            ZYCaclulatorResultModel *model = [[ZYCaclulatorResultModel alloc] init];
            if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
            {
                model.paymenyPerMonth = [self computePaymentPerMonth];
                model.interestPerMonth = lastMoney*monthLoanRate;///每月还的利息
                model.moneyPerMonth = model.paymenyPerMonth - model.interestPerMonth;///每月还的本金
                model.lastMoney = lastMoney;
                lastMoney = lastMoney-model.moneyPerMonth;///剩余本金
            }
            else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金
            {
                model.paymenyPerMonth = [self computePaymentPerMonth]+(totleMoney-hasPayment)*monthLoanRate;
                model.moneyPerMonth = totleMoney/month;
                model.interestPerMonth = (totleMoney-hasPayment)*monthLoanRate;
                model.lastMoney = lastMoney;
                
                hasPayment = hasPayment+model.moneyPerMonth;///已经还的本金
                lastMoney = lastMoney-model.moneyPerMonth;///剩余本金
            }
            model.month = i+1;
            [arr addObject:model];
        }
    }
    else if (self.calculatorType == ZYCalculatorTypeAdmixture)
    {
        CGFloat totleMoneyBusiness = [_valueModel.calculatorBussinessTotleMoneyValue floatValue];
        CGFloat totleMoneyPublic = [_valueModel.calculatorPublicFundsTotleMoneyValue floatValue];
        
        CGFloat monthLoanRateBusiness = [_valueModel.calculatorBussinessInterestRateValue floatValue]*_valueModel.calculatorInterestValue/12.f/100;///月利率 利率均未带百分号
        CGFloat monthLoanRatePublic = [_valueModel.calculatorPublicFundsInterestRateValue floatValue]/12.f/100;///月利率 利率均未带百分号
        NSInteger month = _valueModel.calculatorMonthsValue;
        CGFloat hasPaymentBusiness = 0.0;
        CGFloat hasPaymentPublic = 0.0;
        CGFloat lastMoneyBusiness = totleMoneyBusiness;///剩余本金
        CGFloat lastMoneyPublic = totleMoneyPublic;
        for (int i=0; i<month; i++) {
            ZYCaclulatorResultModel *model = [[ZYCaclulatorResultModel alloc] init];
            if(_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeInterest)///等额本息
            {
                CGFloat paymentPerMonthBussiness = 0.0;
                CGFloat paymentPerMonthPublic = 0.0;
                paymentPerMonthBussiness = (totleMoneyBusiness*monthLoanRateBusiness*pow((1+monthLoanRateBusiness),month))/(pow((1+monthLoanRateBusiness),month)-1);
                paymentPerMonthPublic = (totleMoneyPublic*monthLoanRatePublic*pow((1+monthLoanRatePublic),month))/(pow((1+monthLoanRatePublic),month)-1);
                
                model.paymenyPerMonth = paymentPerMonthBussiness+paymentPerMonthPublic;
                model.interestPerMonth = lastMoneyBusiness*monthLoanRateBusiness+lastMoneyPublic*monthLoanRatePublic;///每月还的利息
                model.moneyPerMonth = model.paymenyPerMonth - model.interestPerMonth;///每月还的本金
                model.lastMoney = lastMoneyBusiness+lastMoneyPublic;
                lastMoneyBusiness = lastMoneyBusiness-(paymentPerMonthBussiness-lastMoneyBusiness*monthLoanRateBusiness);
                lastMoneyPublic = lastMoneyPublic-(paymentPerMonthPublic-lastMoneyPublic*monthLoanRatePublic);
            }
            else if (_valueModel.calculatorPaymentTypeValue==ZYCalculatorPaymentTypeMoney)///等额本金
            {
                //获取的只有每期的本金还需要加上每期的利息
                model.paymenyPerMonth = [self computePaymentPerMonth]+(totleMoneyBusiness-hasPaymentBusiness)*monthLoanRateBusiness+(totleMoneyPublic-hasPaymentPublic)*monthLoanRatePublic;
                model.moneyPerMonth = (totleMoneyBusiness+totleMoneyPublic)/month;
                model.interestPerMonth = (totleMoneyBusiness-hasPaymentBusiness)*monthLoanRateBusiness+(totleMoneyPublic-hasPaymentPublic)*monthLoanRatePublic;
                model.lastMoney = lastMoneyBusiness+lastMoneyPublic;
                
                hasPaymentBusiness = hasPaymentBusiness+totleMoneyBusiness/month;///已经还的本金
                hasPaymentPublic = hasPaymentPublic+totleMoneyPublic/month;///已经还的本金
                
                lastMoneyBusiness = lastMoneyBusiness-totleMoneyBusiness/month;///剩余本金
                lastMoneyPublic = lastMoneyPublic-totleMoneyPublic/month;///剩余本金
            }
            model.month = i+1;
            [arr addObject:model];
        }
    }
    self.dataSource = arr;
}
@end
