//
//  ZYForeclosureHouseViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseViewModel.h"

@implementation ZYForeclosureHouseViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bussinessInfoComeFromType = [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] searchSingle:[ZYForeclosureHouseComeFromTypeModel class] where:@{@"type":@(0)} orderBy:@"rowid"];
        self.bussinessInfoOrderType = [[ZYForeclosureHouseOrderTypeModel getUsingLKDBHelper] searchSingle:[ZYForeclosureHouseOrderTypeModel class] where:@{@"type":@(0)} orderBy:@"rowid"];
        self.bussinessInfoTransactionType = [[ZYForeclosureHouseTransactionTypeModel getUsingLKDBHelper] searchSingle:[ZYForeclosureHouseTransactionTypeModel class] where:@{@"type":@(0)} orderBy:@"rowid"];
        self.bankLoanType = [[ZYBankLoanTypeModel getUsingLKDBHelper] searchSingle:[ZYBankLoanTypeModel class] where:@{@"type":@(0)} orderBy:@"rowid"];
        self.costInfoChargeType = [[ZYCostInfoChargeTypeModel getUsingLKDBHelper] searchSingle:[ZYCostInfoChargeTypeModel class] where:@{@"type":@(0)} orderBy:@"rowid"];
        self.orderInfoPaperArr = [[ZYPaperModel getUsingLKDBHelper] search:[ZYPaperModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX];
    }
    return self;
}
- (void)loadData:(ZYForeclosureHouseModel*)model
{
    self.bussinessInfoComeFromType = [self foreclosureHouseBussinessInfoComeFromType:model.business_source];
    switch (self.bussinessInfoComeFromType.type) {
        case ZYForeclosureHouseBussinessInfoComeFromBank:
            self.bussinessInfoComeFromBank = [self bank:model.business_source_no];
            break;
        case ZYForeclosureHouseBussinessInfoComeFromIntermediary:
            self.bussinessInfoComeFromIntermediary = [self intermediaryModel:model.business_source_no];
            break;
        case ZYForeclosureHouseBussinessInfoComeFromFriend:
            break;
        case ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization:
            self.bussinessInfoComeFromCooperativeOrganization = [self cooperativeOrganizationModel:model.business_source_no];
            break;
        case ZYForeclosureHouseBussinessInfoComeFromOther:
            break;
        default:
            break;
    }

#pragma mark - 第一页
    self.bussinessInfoArea = model.address;
    self.bussinessInfoLoanMoney = [NSString stringWithFormat:@"%.2f",model.loan_money];
    self.bussinessInfoDays = [NSString stringWithFormat:@"%ld",(long)model.loan_days];;
    self.bussinessInfoDate = model.rece_date;
    self.bussinessInfoAccount = model.payment_account;
    self.bussinessInfoUsername = model.payment_name;
    self.bussinessInfoLinkman = model.business_contacts;
    self.bussinessInfoTelephone = model.contacts_phone;
    self.bussinessInfoOrderType = [self foreclosureHouseBussinessInfoOrderType:model.inner_or_out];
    self.bussinessInfoTransactionType = [self foreclosureHouseBussinessInfoTransactionType:model.business_category];
#pragma mark - 第二页
    self.applyInfoBorrowerName = model.customer_name;
    self.applyInfoBorrowerCardNumber = model.cert_num;
    self.applyInfoBorrowerTelphone = model.customer_phone;
    self.applyInfoAddress = model.customer_address;
#pragma mark - 第三页
    self.housePropertyInfoName = model.house_name;
    self.housePropertyInfoArea = model.house_area;
    self.housePropertyInfoOrigePrice = [NSString stringWithFormat:@"%.2f",model.cost_money];
    self.housePropertyInfoHousePropertyCardNumber = model.house_property_card;
    self.housePropertyInfoDealPrice = [NSString stringWithFormat:@"%.2f",model.tranasction_money];
    self.housePropertyInfoAssessmentPrice = [NSString stringWithFormat:@"%.2f",model.evaluation_price];
#pragma mark - 第四页
    self.bothSideInfoSellerName = model.seller_name;
    self.bothSideInfoSellerCardNumber = model.seller_card_no;
    self.bothSideInfoSellerTelephone = model.seller_phone;
    self.bothSideInfoSellerAddress = model.seller_address;
    self.bothSideInfoBuyerName = model.buyer_name;
    self.bothSideInfoBuyerCardNumber = model.buyer_card_no;
    self.bothSideInfoBuyerTelephone = model.buyer_phone;
    self.bothSideInfoBuyerAddress = model.buyer_address;
#pragma mark - 第五页
    self.originalBankName = [self bank:model.old_loan_bank];
    self.originalBankLoanMoney = [NSString stringWithFormat:@"%.2f",model.old_loan_money];
    self.originalBankDebt = [NSString stringWithFormat:@"%ld",(long)model.old_owed_amount];
    self.originalBankLoanEndTime = model.old_loan_time;
    self.originalBankLinkman = model.old_loan_person;
    self.originalBankTelephone = model.old_loan_phone;
    self.originalBankThirdPartyLoan = model.third_borrower;
    self.originalBankThirdPartyCardNumber = model.third_borrower_card;
    self.originalBankThirdPartyTelephone = model.third_borrower_phone;
    self.originalBankThirdPartyAddress = model.third_borrower_address;
#pragma mark - 第六页
    self.bank = [self bank:model.new_loan_bank];
    self.bankLoanMoney = [NSString stringWithFormat:@"%.2f",model.new_loan_money];
    self.bankLinkman = model.loan_person;
    self.bankTelephone = model.loan_phone;
    self.bankLoanType = [self loanType:model.payment_type];
    self.bankForeclosureAccount = model.fore_account;
    self.bankPublicFundBank = [self bank:model.accumulation_fund_bank];
    self.bankPublicFundMoney = [NSString stringWithFormat:@"%.2f",model.accumulation_fund_money];
//    self.bankSuperviseOrganization = model.supervise_department;
    self.bankSuperviseMoney = [NSString stringWithFormat:@"%.2f",model.funds_money];
    self.bankSuperviseAccount = model.supervise_account;
    self.bankJusticeDate = model.notarization_date;
    self.bankContractDate = model.sign_date;
#pragma mark - 第七页
    self.costInfoChargeType = [self costInfoChargeType:model.charges_type];
    self.costInfoInterestIncome = [NSString stringWithFormat:@"%.2f",model.guarantee_fee];
    self.costInfoPoundage = [NSString stringWithFormat:@"%.2f",model.poundage];
    self.costInfoWaitForCosting = [NSString stringWithFormat:@"%.2f",model.charges_subsidized];
    self.costInfoSubsidy = [NSString stringWithFormat:@"%.2f",model.rece_money];
    self.costInfoCommission = [NSString stringWithFormat:@"%.2f",model.dept_money];
#pragma mark - 第八页
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:model.foreInfos.count];
    for(ZYForeinfos *info in model.foreInfos)
    {
        ZYPaperModel * paper = [[ZYPaperModel alloc] init];
        paper.orderInfoPaperTitle = info.fore_info_name;
        paper.orderInfoPaperCount = info.original_number;
        paper.orderInfoPaperCopyCount = info.copy_number;
        paper.orderInfoPaperContent = info.remark;
        [arr addObject:paper];
    }
    self.orderInfoPaperArr = arr;
#pragma mark - 第九页
}
- (void)foreclosureHouseRequest
{
    if(self.projectID==0)
        return;
    
    ZYForeclosureHouseRequest *request = [ZYForeclosureHouseRequest request];
    request.project_id = self.projectID;
    request.user_id = [ZYUser user].pid;
    [[[ZYRoute route] foreclosureHouseInfo:request] subscribeNext:^(id x) {
        [self loadData:x];
    }];
}
+ (RACSignal*)foreclosureHouseBussinessInfoComeFromArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] search:[ZYForeclosureHouseComeFromTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYForeclosureHouseComeFromTypeModel*)foreclosureHouseBussinessInfoComeFromType:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] searchSingle:[ZYForeclosureHouseComeFromTypeModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];
}
+ (RACSignal*)foreclosureHouseBussinessInfoOrderArrSignalSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYForeclosureHouseOrderTypeModel getUsingLKDBHelper] search:[ZYForeclosureHouseOrderTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYForeclosureHouseOrderTypeModel*)foreclosureHouseBussinessInfoOrderType:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYForeclosureHouseOrderTypeModel getUsingLKDBHelper] searchSingle:[ZYForeclosureHouseOrderTypeModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];
}
+ (RACSignal*)foreclosureHouseBussinessInfoTransactionArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYForeclosureHouseTransactionTypeModel getUsingLKDBHelper] search:[ZYForeclosureHouseTransactionTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYForeclosureHouseTransactionTypeModel*)foreclosureHouseBussinessInfoTransactionType:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYForeclosureHouseTransactionTypeModel getUsingLKDBHelper] searchSingle:[ZYForeclosureHouseTransactionTypeModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];
}
+ (RACSignal*)costInfoChargeTypeArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYCostInfoChargeTypeModel getUsingLKDBHelper] search:[ZYCostInfoChargeTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYCostInfoChargeTypeModel*)costInfoChargeType:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYCostInfoChargeTypeModel getUsingLKDBHelper] searchSingle:[ZYCostInfoChargeTypeModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];
}
+ (RACSignal*)loanTypeArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYBankLoanTypeModel getUsingLKDBHelper] search:[ZYBankLoanTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYBankLoanTypeModel*)loanType:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYBankLoanTypeModel getUsingLKDBHelper] searchSingle:[ZYBankLoanTypeModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];
}
#pragma mark -银行
+ (RACSignal*)bankSearchSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYBankModel getUsingLKDBHelper] search:[ZYBankModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYBankModel*)bank:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYCooperativeOrganizationModel getUsingLKDBHelper] searchSingle:[ZYCooperativeOrganizationModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];
}
#pragma mark -合作机构
+ (RACSignal*)cooperativeOrganizationArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYCooperativeOrganizationModel getUsingLKDBHelper] search:[ZYCooperativeOrganizationModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYCooperativeOrganizationModel*)cooperativeOrganizationModel:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYCooperativeOrganizationModel getUsingLKDBHelper] searchSingle:[ZYCooperativeOrganizationModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];;
}
#pragma mark - 中介
+ (RACSignal*)intermediaryArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYIntermediaryModel getUsingLKDBHelper] search:[ZYIntermediaryModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        
        return nil;
    }];
    return signal;
}
- (ZYIntermediaryModel*)intermediaryModel:(NSInteger)pid
{
    if(pid==0)
        return nil;
    return [[ZYIntermediaryModel getUsingLKDBHelper] searchSingle:[ZYIntermediaryModel class] where:@{@"pid":@(pid)} orderBy:@"rowid"];;
}
+ (RACSignal*)borrowersSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        ZYBorrowerModel *borrower = [[ZYBorrowerModel alloc] init];
        borrower.name = @"张三";
        borrower.telephone = @"13145678945";
        borrower.cardNumber = @"412554455245462571";
        [arr addObject:borrower];
        
        borrower = [[ZYBorrowerModel alloc] init];
        borrower.name = @"李四";
        borrower.telephone = @"15845216587";
        borrower.cardNumber = @"854654424215687584";
        [arr addObject:borrower];
        
        [subscriber sendNext:arr];
        return nil;
    }];
    return signal;
}
@end
