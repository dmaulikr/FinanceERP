//
//  ZYForeclosureHouseViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseViewModel.h"

@implementation ZYForeclosureHouseViewModel
- (ZYForeclosureHouseValueModel*)valueModel
{
    if(_valueModel==nil)
    {
        _valueModel = [[ZYForeclosureHouseValueModel alloc] init];
    }
    return _valueModel;
}
@end
