//
//  ZYCalculatorValueModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/2.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    /**
     *  商业贷款
     */
    ZYCalculatorTypeBusinessLoan = 0,
    /**
     *   公积金
     */
    ZYCalculatorTypePublicFunds,
    /**
     *  混合
     */
    ZYCalculatorTypeAdmixture,
    
} ZYCalculatorType;

typedef enum : NSUInteger {
    ZYCalculatorComputingTypePrice = 0,///根据金额计算
    ZYCalculatorComputingTypeArea,///根据面积计算
} ZYCalculatorComputingType;

typedef enum : NSUInteger {
    ZYCalculatorPaymentTypeInterest = 0,///等额本息
    ZYCalculatorPaymentTypeMoney,///等额本金
} ZYCalculatorPaymentType;

typedef enum : NSUInteger {
    ZYCalculatorInterestTypeNoCutoff = 0,///基础利率
    ZYCalculatorInterestTypeCutoff9,///九折
    ZYCalculatorInterestTypeCutoff85,///八五折
    ZYCalculatorInterestTypeCutoff7,///七折
} ZYCalculatorInterestType;

@interface ZYCalculatorValueModel : NSObject
/**
 *  选择的数据 不同int代表不同类型
 */
@property(nonatomic,assign)ZYCalculatorComputingType calculatorComputingFormulaValue;
@property(nonatomic,assign)ZYCalculatorPaymentType calculatorPaymentTypeValue;
@property(nonatomic,assign)NSInteger calculatorMonthsValue;///期数
@property(nonatomic,assign)CGFloat calculatorInterestValue;//利率折扣
@property(nonatomic,assign)NSInteger calculatorLoanRateValue;///按揭成数

@property(nonatomic,strong)NSNumber *calculatorTotleMoneyValue;///总贷款额
@property(nonatomic,strong)NSNumber *calculatorPricePerCentiareValue;///每平米价格
@property(nonatomic,strong)NSNumber *calculatorAreaValue;///总面积

@property(nonatomic,strong)NSNumber *calculatorBussinessTotleMoneyValue;///商业总金额
@property(nonatomic,strong)NSNumber *calculatorPublicFundsTotleMoneyValue;
@property(nonatomic,strong)NSNumber *calculatorBussinessInterestRateValue;
@property(nonatomic,strong)NSNumber *calculatorPublicFundsInterestRateValue;

@property(nonatomic,strong)NSNumber *calculatorInterestRateValue;

@property(nonatomic,assign)ZYCalculatorType calculatorType;

+ (NSArray*)calculatorComputingFormulaArr;
+ (NSArray*)calculatorInterestArr;
+ (NSArray*)calculatorMonthsArr;
+ (NSArray*)calculatorPaymentTypeArr;
+ (NSArray*)calculatorLoanRateArr;
@end
