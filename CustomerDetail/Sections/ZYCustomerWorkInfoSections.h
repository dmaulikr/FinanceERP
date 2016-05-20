//
//  ZYCustomerWorkInfoSections.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYCustomerDetailViewModel.h"

@interface ZYCustomerWorkInfoSections : ZYSections

- (void)blendModel:(ZYCustomerDetailViewModel*)model;

- (NSString*)error;

@property(nonatomic,assign)BOOL edit;

@end
