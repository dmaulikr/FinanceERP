//
//  ZYCostInfoChargeTypeModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

typedef enum : NSUInteger {
    ZYCostInfoChargeTypeBeforeLoan = 0,
    ZYCostInfoChargeTypeAfterLoan,
} ZYCostInfoChargeType;

@interface ZYCostInfoChargeTypeModel : ZYStoreModel

@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)ZYCostInfoChargeType type;
@property(nonatomic,assign)NSInteger pid;

@end
