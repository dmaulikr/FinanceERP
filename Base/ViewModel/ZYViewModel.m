//
//  ZYViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/25.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"

@implementation ZYViewModel

- (void)reloadDataSource{}

- (NSMutableArray*)dataSource
{
    if(_dataSource==nil)
    {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
@end
