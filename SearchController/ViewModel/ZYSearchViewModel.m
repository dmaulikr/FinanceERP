//
//  ZYSearchViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/12.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSearchViewModel.h"

@interface ZYSearchViewModel()

@property(nonatomic,strong)NSMutableArray *searchArr;///全部数据

@end

@implementation ZYSearchViewModel
+ (ZYSearchViewModel*)viewModelWithSignal:(RACSignal*)searchSignal
{
    ZYSearchViewModel *viewModel = [[ZYSearchViewModel alloc] initWithSignal:searchSignal];
    return viewModel;
}
- (instancetype)initWithSignal:(RACSignal*)searchSignal
{
    self = [super init];
    if (self) {
        self.searchSignal = searchSignal;
        _filterDict = [NSMutableDictionary dictionaryWithCapacity:10];
        _initialArr = [NSMutableArray arrayWithCapacity:10];
        self.tablePlaceHolderType = ZYPlaceHolderViewTypeNoSearchData;
    }
    return self;
}
- (NSMutableArray*)searchArr
{
    if(_searchArr==nil)
    {
        _searchArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _searchArr;
}
- (RACSignal*)searchWithText:(NSString*)searchText
{
    _loading = YES;
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_queue_t queue = dispatch_queue_create("com.FinanceERP.search", nil);
        dispatch_async(queue, ^{
            [_searchSignal subscribeNext:^(NSArray *searchArr) {
                
                [self.searchArr setArray:searchArr];
                
                NSArray *array;
                if(searchText.length==0)
                {
                    array = self.searchArr;
                }
                else
                {
                    NSString *str = [NSString stringWithFormat:@"%@ CONTAINS[cd] '%@'",_showPropertyKey,searchText];
                    NSPredicate *predicate=[NSPredicate predicateWithFormat:str];
                    array=[self.searchArr filteredArrayUsingPredicate:predicate];
                }
                NSMutableArray *initials = [NSMutableArray arrayWithCapacity:10];
                [_filterDict removeAllObjects];
                for(id obj in array)
                {
                    if(self.showPropertyKey.length==0||[obj valueForKey:self.showPropertyKey]==nil||![[obj valueForKey:self.showPropertyKey] isKindOfClass:[NSString class]])
                    {
                        return;
                    }
                    NSString *showStr = [obj valueForKey:self.showPropertyKey];
                    NSString *firstChar = [NSString firstCharactor:showStr];
                    if(![_filterDict.allKeys containsObject:firstChar])
                    {
                        NSMutableArray *subArr = [NSMutableArray arrayWithObject:obj];
                        [_filterDict setObject:subArr forKey:firstChar];
                        [initials addObject:firstChar];///字母排序添加
                    }
                    else
                    {
                        [[_filterDict objectForKey:firstChar] addObject:obj];
                    }
                }
                _initialArr = [initials sortedArrayUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2) {
                    NSComparisonResult result = [obj1 compare:obj2];
                    return result;
                }];///字母排序
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [subscriber sendNext:nil];
                    self.loading = NO;
                });
            }];
        });
        return nil;
    }];
    return signal;
}
- (void)keyboardSearchButtonPressed:(NSString*)keyword{}
- (RACSignal*)keyboardSearchButtonPressedSignal
{
    if(_keyboardSearchButtonPressedSignal==nil)
    {
        _keyboardSearchButtonPressedSignal = [[self rac_signalForSelector:@selector(keyboardSearchButtonPressed:)] map:^id(RACTuple *value) {
            return value.first;
        }];
    }
    return _keyboardSearchButtonPressedSignal;
}
- (void)cleanButtonPressed{}
- (RACSignal*)cleanButtonPressedSignal
{
    if(_cleanButtonPressedSignal==nil)
    {
        _cleanButtonPressedSignal = [[self rac_signalForSelector:@selector(cleanButtonPressed)] map:^id(RACTuple *value) {
            return value.first;
        }];
    }
    return _cleanButtonPressedSignal;
}

@end
