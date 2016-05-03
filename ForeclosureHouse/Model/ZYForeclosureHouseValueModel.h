//
//  ZYForeclosureHouseValueModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYBankModel.h"
#import "ZYCooperativeOrganizationModel.h"
#import "ZYIntermediaryModel.h"
#import "ZYBorrowerModel.h"

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoComeFromBank = 0,//银行
    ZYForeclosureHouseBussinessInfoComeFromIntermediary,///中介
    ZYForeclosureHouseBussinessInfoComeFromFriend,///朋友
    ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization,
} ZYForeclosureHouseBussinessInfoComeFromType;///业务来源信息

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoOrderInside = 0,//内单
    ZYForeclosureHouseBussinessInfoOrderOutside,///外单
} ZYForeclosureHouseBussinessInfoOrderType;

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoTransaction = 0,//交易
    ZYForeclosureHouseBussinessInfoIsNotTransaction,///非交易
} ZYForeclosureHouseBussinessInfoTransactionType;

typedef enum : NSUInteger {
    ZYBankLoanTypeBussiness = 0,///商业贷款
    ZYBankLoanTypePublicFunds,///公积金
    ZYBankLoanTypeAdmixture,///混合贷款
    ZYBankLoanTypePaymentInFull///一次付清
} ZYBankLoanType;///贷款方式

typedef enum : NSUInteger {
    ZYCostInfoChargeTypeBeforeLoan = 0,
    ZYCostInfoChargeTypeAfterLoan,
} ZYCostInfoChargeType;

@interface ZYForeclosureHouseValueModel : NSObject
- (void)reset;

+ (NSArray*)foreclosureHouseBussinessInfoComeFromArr;
+ (NSArray*)foreclosureHouseBussinessInfoOrderArr;
+ (NSArray*)foreclosureHouseBussinessInfoTransactionArr;
+ (NSArray*)costInfoChargeTypeArr;

+ (RACSignal*)bankSearchSignal;
+ (RACSignal*)cooperativeOrganizationArrSignal;
+ (RACSignal*)intermediaryArrSignal;
+ (RACSignal*)borrowersSignal;
#pragma mark - 第一页
@property(nonatomic,assign)ZYForeclosureHouseBussinessInfoComeFromType bussinessInfoComeFromType;

@property(nonatomic,strong)ZYBankModel *bussinessInfoComeFromBank;
@property(nonatomic,strong)ZYCooperativeOrganizationModel *bussinessInfoComeFromCooperativeOrganization;
@property(nonatomic,strong)ZYIntermediaryModel *bussinessInfoComeFromIntermediary;

@property(nonatomic,strong)NSString *bussinessInfoArea;
@property(nonatomic,strong)NSString *bussinessInfoLoanMoney;
@property(nonatomic,strong)NSString *bussinessInfoDays;
@property(nonatomic,strong)NSDate *bussinessInfoDate;
@property(nonatomic,strong)NSString *bussinessInfoAccount;
@property(nonatomic,strong)NSString *bussinessInfoUsername;
@property(nonatomic,strong)NSString *bussinessInfoLinkman;
@property(nonatomic,strong)NSString *bussinessInfoTelephone;
@property(nonatomic,assign)ZYForeclosureHouseBussinessInfoOrderType bussinessInfoOrderType;
@property(nonatomic,assign)ZYForeclosureHouseBussinessInfoTransactionType bussinessInfoTransactionType;
#pragma mark - 第二页
@property(nonatomic,strong)NSString *applyInfoBorrowerName;
@property(nonatomic,strong)NSString *applyInfoBorrowerCardNumber;
@property(nonatomic,strong)NSString *applyInfoBorrowerTelphone;
@property(nonatomic,strong)NSString *applyInfoHousePropertyCardNumber;
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
#pragma mark - 第五页
@property(nonatomic,strong)ZYBankModel *originalBankName;
@property(nonatomic,strong)NSString *originalBankLoanMoney;
@property(nonatomic,strong)NSString *originalBankDebt;
@property(nonatomic,strong)NSDate *originalBankLoanEndTime;
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
@property(nonatomic,assign)ZYBankLoanType bankLoanType;
@property(nonatomic,strong)NSString *bankForeclosureAccount;
@property(nonatomic,strong)ZYBankModel *bankPublicFundBank;
@property(nonatomic,strong)NSString *bankPublicFundMoney;
@property(nonatomic,strong)NSString *bankSuperviseOrganization;
@property(nonatomic,strong)NSString *bankSuperviseMoney;
@property(nonatomic,strong)NSString *bankSuperviseAccount;
@property(nonatomic,strong)NSDate *bankJusticeDate;
@property(nonatomic,strong)NSDate *bankContractDate;
#pragma mark - 第七页
@property(nonatomic,assign)ZYCostInfoChargeType costInfoChargeType;
@property(nonatomic,strong)NSString *costInfoInterestIncome;//利息收入
@property(nonatomic,strong)NSString *costInfoPoundage;//手续费
@property(nonatomic,strong)NSString *costInfoWaitForCosting;//待收费用
@property(nonatomic,strong)NSString *costInfoSubsidy;//补贴
@property(nonatomic,strong)NSString *costInfoCommission;//应付佣金
#pragma mark - 第八页
@property(nonatomic,assign)NSInteger orderInfoPowerOfAttorney;
@property(nonatomic,assign)NSInteger orderInfoPowerOfAttorneyCopy;
@property(nonatomic,strong)NSString *orderInfoPowerOfAttorneyContent;
@property(nonatomic,assign)NSInteger orderInfoIdentificationCard;
@property(nonatomic,assign)NSInteger orderInfoIdentificationCardCopy;
@property(nonatomic,strong)NSString *orderInfoIdentificationCardContent;
@property(nonatomic,assign)NSInteger orderInfoCardForBuilding;
@property(nonatomic,assign)NSInteger orderInfoCardForBuildingCopy;
@property(nonatomic,strong)NSString *orderInfoCardForBuildingContent;
@property(nonatomic,assign)NSInteger orderInfoBankbook;
@property(nonatomic,assign)NSInteger orderInfoBankbookCopy;
@property(nonatomic,strong)NSString *orderInfoBankbookContent;
@property(nonatomic,assign)NSInteger orderInfoSecurityAgreement;
@property(nonatomic,assign)NSInteger orderInfoSecurityAgreementCopy;
@property(nonatomic,strong)NSString *orderInfoSecurityAgreementContent;
@property(nonatomic,assign)NSInteger orderInfoMortgageContract;
@property(nonatomic,assign)NSInteger orderInfoMortgageContractCopy;
@property(nonatomic,strong)NSString *orderInfoMortgageContractContent;
#pragma mark - 第九页
@property(nonatomic,strong)NSDate *applicationDate;
@property(nonatomic,strong)NSString *applicationLinkman;
@property(nonatomic,strong)NSString *applicationTelephone;
@property(nonatomic,strong)NSString *applicationExplain;
@property(nonatomic,strong)NSString *applicationRemarks;
@end
