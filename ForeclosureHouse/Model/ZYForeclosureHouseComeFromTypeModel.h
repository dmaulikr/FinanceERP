//
//  ZYForeclosureHouseComeFromTypeModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoComeFromBank = 0,//银行
    ZYForeclosureHouseBussinessInfoComeFromIntermediary,///中介
    ZYForeclosureHouseBussinessInfoComeFromFriend,///朋友
    ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization,
    ZYForeclosureHouseBussinessInfoComeFromOther,
} ZYForeclosureHouseBussinessInfoComeFromType;///业务来源信息

@interface ZYForeclosureHouseComeFromTypeModel : ZYStoreModel

@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)ZYForeclosureHouseBussinessInfoComeFromType type;
@property(nonatomic,assign)NSInteger pid;

@end
