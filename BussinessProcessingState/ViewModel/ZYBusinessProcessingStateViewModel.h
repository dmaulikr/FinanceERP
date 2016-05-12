//
//  ZYBusinessProcessingStateViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYBusinessProcessingStatePageModel.h"

@interface ZYBusinessProcessingStateViewModel : ZYViewModel

@property(nonatomic,assign)NSInteger businessProcessingID;
/**
 *  当前状态
 */
@property(nonatomic,strong)NSString *businessProcessingState;
@property(nonatomic,assign)NSInteger businessProcessingStateIndex;
/**
 *  状态数组
 */
@property(nonatomic,strong)NSArray *businessProcessingStateArr;
/**
 *  当前共经过多少天
 */
@property(nonatomic,assign)NSInteger businessProcessingDays;


@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)BOOL loading;

- (void)requestBusinessProcessingState;

@end
