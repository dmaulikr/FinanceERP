//
//  ZYMyBussinessViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYMyBussinessViewModel.h"

@implementation ZYMyBussinessViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftPageSize = 20;
        self.leftPageNum = 1;
        
        self.rightPageSize = 20;
        self.rightPageNum = 1;
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
- (void)requestBussinessProcessLeftLoadMore:(BOOL)loadMore search:(BOOL)search
{
    self.leftPageNum = loadMore?self.leftPageNum+1:1;
    ZYBusinessProcessRequest *request = [ZYBusinessProcessRequest request];
    request.user_id = [ZYUser user].pid;
    request.page = self.leftPageNum;
    request.rows = self.leftPageSize;
    request.is_my_biz = YES;
    if(search)
    {
        request.project_name = self.searchKeywordModel.searchKeyword;
    }
    self.leftHasMore = YES;
    self.leftLoading = YES;
    [[[ZYRoute route] businessProcessList:request] subscribeNext:^(NSArray *productArr) {
        if(!loadMore)
        {
            [self.businessProcessingLeftArr removeAllObjects];
        }
        [self.businessProcessingLeftArr addObjectsFromArray:productArr];
        [self reloadDataSource];
        
        if(productArr.count<20)
        {
            self.leftHasMore = NO;
        }
        else
        {
            self.leftLoading = NO;
        }
        
    } error:^(NSError *error) {
        self.leftLoading = NO;
        self.error = error.domain;
    } completed:^{
        
    }];
}
- (void)requestBussinessProcessRightLoadMore:(BOOL)loadMore search:(BOOL)search
{
    self.rightPageNum = loadMore?self.rightPageNum+1:1;
    ZYBusinessProcessRequest *request = [ZYBusinessProcessRequest request];
    request.user_id = [ZYUser user].pid;
    request.page = self.rightPageNum;
    request.rows = self.rightPageSize;
    request.is_my_biz = YES;
    request.product_id = [self.businessProcessProductType.pid longLongValue];
    request.dynamic_name = self.businessProcessState;
    if(search)
    {
        request.project_name = self.searchKeywordModel.searchKeyword;
    }
    self.rightHasMore = YES;
    self.rightLoading = YES;
    [[[ZYRoute route] businessProcessList:request] subscribeNext:^(NSArray *productArr) {
        if(!loadMore)
        {
            [self.businessProcessingRightArr removeAllObjects];
        }
        [self.businessProcessingRightArr addObjectsFromArray:productArr];
        [self reloadDataSource];
        
        if(productArr.count<20)
        {
            self.rightHasMore = NO;
        }
        else
        {
            self.rightLoading = NO;
        }
        
    } error:^(NSError *error) {
        self.rightLoading = NO;
        self.error = error.domain;
    } completed:^{
        
    }];
}
- (NSArray*)businessProcessingStateArr
{
    /**
     *  固定文字 不会随意修改
     */
    NSArray *states = @[@"全部状态",@"发放贷款",@"赎楼",@"取旧证",@"注销抵押",@"过户",@"取新证",@"抵押",@"回款"];
    return states;
}
- (RACSignal*)businessProcessingSearchHistorySignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[ZYSearchHistoryModel getUsingLKDBHelper] search:[ZYSearchHistoryModel class] where:@{@"type":@(ZYHistoryTypeBusinessProcessing)} orderBy:@"searchDate" offset:0 count:INT64_MAX callback:^(NSMutableArray *array) {
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
- (NSMutableArray*)businessProcessingLeftArr
{
    if(_businessProcessingLeftArr==nil)
    {
        _businessProcessingLeftArr = [NSMutableArray arrayWithCapacity:20];
    }
    return _businessProcessingLeftArr;
}
- (NSMutableArray*)businessProcessingRightArr
{
    if(_businessProcessingRightArr==nil)
    {
        _businessProcessingRightArr = [NSMutableArray arrayWithCapacity:20];
    }
    return _businessProcessingRightArr;
}
- (void)loadCache:(ZYUser*)user
{
    ZYProductRequest *productRequest = [ZYProductRequest request];
    productRequest.user_id = user.pid;
    NSArray *productArr = [[ZYRoute route] productListCacheWith:productRequest];
    NSMutableArray *arr = [NSMutableArray arrayWithObject:@"全部产品"];
    [arr addObjectsFromArray:productArr];
    self.businessProcessingProductArr = arr;
    
    ZYBusinessProcessRequest *leftRequest = [ZYBusinessProcessRequest request];
    leftRequest.user_id = user.pid;
    leftRequest.page = self.leftPageNum;
    leftRequest.rows = self.leftPageSize;
    leftRequest.is_my_biz = YES;
    NSArray *leftArr = [[ZYRoute route] businessProcessListCacheWith:leftRequest];
    [self.businessProcessingLeftArr removeAllObjects];
    [self.businessProcessingLeftArr addObjectsFromArray:leftArr];
    
    self.leftLoading = NO;
    
    
    ZYBusinessProcessRequest *rightRequest = [ZYBusinessProcessRequest request];
    rightRequest.user_id = user.pid;
    rightRequest.page = self.rightPageNum;
    rightRequest.rows = self.rightPageSize;
    rightRequest.is_my_biz = YES;
    NSArray *rightArr = [[ZYRoute route] businessProcessListCacheWith:rightRequest];
    [self.businessProcessingRightArr removeAllObjects];
    [self.businessProcessingRightArr addObjectsFromArray:rightArr];
    
    self.rightLoading = NO;
}
@end
