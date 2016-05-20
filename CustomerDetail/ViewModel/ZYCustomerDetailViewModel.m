//
//  ZYCustomerDetailViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerDetailViewModel.h"

@implementation ZYCustomerDetailViewModel
- (NSArray*)customerDetailTabTitles
{
    if(_customerDetailTabTitles==nil)
    {
        _customerDetailTabTitles = @[@"工作信息",@"社保信息",@"家庭信息",@"开户信息",@"公司信息",@"关系人信息",@"征信记录"];
    }
    return _customerDetailTabTitles;
}
+ (RACSignal*)customerEducationArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYEducationModel getUsingLKDBHelper] search:[ZYEducationModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)workTitleArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYWorkTitleModel getUsingLKDBHelper] search:[ZYWorkTitleModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)incomeTypeArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYIncomeTypeModel getUsingLKDBHelper] search:[ZYIncomeTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)incomeDayArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:31];
        for(int i=1;i<=31;i++)
        {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [subscriber sendNext:arr];
        [subscriber sendCompleted];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)socialStatueArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYSocialSecurityPayStatuModel getUsingLKDBHelper] search:[ZYSocialSecurityPayStatuModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)liveIdentityArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYLiveIdentityModel getUsingLKDBHelper] search:[ZYLiveIdentityModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)liveStateArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYLiveStatuModel getUsingLKDBHelper] search:[ZYLiveStatuModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)liveTypeArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYLiveTypeModel getUsingLKDBHelper] search:[ZYLiveTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)accountTypeArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYAccountTypeModel getUsingLKDBHelper] search:[ZYAccountTypeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)accountPurposeArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYAccountPurposeModel getUsingLKDBHelper] search:[ZYAccountPurposeModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
+ (RACSignal*)relationArrSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[ZYRelationModel getUsingLKDBHelper] search:[ZYRelationModel class] where:nil orderBy:@"rowid" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            });
        }];
        return nil;
    }];
    return signal;
}
- (void)setCustomer:(ZYCustomerModel *)customer
{
    _customer = customer;
    [self loadData:customer];
}
- (ZYEducationModel*)customerEducationWithID:(NSInteger)pid
{
    return [[ZYEducationModel getUsingLKDBHelper] searchSingle:[ZYEducationModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYWorkTitleModel*)workTitleWithID:(NSInteger)pid
{
    return [[ZYWorkTitleModel getUsingLKDBHelper] searchSingle:[ZYWorkTitleModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYIncomeTypeModel*)incomeTypeWithID:(NSInteger)pid
{
    return [[ZYIncomeTypeModel getUsingLKDBHelper] searchSingle:[ZYIncomeTypeModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYSocialSecurityPayStatuModel*)socialSecurityPayStateWithID:(NSInteger)pid
{
    return [[ZYSocialSecurityPayStatuModel getUsingLKDBHelper] searchSingle:[ZYSocialSecurityPayStatuModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYLiveIdentityModel*)liveIdentityWithID:(NSInteger)pid
{
    return [[ZYLiveIdentityModel getUsingLKDBHelper] searchSingle:[ZYLiveIdentityModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYLiveStatuModel*)liveStateWithID:(NSInteger)pid
{
    return [[ZYLiveStatuModel getUsingLKDBHelper] searchSingle:[ZYLiveStatuModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYLiveTypeModel*)livetypeWithID:(NSInteger)pid
{
    return [[ZYLiveTypeModel getUsingLKDBHelper] searchSingle:[ZYLiveTypeModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYAccountTypeModel*)accountTypeWithID:(NSInteger)pid
{
    return [[ZYAccountTypeModel getUsingLKDBHelper] searchSingle:[ZYAccountTypeModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYAccountPurposeModel*)accountPurposeWithID:(NSInteger)pid
{
    return [[ZYAccountPurposeModel getUsingLKDBHelper] searchSingle:[ZYAccountPurposeModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (ZYRelationModel*)relationShipTypeWithID:(NSInteger)pid
{
    return [[ZYRelationModel getUsingLKDBHelper] searchSingle:[ZYRelationModel class] where:@{@"pid" : @(pid)} orderBy:@"rowid"];
}
- (void)loadData:(ZYCustomerModel*)customer
{
#pragma mark -第1页
    self.customerEducation = [self customerEducationWithID:customer.degree];
    self.customerCompeny = customer.work_unit;
    self.customerCompenyAddress = customer.unit_address;
    self.customerCompenyTelephone = customer.unit_phone;
    self.customerCompenyTitle = [self workTitleWithID:customer.occ_name];
    self.customerIncome = [NSString stringWithFormat:@"%.2f",customer.month_income];
    self.customerIncomeType = [self incomeTypeWithID:customer.pay_way];
    self.customerEntryCompanyDate = customer.entry_time;
    self.customerIncomeDay = [NSString stringWithFormat:@"%ld",(long)customer.month_pay_day];
    
    
#pragma mark -第2页
    self.customerSocialOrganization = customer.safe_unit;
    self.customerSocialDate = customer.safe_time;
    self.customerSocialBase = [NSString stringWithFormat:@"%.2f",customer.safe_num];
    self.customerSocialTime = [NSString stringWithFormat:@"%ld",(long)customer.total_safe_time];
    self.customerSocialMedical = [NSString stringWithFormat:@"%.2f",customer.med_money];
    self.customerSocialPension = [NSString stringWithFormat:@"%.2f",customer.pen_money];
    self.customerSocialState = [self socialSecurityPayStateWithID:customer.suspend];
    
#pragma mark -第3页
    self.liveIdentity = [self liveIdentityWithID:customer.house_main];
    self.liveState = [self liveStateWithID:customer.live_status];
    self.liveType = [self livetypeWithID:customer.house_shape];
    self.liveArea = [NSString stringWithFormat:@"%.2f",customer.house_area];
    self.totalProperty = [NSString stringWithFormat:@"%.2f",customer.total_assets];
    self.totalLiabilities = [NSString stringWithFormat:@"%.2f",customer.total_liab];
    self.monthlyAverageIncome = [NSString stringWithFormat:@"%.2f",customer.month_wage];
    self.familyIncome = [NSString stringWithFormat:@"%.2f",customer.family_income];
    self.spouseName = customer.spouse_name;
    self.spouseCardNum = customer.spouse_card_no;
    self.spouseTelephone = customer.spouse_phone;
    
#pragma mark -第4页
    self.bankName = customer.bank_name;
    self.accountType = [self accountTypeWithID:customer.acc_type];
    self.accountPurpose = [self accountPurposeWithID:customer.acc_use];
    self.accountName = customer.acc_name;
    self.accountNum = customer.loan_card_id;
    
#pragma mark -第5页
    self.companyName = customer.cpy_name;
    self.companyNum = customer.org_code;
    self.companyBusinessLicenseNum = customer.bus_lic_cert;
    self.companyLegalPerson = customer.legal_person;
    self.companyRegisteredCapital = [NSString stringWithFormat:@"%.2f",customer.reg_money];
    self.companyTelephone = customer.com_telephone;
    
#pragma mark -第6页
    
    self.relationShipName = customer.relation_name;
    self.relationShipType = [self relationShipTypeWithID:customer.relation_type];
    self.relationShipCardNum = customer.relation_card_no;
    self.relationShipTelephone = customer.relation_phone_num;
    self.relationShipAddress = customer.relation_address;

#pragma mark -第7页
    
    self.creditNum = customer.credit_no;
    self.creditDate = customer.rep_query_date;
}
- (void)updateCustomerInfoDetailFirst
{
    ZYCustomerFirstUpdateRequest *request = [ZYCustomerFirstUpdateRequest request];
    request.user_id = [ZYUser user].pid;
    request.customer_id = self.customer.customer_id;
    
    request.degree = self.customerEducation.pid;
    request.work_unit = self.customerCompeny;
    request.unit_address = self.customerCompenyAddress;
    request.unit_phone = self.customerCompenyTelephone;
    request.occ_name = self.customerCompenyTitle.pid;
    request.month_income = [self.customerIncome floatValue];
    request.pay_way = self.customerIncomeType.pid;
    request.entry_time = self.customerEntryCompanyDate;
    request.month_pay_day = [self.customerIncomeDay longLongValue];
    
    request.safe_unit = self.customerSocialOrganization;
    request.safe_time = self.customerSocialDate;
    request.safe_num = [self.customerSocialBase floatValue];
    request.total_safe_time = [self.customerSocialTime longLongValue];
    request.med_money = [self.customerSocialMedical floatValue];
    request.pen_money = [self.customerSocialPension floatValue];
    request.suspend = self.customerSocialState.pid;
    
    request.house_main = self.liveIdentity.pid;
    request.live_status = self.liveState.pid;
    request.house_shape = self.liveType.pid;
    request.house_area = [self.liveArea floatValue];
    request.total_assets = [self.totalProperty floatValue];
    request.total_liab = [self.totalLiabilities floatValue];
    request.month_wage = [self.monthlyAverageIncome floatValue];
    request.family_income = [self.familyIncome floatValue];
    request.spouse_name = self.spouseName;
    request.spouse_card_no = self.spouseCardNum;
    request.spouse_phone = self.spouseTelephone;
    
    self.loading = YES;
    [[[ZYRoute route] customerDetailInfoFirstEdit:request] subscribeNext:^(id x) {
        self.loading = NO;
        self.error = x;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
    } completed:^{
        
    }];
}
- (void)updateCustomerInfoDetailSecond
{
    ZYCustomerSecondUpdateRequest *request = [ZYCustomerSecondUpdateRequest request];
    request.user_id = [ZYUser user].pid;
    request.customer_id = self.customer.customer_id;
    
    request.bank_name = self.spouseName;
    request.acc_type = self.accountType.pid;
    request.acc_use = self.accountPurpose.pid;
    request.acc_name = self.accountName;
    request.loan_card_id = self.accountNum;
    
    request.cpy_name = self.companyName;
    request.org_code = self.companyNum;
    request.bus_lic_cert = self.companyBusinessLicenseNum;
    request.legal_person = self.companyLegalPerson;
    request.reg_money = [self.companyRegisteredCapital floatValue];
    request.com_telephone = self.companyTelephone;
    
    request.relation_name = self.relationShipName;
    request.relation_type = self.relationShipType.pid;
    request.relation_card_no = self.relationShipCardNum;
    request.relation_phone_num = self.relationShipTelephone;
    request.relation_address = self.relationShipAddress;
    
    request.credit_no = self.creditNum;
    request.rep_query_date = self.creditDate;
    
    self.loading = YES;
    [[[ZYRoute route] customerDetailInfoSecondEdit:request] subscribeNext:^(id x) {
        self.loading = NO;
        self.error = x;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
    } completed:^{
        
    }];
}
@end
