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

@property(nonatomic,strong)ZYCustomerModel *customer;

@property(nonatomic,strong)NSArray *customerDetailTabTitles;

+ (RACSignal*)customerEducationArrSignal;
+ (RACSignal*)workTitleArrSignal;
+ (RACSignal*)incomeTypeArrSignal;
+ (RACSignal*)incomeDayArrSignal;
+ (RACSignal*)socialStatueArrSignal;

+ (RACSignal*)liveIdentityArrSignal;
+ (RACSignal*)liveStateArrSignal;
+ (RACSignal*)liveTypeArrSignal;

+ (RACSignal*)accountTypeArrSignal;
+ (RACSignal*)accountPurposeArrSignal;

+ (RACSignal*)relationArrSignal;

#pragma mark -第1页
@property(nonatomic,strong)ZYEducationModel *customerEducation;
@property(nonatomic,strong)NSString *customerCompeny;
@property(nonatomic,strong)NSString *customerCompenyAddress;
@property(nonatomic,strong)NSString *customerCompenyTelephone;
@property(nonatomic,strong)ZYWorkTitleModel *customerCompenyTitle;
@property(nonatomic,strong)NSString *customerIncome;
@property(nonatomic,strong)ZYIncomeTypeModel *customerIncomeType;
@property(nonatomic,strong)NSString *customerEntryCompanyDate;
@property(nonatomic,strong)NSString *customerIncomeDay;

#pragma mark -第2页
@property(nonatomic,strong)NSString *customerSocialOrganization;
@property(nonatomic,strong)NSString *customerSocialDate;
@property(nonatomic,strong)NSString *customerSocialBase;
@property(nonatomic,strong)NSString *customerSocialTime;
@property(nonatomic,strong)NSString *customerSocialMedical;
@property(nonatomic,strong)NSString *customerSocialPension;
@property(nonatomic,strong)ZYSocialSecurityPayStatuModel *customerSocialState;

#pragma mark -第3页
@property(nonatomic,strong)ZYLiveIdentityModel *liveIdentity;
@property(nonatomic,strong)ZYLiveStatuModel *liveState;
@property(nonatomic,strong)ZYLiveTypeModel *liveType;
@property(nonatomic,strong)NSString *liveArea;
@property(nonatomic,strong)NSString *totalProperty;
@property(nonatomic,strong)NSString *totalLiabilities;
@property(nonatomic,strong)NSString *monthlyAverageIncome;
@property(nonatomic,strong)NSString *familyIncome;
@property(nonatomic,strong)NSString *spouseName;
@property(nonatomic,strong)NSString *spouseCardNum;
@property(nonatomic,strong)NSString *spouseTelephone;

#pragma mark -第4页
@property(nonatomic,strong)NSString *bankName;
@property(nonatomic,strong)ZYAccountTypeModel *accountType;
@property(nonatomic,strong)ZYAccountPurposeModel *accountPurpose;
@property(nonatomic,strong)NSString *accountName;
@property(nonatomic,strong)NSString *accountNum;

#pragma mark -第5页
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *companyNum;
@property(nonatomic,strong)NSString *companyBusinessLicenseNum;
@property(nonatomic,strong)NSString *companyLegalPerson;
@property(nonatomic,strong)NSString *companyRegisteredCapital;
@property(nonatomic,strong)NSString *companyTelephone;

#pragma mark -第6页
@property(nonatomic,strong)NSString *relationShipName;
@property(nonatomic,strong)ZYRelationModel *relationShipType;
@property(nonatomic,strong)NSString *relationShipCardNum;
@property(nonatomic,strong)NSString *relationShipTelephone;
@property(nonatomic,strong)NSString *relationShipAddress;

#pragma mark -第7页
@property(nonatomic,strong)NSString *creditNum;
@property(nonatomic,strong)NSString *creditDate;

@property(nonatomic,assign)BOOL loading;
@property(nonatomic,strong)NSString *error;

- (void)updateCustomerInfoDetailFirst;
- (void)updateCustomerInfoDetailSecond;
@end
