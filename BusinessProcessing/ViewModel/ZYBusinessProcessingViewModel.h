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


@property(nonatomic,strong)NSMutableArray *businessProcessingArr;
- (void)requestBussinessProcess:(ZYUser*)user loadMore:(BOOL)loadMore;
@property(nonatomic,assign)BOOL refreshing;

@property(nonatomic,assign)BOOL isMyBussiness;//是否是我的业务
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;
/**
 *  数据异常时候 提示
 */
@property(nonatomic,assign)ZYPlaceHolderViewType placeHolderViewType;


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

- (void)loadCache:(ZYUser*)user;
@end

