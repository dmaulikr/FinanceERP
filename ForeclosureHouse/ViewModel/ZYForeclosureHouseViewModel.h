//
//  ZYForeclosureHouseViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYForeclosureHouseModel.h"
#import "ZYBankModel.h"
#import "ZYCooperativeOrganizationModel.h"
#import "ZYIntermediaryModel.h"
#import "ZYBorrowerModel.h"
#import "ZYForeclosureHouseComeFromTypeModel.h"
#import "ZYForeclosureHouseOrderTypeModel.h"
#import "ZYForeclosureHouseTransactionTypeModel.h"
#import "ZYBankLoanTypeModel.h"
#import "ZYCostInfoChargeTypeModel.h"
#import "ZYPaperModel.h"

@interface ZYForeclosureHouseViewModel : ZYViewModel

@property(nonatomic,assign)long long projectID;

- (void)foreclosureHouseRequest;

+ (RACSignal*)foreclosureHouseBussinessInfoComeFromArrSignal;
+ (RACSignal*)foreclosureHouseBussinessInfoOrderArrSignalSignal;
+ (RACSignal*)foreclosureHouseBussinessInfoTransactionArrSignal;
+ (RACSignal*)costInfoChargeTypeArrSignal;
+ (RACSignal*)loanTypeArrSignal;

+ (RACSignal*)bankSearchSignal;
- (ZYBankModel*)bank:(NSInteger)pid;

+ (RACSignal*)cooperativeOrganizationArrSignal;
+ (RACSignal*)intermediaryArrSignal;
+ (RACSignal*)borrowersSignal;

- (void)reset;
#pragma mark - 页面展示数据


#pragma mark - 第一页
@property(nonatomic,strong)ZYForeclosureHouseComeFromTypeModel *bussinessInfoComeFromType;

@property(nonatomic,strong)id bussinessInfoComeFromObj;
@property(nonatomic,strong)NSString *bussinessInfoComeFromOther;

@property(nonatomic,strong)NSString *bussinessInfoArea;
@property(nonatomic,strong)NSString *bussinessInfoLoanMoney;
@property(nonatomic,strong)NSString *bussinessInfoDays;
@property(nonatomic,strong)NSString *bussinessInfoDate;
@property(nonatomic,strong)NSString *bussinessInfoAccount;
@property(nonatomic,strong)NSString *bussinessInfoUsername;
@property(nonatomic,strong)NSString *bussinessInfoLinkman;
@property(nonatomic,strong)NSString *bussinessInfoTelephone;
@property(nonatomic,strong)ZYForeclosureHouseOrderTypeModel *bussinessInfoOrderType;
@property(nonatomic,strong)ZYForeclosureHouseTransactionTypeModel *bussinessInfoTransactionType;
#pragma mark - 第二页
@property(nonatomic,strong)NSString *applyInfoBorrowerName;
@property(nonatomic,strong)NSString *applyInfoBorrowerCardNumber;
@property(nonatomic,strong)NSString *applyInfoBorrowerTelphone;
//@property(nonatomic,strong)NSString *applyInfoHousePropertyCardNumber;
@property(nonatomic,strong)NSString *applyInfoAddress;
#pragma makr - 第三页
@property(nonatomic,strong)NSString *housePropertyInfoName;
@property(nonatomic,strong)NSString *housePropertyInfoArea;
@property(nonatomic,strong)NSString *housePropertyInfoOrigePrice;
@property(nonatomic,strong)NSString *housePropertyInfoHousePropertyCardNumber;
@property(nonatomic,strong)NSString *housePropertyInfoDealPrice;
@property(nonatomic,strong)NSString *housePropertyInfoAssessmentPrice;
#pragma mark - 第四页
@property(nonatomic,strong)NSString *bothSideInfoSellerName;
@property(nonatomic,strong)NSString *bothSideInfoSellerCardNumber;
@property(nonatomic,strong)NSString *bothSideInfoSellerTelephone;
@property(nonatomic,strong)NSString *bothSideInfoSellerAddress;
@property(nonatomic,strong)NSString *bothSideInfoBuyerName;
@property(nonatomic,strong)NSString *bothSideInfoBuyerCardNumber;
@property(nonatomic,strong)NSString *bothSideInfoBuyerTelephone;
@property(nonatomic,strong)NSString *bothSideInfoBuyerAddress;
#pragma mark - 第五页
@property(nonatomic,strong)ZYBankModel *originalBankName;
@property(nonatomic,strong)NSString *originalBankLoanMoney;
@property(nonatomic,strong)NSString *originalBankDebt;
@property(nonatomic,strong)NSString *originalBankLoanEndTime;
@property(nonatomic,strong)NSString *originalBankLinkman;
@property(nonatomic,strong)NSString *originalBankTelephone;
@property(nonatomic,strong)NSString *originalBankThirdPartyLoan;
@property(nonatomic,strong)NSString *originalBankThirdPartyCardNumber;
@property(nonatomic,strong)NSString *originalBankThirdPartyTelephone;
@property(nonatomic,strong)NSString *originalBankThirdPartyAddress;
#pragma mark - 第六页
@property(nonatomic,strong)ZYBankModel *bank;
@property(nonatomic,strong)NSString *bankLoanMoney;
@property(nonatomic,strong)NSString *bankLinkman;
@property(nonatomic,strong)NSString *bankTelephone;
@property(nonatomic,strong)ZYBankLoanTypeModel *bankLoanType;
@property(nonatomic,strong)NSString *bankForeclosureAccount;
@property(nonatomic,strong)ZYBankModel *bankPublicFundBank;
@property(nonatomic,strong)NSString *bankPublicFundMoney;
@property(nonatomic,strong)NSString *bankSuperviseOrganization;
@property(nonatomic,strong)NSString *bankSuperviseMoney;
@property(nonatomic,strong)NSString *bankSuperviseAccount;
@property(nonatomic,strong)NSString *bankJusticeDate;
@property(nonatomic,strong)NSString *bankContractDate;
#pragma mark - 第七页
@property(nonatomic,strong)ZYCostInfoChargeTypeModel *costInfoChargeType;
@property(nonatomic,strong)NSString *costInfoInterestIncome;//利息收入
@property(nonatomic,strong)NSString *costInfoPoundage;//手续费
@property(nonatomic,strong)NSString *costInfoWaitForCosting;//待收费用
@property(nonatomic,strong)NSString *costInfoSubsidy;//补贴
@property(nonatomic,strong)NSString *costInfoCommission;//应付佣金
#pragma mark - 第八页

@property(nonatomic,strong)NSArray *orderInfoPaperArr;

#pragma mark - 第九页
@property(nonatomic,strong)NSString *applicationDate;
@property(nonatomic,strong)NSString *applicationLinkman;
@property(nonatomic,strong)NSString *applicationTelephone;
@property(nonatomic,strong)NSString *applicationExplain;
@property(nonatomic,strong)NSString *applicationRemarks;

@end


