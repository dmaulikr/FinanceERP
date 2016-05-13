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
- (void)requestBussinessProcessLoadMore:(BOOL)loadMore search:(BOOL)search
{
    self.pageNum = loadMore?self.pageNum+1:1;
    ZYBusinessProcessRequest *request = [ZYBusinessProcessRequest request];
    request.user_id = [ZYUser user].pid;
    request.page = self.pageNum;
    request.rows = self.pageSize;
    request.is_my_biz = NO;
    request.product_id = [self.businessProcessProductType.pid longLongValue];
    request.dynamic_name = self.businessProcessState;
    if(search)
    {
        request.project_name = self.searchKeywordModel.searchKeyword;
    }
    self.hasMore = YES;
    self.loading = YES;
    [[[ZYRoute route] businessProcessList:request] subscribeNext:^(NSArray *productArr) {
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
- (void)requestBussinessStateCount:(ZYUser*)user
{
    ZYBussinessStateCountRequest *request = [ZYBussinessStateCountRequest request];
    request.user_id = user.pid;
    [[[ZYRoute route] businessProcessStateCount:request] subscribeNext:^(NSDictionary *result) {
        self.businessStateCount = result;
    }];
}
- (NSArray*)businessProcessingStateShowArr
{
    /**
     *  固定文字 不会随意修改
     */
    NSArray *states = @[@"全部状态",@"发放贷款",@"赎楼",@"取旧证",@"注销抵押",@"过户",@"取新证",@"抵押",@"回款"];
    NSMutableArray *stateWithCount = [NSMutableArray arrayWithCapacity:states.count];
    if(self.businessStateCount.count>0)
    {
        for(int i=0;i<states.count;i++)
        {
            NSNumber *count = self.businessStateCount[states[i]];
            NSString *state = nil;
            if(count!=nil)
            {
                state = [NSString stringWithFormat:@"%@(%@)",states[i],count];
            }
            else
            {
                state = [NSString stringWithFormat:@"%@(0)",states[i]];
            }
            [stateWithCount addObject:state];
        }
        return stateWithCount;
    }
    return states;
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
    businessProcessRequest.is_my_biz = NO;
    NSArray *businessProcessArr = [[ZYRoute route] businessProcessListCacheWith:businessProcessRequest];
    [self.businessProcessingArr removeAllObjects];
    [self.businessProcessingArr addObjectsFromArray:businessProcessArr];
    [self reloadDataSource];
}
@end
