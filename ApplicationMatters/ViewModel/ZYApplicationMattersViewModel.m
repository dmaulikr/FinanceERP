//
//  ZYApplicationMattersViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYApplicationMattersViewModel.h"

@interface ZYApplicationMattersViewModel ()

@end

@implementation ZYApplicationMattersViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize = 20;
        self.pageNum = 1;
        self.applyState = 1;
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
        self.applyProductArr = arr;
    }];
}
- (void)requestApplyLoadMore:(BOOL)loadMore search:(BOOL)search
{
    self.pageNum = loadMore?self.pageNum+1:1;
    ZYApplyMattersRequest *request = [ZYApplyMattersRequest request];
    request.user_id = [ZYUser user].pid;
    request.page = self.pageNum;
    request.rows = self.pageSize;
    if(self.applyState==1)
    {
        request.back_fee_apply_status_list = @"1";
    }
    else
    {
        request.back_fee_apply_status_list = @"2,3,4,5";
    }
    
    request.type = self.type;
    request.product_id = [self.applyProductType.pid longLongValue];
//    request.dynamic_name = self.applyState;
    if(search)
    {
        request.project_name = self.searchKeywordModel.searchKeyword;
    }
    self.hasMore = YES;
    self.loading = YES;
    [[[ZYRoute route] applyMatters:request] subscribeNext:^(NSArray *productArr) {
        if(!loadMore)
        {
            [self.businessProcessingArr removeAllObjects];
        }
        [self.businessProcessingArr addObjectsFromArray:productArr];
        [self reloadDataSource];
        
        if(productArr.count<20)
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

- (NSArray*)applyStateArr
{
    /**
     *  固定文字 不会随意修改
     */
    NSArray *states = @[@"未申请",@"已申请"];
    return states;
}
- (RACSignal*)searchHistorySignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[ZYSearchHistoryModel getUsingLKDBHelper] search:[ZYSearchHistoryModel class] where:@{@"type":@(ZYHistoryTypeApply)} orderBy:@"searchDate" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
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
    
    searchKeywordModel.type = ZYHistoryTypeBusinessProcessing;
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
    [helper deleteWithClass:[ZYSearchHistoryModel class] where:@{@"type":@(ZYHistoryTypeBusinessProcessing)}];
}
- (NSMutableArray*)businessProcessingArr
{
    if(_applyArr==nil)
    {
        _applyArr = [NSMutableArray arrayWithCapacity:20];
    }
    return _applyArr;
}

- (void)loadCache:(ZYUser*)user
{
    ZYProductRequest *productRequest = [ZYProductRequest request];
    productRequest.user_id = user.pid;
    NSArray *productArr = [[ZYRoute route] productListCacheWith:productRequest];
    NSMutableArray *arr = [NSMutableArray arrayWithObject:@"全部产品"];
    [arr addObjectsFromArray:productArr];
    self.applyProductArr = arr;
    
    ZYApplyMattersRequest *applyRequest = [ZYApplyMattersRequest request];
    applyRequest.user_id = [ZYUser user].pid;
    applyRequest.page = self.pageNum;
    applyRequest.rows = self.pageSize;
    if(self.applyState==1)
    {
        applyRequest.back_fee_apply_status_list = @"1";
    }
    else
    {
        applyRequest.back_fee_apply_status_list = @"2,3,4,5";
    }
    applyRequest.type = self.type;
    applyRequest.product_id = [self.applyProductType.pid longLongValue];
    NSArray *businessProcessArr = [[ZYRoute route] applyMattersCacheWith:applyRequest];
    [self.businessProcessingArr removeAllObjects];
    [self.businessProcessingArr addObjectsFromArray:businessProcessArr];
    [self reloadDataSource];
}

@end
