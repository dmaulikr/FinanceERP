//
//  ZYCalculatorResultViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYCalculatorValueModel.h"
#import "ZYCaclulatorResultModel.h"

@interface ZYCalculatorResultViewModel : ZYViewModel

@property (assign,nonatomic)ZYCalculatorType calculatorType;
#pragma mark - 页面显示的数据
/**
 *  总贷款额
 */
@property (copy, nonatomic)NSString *totleMoneyContent;
/**
 *  总还款额
 */
@property (copy, nonatomic)NSString *totlePaymentContent;
/**
 *  还款期数
 */
@property (copy, nonatomic)NSString *paymentMonthContent;
/**
 *  利息总额
 */
@property (copy, nonatomic)NSString *totleInterestContent;
/**
 *  每月月供
 */
@property (copy, nonatomic)NSString *paymentPerMonthContent;

@property (copy, nonatomic)NSString *bussinessInterestRateContent;
@property (copy, nonatomic)NSString *publicFundsInterestRateContent;

#pragma mark - 计算需要的数据

@property(nonatomic,strong)ZYCalculatorValueModel *valueModel;

//@property (strong, nonatomic)NSNumber *calculatorComputingFormulaValue;///计算类型
//
//@property (strong, nonatomic)NSNumber *calculatorTotleMoneyValue;///按照面积计算
//
//@property (strong, nonatomic)NSNumber *calculatorAreaValue;///面积
//@property (strong, nonatomic)NSNumber *calculatorPricePerCentiareValue;///每平米价格
//@property (strong, nonatomic)NSNumber *calculatorLoanRateValue;///按揭比例
//
/////混合贷款下 两种不同贷款的金额
//@property (strong, nonatomic)NSNumber *calculatorBussinessTotleMoneyValue;
//@property (strong, nonatomic)NSNumber *calculatorPublicFundsTotleMoneyValue;
/////混合贷款下 两种不同贷款的利率
//@property (strong, nonatomic)NSNumber *calculatorBussinessInterestRateValue;
//@property (strong, nonatomic)NSNumber *calculatorPublicFundsInterestRateValue;
//
//@property (strong, nonatomic)NSNumber *calculatorMonthsValue;
//@property (strong, nonatomic)NSNumber *calculatorInterestValue;
//@property (strong, nonatomic)NSNumber *calculatorInterestRateValue;
//@property (strong, nonatomic)NSNumber *calculatorPaymentTypeValue;


+ (ZYCalculatorResultViewModel*)viewModelWithType:(ZYCalculatorType)type;

- (ZYCaclulatorResultModel*)modelAtIndex:(NSInteger)index;

- (void)computePaymentAllMonth;
@end
