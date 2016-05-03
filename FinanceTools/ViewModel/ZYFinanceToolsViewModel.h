//
//  ZYFinanceToolsViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"

@interface ZYFinanceToolsViewModel : ZYViewModel

/**
 *  房贷计算器 功能开关
 */
@property (assign, nonatomic) BOOL housingLoanCalculatorFunction;
/**
 *  房产询价
 */
@property (assign, nonatomic) BOOL housePropertyInquiryFunction;
/**
 *  过户询价
 */
@property (assign, nonatomic) BOOL transferInquiryFunction;
/**
 *  免费查档
 */
@property (assign, nonatomic) BOOL consultFilesFunction;
/**
 *  预约
 */
@property (assign, nonatomic) BOOL makeAppointmentFunction;

- (void)requestFunctionList;
@end
