//
//  ZYForeclosureHouseOrderTypeModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

typedef enum : NSUInteger {
    ZYForeclosureHouseBussinessInfoOrderInside = 0,//内单
    ZYForeclosureHouseBussinessInfoOrderOutside,///外单
} ZYForeclosureHouseBussinessInfoOrderType;

@interface ZYForeclosureHouseOrderTypeModel : ZYStoreModel

@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)ZYForeclosureHouseBussinessInfoOrderType type;
@property(nonatomic,assign)NSInteger pid;

@end
