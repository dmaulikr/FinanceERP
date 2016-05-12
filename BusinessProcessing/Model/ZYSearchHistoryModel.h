//
//  ZYSearchHistoryModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/22.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

typedef enum : NSUInteger {
    ZYHistoryTypeBusinessProcessing = 0,
    ZYHistoryTypeMyCustomer,
} ZYHistoryType;

@interface ZYSearchHistoryModel : ZYStoreModel

@property(nonatomic,strong)NSDate *searchDate;
@property(nonatomic,strong)NSString *searchKeyword;
@property(nonatomic,assign)ZYHistoryType type;

@end
