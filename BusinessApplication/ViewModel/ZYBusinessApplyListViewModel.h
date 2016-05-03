//
//  ZYBusinessApplyListViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"

@interface ZYBusinessApplyListViewModel : ZYViewModel

@property(nonatomic,assign)BOOL foreclosureHouse;///赎楼

@property(nonatomic,assign)BOOL downPaymentMortgage;///首付贷款功能

@property(nonatomic,assign)BOOL houseMortgage;///房帮贷

@property(nonatomic,assign)BOOL customerFundMortgage;///客户资金贷款

@property(nonatomic,assign)BOOL creditMortgage;///信用贷款
@end
