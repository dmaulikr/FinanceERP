//
//  ZYRefundFeeViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYApplicationMattersController.h"

@interface ZYRefundFeeViewModel : ZYViewModel

@property(nonatomic,strong)ZYApplyMattersModel *model;
@property(nonatomic,assign)ZYApplicationMattersType type;

@property(nonatomic,assign)BOOL loading;
@property(nonatomic,assign)BOOL success;
@property(nonatomic,strong)NSString *error;

@property(nonatomic,assign)NSString *money;
@property(nonatomic,assign)NSString *accountName;
@property(nonatomic,assign)NSString *account;
@property(nonatomic,assign)NSString *accountBank;


- (void)getFeeInfo;
- (void)refundFeeRequest;

@end
