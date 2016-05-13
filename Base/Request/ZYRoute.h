//
//  ZYRoute.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "ZYLoginRequest.h"
#import "ZYUser.h"
#import "ZYBannerRequest.h"
#import "ZYBannerView.h"
#import "ZYCheckInDaysRequest.h"
#import "ZYCheckInRequest.h"
#import "ZYCheckInModel.h"
#import "ZYWarningEventRquest.h"
#import "ZYWarningEvent.h"
#import "ZYProductRequest.h"
#import "ZYProductModel.h"
#import "ZYBusinessProcessRequest.h"
#import "ZYBusinessProcessModel.h"
#import "ZYBussinessStateCountRequest.h"
#import "ZYForeclosureHouseRequest.h"
#import "ZYForeclosureHouseModel.h"
#import "ZYBanksRequest.h"
#import "ZYBankModel.h"
#import "ZYMyCustomerRequest.h"
#import "ZYCustomerModel.h"
#import "ZYBusinessProcessingStateRequest.h"
#import "ZYBusinessProcessingStateModel.h"
#import "ZYBussinessProcessingStateEditRequest.h"

@interface ZYRoute : NSObject

+ (instancetype)route;
//登陆
- (RACSignal*)loginWith:(ZYLoginRequest*)myRequest;
- (id)loginCacheWith:(ZYLoginRequest*)myRequest;

- (RACSignal*)bannersWith:(ZYBannerRequest*)myRequest;
- (id)bannersCacheWith:(ZYBannerRequest*)myRequest;

- (RACSignal*)checkInWith:(ZYCheckInRequest*)myRequest;
- (RACSignal*)checkInDaysWith:(ZYCheckInDaysRequest*)myRequest;

- (RACSignal*)warningEventList:(ZYWarningEventRquest*)myRequest;
- (id)warningEventListCacheWith:(ZYWarningEventRquest*)myRequest;

- (RACSignal*)productList:(ZYProductRequest*)myRequest;
- (id)productListCacheWith:(ZYProductRequest*)myRequest;

/**
 *  查询业务办理
 */
- (RACSignal*)businessProcessList:(ZYBusinessProcessRequest*)myRequest;
- (id)businessProcessListCacheWith:(ZYBusinessProcessRequest*)myRequest;
/**
 *  业务办理每种状态条数
 */
- (RACSignal*)businessProcessStateCount:(ZYBussinessStateCountRequest*)myRequest;

- (RACSignal*)foreclosureHouseInfo:(ZYForeclosureHouseRequest*)myRequest;

- (RACSignal*)banks:(ZYBanksRequest*)myRequest;
- (id)banksCacheWith:(ZYBanksRequest*)myRequest;

- (RACSignal*)myCustomers:(ZYMyCustomerRequest*)myRequest;
- (id)myCustomersCacheWith:(ZYMyCustomerRequest*)myRequest;

- (RACSignal*)businessProcessStateList:(ZYBusinessProcessingStateRequest*)myRequest;

- (RACSignal*)businessProcessStateEdit:(ZYBussinessProcessingStateEditRequest*)myRequest;
@end
