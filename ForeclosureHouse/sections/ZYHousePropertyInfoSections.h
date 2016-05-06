//
//  ZYHousePropertyInfoSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"

#import "ZYForeclosureHouseViewModel.h"

@interface ZYHousePropertyInfoSections : ZYSections
- (void)blendModel:(ZYForeclosureHouseViewModel*)viewModel;
@property(nonatomic,strong)NSString *error;

@property(nonatomic,assign)BOOL edit;
@end
