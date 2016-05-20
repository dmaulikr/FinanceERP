//
//  ZYUserCenterViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserCenterViewModel.h"

@interface ZYUserCenterViewModel ()

@property(nonatomic,strong)NSArray *imageArr;

@end

@implementation ZYUserCenterViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.dataSource = [NSMutableArray arrayWithArray:@[@"我的业务",@"我的客户",@"我的积分",@"问题反馈",@"电话咨询",@"检查更新"]];
//        self.imageArr = @[@"user-ic1",@"user-ic2",@"user-ic3",@"user-ic4",@"user-ic5",@"user-ic6"];
        
        self.dataSource = [NSMutableArray arrayWithArray:@[@"我的业务",@"我的客户",@"我的积分",@"问题反馈",@"电话咨询"]];
        self.imageArr = @[@"user-ic1",@"user-ic2",@"user-ic3",@"user-ic4",@"user-ic5"];
    }
    return self;
}
- (NSString*)imageForIndex:(NSInteger)index
{
    return self.imageArr[index];
}
- (NSString*)contentForIndex:(NSInteger)index
{
    return self.dataSource[index];
}
@end
