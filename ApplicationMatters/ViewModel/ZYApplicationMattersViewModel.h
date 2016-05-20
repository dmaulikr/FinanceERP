//
//  ZYApplicationMattersViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYViewModel.h"
#import "ZYSearchHistoryModel.h"
#import "ZYBusinessProcessModel.h"
#import "ZYProductModel.h"
#import "ZYPlaceHolderView.h"

typedef enum : NSUInteger {
    ZYApplicationMattersTypeRefundCounterFee = 1,
    ZYApplicationMattersTypeRefundConsultingFee = 3,
    ZYApplicationMattersTypeRefundRetainageFee = 4,
} ZYApplicationMattersType;

@interface ZYApplicationMattersViewModel : ZYViewModel

#pragma mark - 条件文字
@property(nonatomic,strong)NSArray *applyProductArr;
- (void)requestProduceListWith:(ZYUser*)user;

@property(nonatomic,strong)NSArray *applyStateArr;

@property(nonatomic,strong)NSMutableArray *applyArr;
- (void)requestApplyLoadMore:(BOOL)loadMore search:(BOOL)search;

@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,assign)BOOL loading;
//搜索无数据时候 显示类型
@property(nonatomic,assign)ZYPlaceHolderViewType tablePlaceHolderType;

@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,assign)NSInteger pageSize;


/**
 *  搜索历史
 */
- (RACSignal*)searchHistorySignal;
- (void)cleanSearchHistory;

/**
 *  搜索条件
 */
@property(nonatomic,strong)ZYSearchHistoryModel *searchKeywordModel;
@property(nonatomic,strong)ZYProductModel *applyProductType;
@property(nonatomic,assign)NSInteger applyState;
@property(nonatomic,assign)ZYApplicationMattersType type;

@property(nonatomic,strong)NSString *error;


- (void)loadCache:(ZYUser*)user;

@end
