//
//  ZYMyCustomerViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/9.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYMyCustomerViewModel.h"

@implementation ZYMyCustomerViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize = 20;
        self.pageNum = 1;
    }
    return self;
}
- (void)requestCustomerArr:(BOOL)loadMore
{
    if(loadMore)
    {
        self.pageNum++;
    }
    else
    {
        self.pageNum = 1;
    }
    ZYMyCustomerRequest *request = [ZYMyCustomerRequest request];
    request.user_id = [ZYUser user].pid;
    request.customer_name = self.searchKeywordModel.searchKeyword;
    request.page = self.pageNum;
    request.rows = self.pageSize;
    self.loading = YES;
    self.hasMore = YES;
    [[[ZYRoute route] myCustomers:request] subscribeNext:^(NSArray *arr) {
        
        if(!loadMore)
        {
            [self.customerArr removeAllObjects];
        }
        [self.customerArr addObjectsFromArray:arr];
        if(arr.count<self.pageSize)
        {
            self.hasMore = NO;
        }
        else
        {
            self.loading = NO;
        }
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
    } completed:^{
    }];
}
//- (void)searchCustomer:(BOOL)loadMore
//{
//    if(loadMore)
//    {
//        self.searchPageNum++;
//    }
//    else
//    {
//        self.searchPageNum = 1;
//    }
//    ZYMyCustomerRequest *request = [ZYMyCustomerRequest request];
//    request.user_id = [ZYUser user].pid;
//    request.customer_name = self.searchKeywordModel.searchKeyword;
//    request.page = self.searchPageNum;
//    request.rows = self.searchPageSize;
//    self.searchLoading = YES;
//    self.searchHasMore = YES;
//    [[[ZYRoute route] myCustomers:request] subscribeNext:^(NSArray *arr) {
//        if(!loadMore)
//        {
//            [self.customerArr removeAllObjects];
//        }
//        [self.customerArr addObjectsFromArray:arr];
//        if(arr.count<self.pageSize)
//        {
//            self.hasMore = NO;
//        }
//        else
//        {
//            self.loading = NO;
//        }
//    } error:^(NSError *error) {
//        self.error = error.domain;
//        self.loading = NO;
//    } completed:^{
//    }];
//}
- (NSMutableArray*)customerArr
{
    if(_customerArr==nil)
    {
        _customerArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _customerArr;
}
- (NSMutableArray*)searchResultArr
{
    if(_searchResultArr==nil)
    {
        _searchResultArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _searchResultArr;
}
//- (ZYSearchHistoryModel*)customerSearchHistory
//{
//    return [[ZYSearchHistoryModel getUsingLKDBHelper] searchSingle:[ZYSearchHistoryModel class] where:@{@"type":@(ZYHistoryTypeMyCustomer)} orderBy:@"searchDate"];
//}
- (void)setSearchKeywordModel:(ZYSearchHistoryModel *)searchKeywordModel
{
    _searchKeywordModel = searchKeywordModel;
    
    searchKeywordModel.type = ZYHistoryTypeMyCustomer;
    LKDBHelper *helper = [ZYSearchHistoryModel getUsingLKDBHelper];
    if(![helper getTableCreatedWithClass:[ZYSearchHistoryModel class]])
    {
        NSLog(@"创建表失败");
    }
    [searchKeywordModel saveToDB];
}
//- (void)cleanSearchHistory
//{
//    LKDBHelper *helper = [ZYSearchHistoryModel getUsingLKDBHelper];
//    [helper deleteWithClass:[ZYSearchHistoryModel class] where:@{@"type":@(ZYHistoryTypeMyCustomer)}];
//}
- (void)loadCache
{
    ZYMyCustomerRequest *request = [ZYMyCustomerRequest request];
    request.user_id = [ZYUser user].pid;
//    request.customer_name = self.searchKeywordModel.searchKeyword;
    request.page = self.pageNum;
    request.rows = self.pageSize;
    self.customerArr = [[ZYRoute route] myCustomersCacheWith:request];
    self.loading = NO;
}
@end
