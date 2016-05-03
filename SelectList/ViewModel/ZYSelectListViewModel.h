//
//  ZYSelectListViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/3/31.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYCalculatorValueModel.h"

@interface ZYSelectListViewModel : ZYViewModel

+ (instancetype)viewModelWith:(ZYCalculatorValueModel*)model;

@property(nonatomic,copy)NSString *title;

/**
 *  获取单个数据源
 *
 *  @param index 序号
 *
 *  @return 显示的title
 */
- (NSString*)contentForItem:(NSInteger)index;

@end
