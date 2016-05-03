//
//  ZYCaclulatorResultModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/7.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCaclulatorResultModel : NSObject

@property(nonatomic,assign)NSInteger month;

@property(nonatomic,assign)CGFloat interestPerMonth;///利息

@property(nonatomic,assign)CGFloat moneyPerMonth;///本金

@property(nonatomic,assign)CGFloat paymenyPerMonth;///总共支付

@property(nonatomic,assign)CGFloat lastMoney;/// 剩余本金
@end
