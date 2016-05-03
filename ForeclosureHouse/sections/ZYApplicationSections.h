//
//  ZYApplicationSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYForeclosureHouseValueModel.h"

@interface ZYApplicationSections : ZYSections
- (void)blendModel:(ZYForeclosureHouseValueModel*)model;
@property(nonatomic,strong)RACSignal *saveSignal;
@property(nonatomic,strong)RACSignal *submitSignal;
@property(nonatomic,assign)BOOL edit;
@end
