//
//  ZYCalculatorViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/31.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYCalculatorValueModel.h"

@interface ZYCalculatorViewModel : ZYViewModel

/**
 *  计算器类型
 */
@property(nonatomic,assign,readonly)ZYCalculatorType calculatorType;

/**
 *  提示错误  如果为空 则完全可以正常计算
 */
@property(nonatomic,strong)NSString *computeError;
/**
 *  填写的 用str  选择的 用 非str
 */

@property(nonatomic,strong)NSString *calculatorTotleMoney;
@property(nonatomic,strong)NSString *calculatorPricePerCentiare;
@property(nonatomic,strong)NSString *calculatorArea;
@property(nonatomic,strong)NSString *calculatorBussinessTotleMoney;
@property(nonatomic,strong)NSString *calculatorPublicFundsTotleMoney;
@property(nonatomic,strong)NSString *calculatorBussinessInterestRate;
@property(nonatomic,strong)NSString *calculatorPublicFundsInterestRate;
@property(nonatomic,strong)NSString *calculatorInterestRate;

/**
 * Selected于数据model绑定 并且有一个与之对应的string类型绑定 更改seleced 可以更改model 和 对应的string 同时对应的string又与页面展现绑定 从而修改了页面
 */
//@property(nonatomic,strong)NSString *calculatorComputingFormula;
@property(nonatomic,assign)ZYCalculatorComputingType calculatorComputingFormulaSelected;

//@property(nonatomic,strong)NSString *calculatorMonths;
@property(nonatomic,assign)NSInteger calculatorMonthsSelected;///期数

//@property(nonatomic,strong)NSString *calculatorInterest;
@property(nonatomic,assign)ZYCalculatorInterestType calculatorInterestSelected;///贷款折数

//@property(nonatomic,strong)NSString *calculatorPaymentType;
@property(nonatomic,assign)ZYCalculatorPaymentType calculatorPaymentTypeSelected;

//@property(nonatomic,strong)NSString *calculatorLoanRate;
@property(nonatomic,assign)NSInteger calculatorLoanRateSelected;///按揭成数 0为7成 － 6为1成

+ (ZYCalculatorViewModel*)viewModelWithType:(ZYCalculatorType)type;


@property(nonatomic,strong)ZYCalculatorValueModel *valueModel;
@end
