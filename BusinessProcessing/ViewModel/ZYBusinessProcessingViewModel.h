//
//  ZYBusinessProcessingViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYSearchHistoryModel.h"
#import "ZYBusinessProcessModel.h"
#import "ZYProductModel.h"
#import "ZYPlaceHolderView.h"

@interface ZYBusinessProcessingViewModel : ZYViewModel
#pragma mark - 条件文字
@property(nonatomic,strong)NSArray *businessProcessingProductArr;
- (void)requestProduceListWith:(ZYUser*)user;

@property(nonatomic,strong)NSArray *businessProcessingStateArr;
@property(nonatomic,strong)NSArray *businessProcessingStateShowArr;

@property(nonatomic,strong)NSMutableArray *businessProcessingArr;
- (void)requestBussinessProcessLoadMore:(BOOL)loadMore search:(BOOL)search;

@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,assign)BOOL loading;
//搜索无数据时候 显示类型
@property(nonatomic,assign)ZYPlaceHolderViewType tablePlaceHolderType;

@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;


/**
 *  搜索历史
 */
- (RACSignal*)businessProcessingSearchHistorySignal;
- (void)cleanSearchHistory;

/**
 *  搜索条件
 */
@property(nonatomic,strong)ZYSearchHistoryModel *searchKeywordModel;
@property(nonatomic,strong)ZYProductModel *businessProcessProductType;
@property(nonatomic,strong)NSString *businessProcessState;

@property(nonatomic,strong)NSString *error;

/**
 *  状态数量
 */
@property(nonatomic,strong)NSDictionary *businessStateCount;
- (void)requestBussinessStateCount:(ZYUser*)user;

- (void)loadCache:(ZYUser*)user;
@end

