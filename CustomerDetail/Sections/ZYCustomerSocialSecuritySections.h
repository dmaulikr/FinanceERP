//
//  ZYCustomerSocialSecuritySections.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/18.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSections.h"
#import "ZYCustomerDetailViewModel.h"
@interface ZYCustomerSocialSecuritySections : ZYSections

- (void)blendModel:(ZYCustomerDetailViewModel*)model;

@property(nonatomic,assign)BOOL edit;

- (NSString*)error;

@end
