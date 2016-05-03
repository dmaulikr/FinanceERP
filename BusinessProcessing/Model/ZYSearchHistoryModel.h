//
//  ZYSearchHistoryModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/22.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

@interface ZYSearchHistoryModel : ZYStoreModel

@property(nonatomic,strong)NSDate *searchDate;
@property(nonatomic,strong)NSString *searchKeyword;

@end
