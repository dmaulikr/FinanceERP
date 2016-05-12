//
//  ZYMyCustomerViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/9.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYPlaceHolderView.h"
#import "ZYSearchHistoryModel.h"

@interface ZYMyCustomerViewModel : ZYViewModel
//搜索无数据时候 显示类型
@property(nonatomic,assign)ZYPlaceHolderViewType tablePlaceHolderType;

@property(nonatomic,strong)ZYSearchHistoryModel *searchKeywordModel;

@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,assign)NSInteger pageNum;
//还有更多
@property(nonatomic,assign)BOOL hasMore;
@property(nonatomic,assign)BOOL loading;

//@property(nonatomic,assign)NSInteger searchPageSize;
//@property(nonatomic,assign)NSInteger searchPageNum;
////还有更多
//@property(nonatomic,assign)BOOL searchHasMore;
//@property(nonatomic,assign)BOOL searchLoading;

@property(nonatomic,strong)NSString *error;

@property(nonatomic,strong)NSMutableArray *customerArr;
@property(nonatomic,strong)NSMutableArray *searchResultArr;

- (void)requestCustomerArr:(BOOL)loadMore;

- (void)loadCache;
@end
