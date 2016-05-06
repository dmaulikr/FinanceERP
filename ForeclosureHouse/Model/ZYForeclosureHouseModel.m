//
//  ZYForeclosureHouseModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseModel.h"

@implementation ZYForeclosureHouseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"foreInfos" : [ZYForeinfos class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"loan_person" : @"new_loan_person",
             @"loan_phone" : @"new_loan_phone",};
}

@end


@implementation ZYForeinfos

@end