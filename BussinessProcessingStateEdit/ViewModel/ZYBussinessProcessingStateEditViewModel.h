//
//  ZYBussinessProcessingStateEditViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYBusinessProcessingStatePageModel.h"
#import "ZYBusinessProcessingStateEditSections.h"

@interface ZYBussinessProcessingStateEditViewModel : ZYViewModel
@property(nonatomic,assign)NSInteger businessProcessingID;
/**
 *  当前状态
 */
@property(nonatomic,strong)NSString *businessProcessingState;
@property(nonatomic,assign)NSInteger businessProcessingStateIndex;
/**
 *  状态
 */
@property(nonatomic,strong)ZYBusinessProcessingStatePageModel *businessProcessingStatePageModel;
/**
 *  当前共经过多少天
 */
@property(nonatomic,assign)NSInteger businessProcessingDays;
/**
 *  是否提交成功
 */
@property(nonatomic,assign)BOOL success;
@property(nonatomic,strong)NSString *error;
@property(nonatomic,assign)BOOL loading;

- (void)requestBusinessProcessingState;
- (void)requestBusinessProcessingEdit;
@end
