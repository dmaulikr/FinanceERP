//
//  ZYBothSideInfoSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYForeclosureHouseValueModel.h"
@interface ZYBothSideInfoSections : ZYSections
- (void)blendModel:(ZYForeclosureHouseValueModel*)model;
@property(nonatomic,strong)NSString *error;

@property(nonatomic,assign)BOOL edit;
@end
