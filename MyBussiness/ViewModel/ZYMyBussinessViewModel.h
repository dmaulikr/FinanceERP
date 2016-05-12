//
//  ZYMyBussinessViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYSearchHistoryModel.h"
#import "ZYBusinessProcessModel.h"
#import "ZYProductModel.h"
#import "ZYPlaceHolderView.h"

@interface ZYMyBussinessViewModel : ZYViewModel
#pragma mark - 条件文字
@property(nonatomic,strong)NSArray *businessProcessingProductArr;
- (void)requestProduceListWith:(ZYUser*)user;

@property(nonatomic,strong)NSArray *businessProcessingStateArr;
//@property(nonatomic,strong)NSArray *businessProcessingStateShowArr;

@property(nonatomic,strong)NSMutableArray *businessProcessingLeftArr;
- (void)requestBussinessProcessLeftLoadMore:(BOOL)loadMore search:(BOOL)search;

@property(nonatomic,strong)NSMutableArray *businessProcessingRightArr;
- (void)requestBussinessProcessRightLoadMore:(BOOL)loadMore search:(BOOL)search;

//搜索无数据时候 显示类型
@property(nonatomic,assign)ZYPlaceHolderViewType tablePlaceHolderType;

@property(nonatomic,assign)BOOL leftHasMore;
@property(nonatomic,assign)BOOL leftLoading;

@property(nonatomic,assign)NSInteger leftPageNum;
@property(nonatomic,assign)NSInteger leftPageSize;

@property(nonatomic,assign)BOOL rightHasMore;
@property(nonatomic,assign)BOOL rightLoading;

@property(nonatomic,assign)NSInteger rightPageNum;
@property(nonatomic,assign)NSInteger rightPageSize;
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
//@property(nonatomic,strong)NSDictionary *businessStateCount;
//- (void)requestBussinessStateCount:(ZYUser*)user;

- (void)loadCache:(ZYUser*)user;
@end
