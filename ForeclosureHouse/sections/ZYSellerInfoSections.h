//
//  ZYSellerInfoSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/9.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYForeclosureHouseViewModel.h"

@interface ZYSellerInfoSections : ZYSections
- (void)blendModel:(ZYForeclosureHouseViewModel*)model;
@property(nonatomic,strong)NSString *error;

@property(nonatomic,assign)BOOL edit;
@end
