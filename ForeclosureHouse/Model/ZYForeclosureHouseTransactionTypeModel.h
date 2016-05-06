//
//  ZYForeclosureHouseTransactionTypeModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoTransaction = 0,//交易
    ZYForeclosureHouseBussinessInfoIsNotTransaction,///非交易
} ZYForeclosureHouseBussinessInfoTransactionType;

@interface ZYForeclosureHouseTransactionTypeModel : ZYStoreModel

@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)ZYForeclosureHouseBussinessInfoTransactionType type;
@property(nonatomic,assign)NSInteger pid;

@end
