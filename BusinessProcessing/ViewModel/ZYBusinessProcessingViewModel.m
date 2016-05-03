//
//  ZYBusinessProcessingViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingViewModel.h"

@implementation ZYBusinessProcessingViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize = 20;
        self.pageNum = 1;
        self.refreshing = YES;//默认上来刷新一次
    }
    return self;
}
- (void)requestProduceListWith:(ZYUser*)user
{
    ZYProductRequest *request = [ZYProductRequest request];
    request.user_id = user.pid;
    [[[ZYRoute route] productList:request] subscribeNext:^(NSArray *productArr) {
        NSMutableArray *arr = [NSMutableArray arrayWithObject:@"全部产品"];
        [arr addObjectsFromArray:productArr];
        self.businessProcessingProductArr = arr;
    }];
}
- (void)requestBussinessProcess:(ZYUser*)user loadMore:(BOOL)loadMore
{
    self.pageNum = loadMore?self.pageNum+1:0;
    ZYBusinessProcessRequest *request = [ZYBusinessProcessRequest request];
    request.user_id = user.pid;
    request.page = self.pageNum;
    request.rows = self.pageSize;
    request.is_my_biz = self.isMyBussiness;
    _refreshing = YES;
    [[[ZYRoute route] businessProcessList:request] subscribeNext:^(NSArray *productArr) {
        if(!loadMore)
        {
            [self.businessProcessingArr removeAllObjects];
        }
        [self.businessProcessingArr addObjectsFromArray:productArr];
        if(self.businessProcessingArr.count==0)
        {
            self.placeHolderViewType = ZYPlaceHolderViewTypeNoData;
        }
        [self reloadDataSource];
    } error:^(NSError *error) {
        if(error.code==404)
        {
            if(self.businessProcessingArr.count==0)
            {
                self.placeHolderViewType = ZYPlaceHolderViewTypeNoNet;
            }
            [self reloadDataSource];
        }
        else
        {
            self.error = error.domain;
        }
        self.refreshing = NO;
    } completed:^{
        self.refreshing = NO;
    }];
}
- (NSArray*)businessProcessingStateArr
{
    /**
     *  固定文字 不会随意修改
     */
    return @[@"全部状态",@"待发放贷款",@"待赎楼",@"待取旧证",@"待注销抵押",@"待过户",@"待取新证",@"待抵押",@"待回款"];
}
- (RACSignal*)businessProcessingSearchHistorySignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[ZYSearchHistoryModel getUsingLKDBHelper] search:[ZYSearchHistoryModel class] where:nil orderBy:@"searchDate" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [subscriber sendNext:array];
            });
        }];
        return nil;
    }];
    return signal;
}
- (void)setSearchKeywordModel:(ZYSearchHistoryModel *)searchKeywordModel
{
    _searchKeywordModel = searchKeywordModel;
    LKDBHelper *helper = [ZYSearchHistoryModel getUsingLKDBHelper];
    if(![helper getTableCreatedWithClass:[ZYSearchHistoryModel class]])
    {
        NSLog(@"创建表失败");
    }
    [searchKeywordModel saveToDB];
}
- (void)cleanSearchHistory
{
    LKDBHelper *helper = [ZYSearchHistoryModel getUsingLKDBHelper];
    [helper deleteWithClass:[ZYSearchHistoryModel class] where:nil];
}
- (NSMutableArray*)businessProcessingArr
{
    if(_businessProcessingArr==nil)
    {
        _businessProcessingArr = [NSMutableArray arrayWithCapacity:20];
    }
    return _businessProcessingArr;
}

- (void)loadCache:(ZYUser*)user
{
    ZYProductRequest *productRequest = [ZYProductRequest request];
    productRequest.user_id = user.pid;
    NSArray *productArr = [[ZYRoute route] productListCacheWith:productRequest];
    NSMutableArray *arr = [NSMutableArray arrayWithObject:@"全部产品"];
    [arr addObjectsFromArray:productArr];
    self.businessProcessingProductArr = arr;
    
    ZYBusinessProcessRequest *businessProcessRequest = [ZYBusinessProcessRequest request];
    businessProcessRequest.user_id = user.pid;
    businessProcessRequest.page = self.pageNum;
    businessProcessRequest.rows = self.pageSize;
    businessProcessRequest.is_my_biz = self.isMyBussiness;
    NSArray *businessProcessArr = [[ZYRoute route] businessProcessListCacheWith:businessProcessRequest];
    [self.businessProcessingArr removeAllObjects];
    [self.businessProcessingArr addObjectsFromArray:businessProcessArr];
    [self reloadDataSource];
}
@end
