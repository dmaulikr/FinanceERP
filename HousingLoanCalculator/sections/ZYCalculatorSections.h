//
//  ZYCalculatorSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYCalculatorSelectCell.h"
#import "ZYCalculatorInputCell.h"
#import "ZYCalculatorButtonCell.h"
#import "ZYCalculatorValueModel.h"
#import "ZYCalculatorViewModel.h"

@interface ZYCalculatorSections : ZYSections

- (void)blendViewModel:(ZYCalculatorViewModel*)viewModel;

- (void)reloadCells;

@end
