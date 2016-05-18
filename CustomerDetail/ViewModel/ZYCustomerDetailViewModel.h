//
//  ZYCustomerDetailViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYEducationModel.h"
#import "ZYWorkTitleModel.h"
#import "ZYIncomeTypeModel.h"
#import "ZYSocialSecurityPayStatuModel.h"
#import "ZYLiveStatuModel.h"
#import "ZYAccountPurposeModel.h"
#import "ZYRelationModel.h"
#import "ZYLiveIdentityModel.h"
#import "ZYAccountTypeModel.h"
#import "ZYLiveTypeModel.h"

@interface ZYCustomerDetailViewModel : ZYViewModel

@property(nonatomic,strong)NSArray *customerDetailTabTitles;

+ (RACSignal*)customerEducationArrSignal;
+ (RACSignal*)workTitleArrSignal;
+ (RACSignal*)incomeTypeArrSignal;
+ (RACSignal*)incomeDayArrSignal;


@end
