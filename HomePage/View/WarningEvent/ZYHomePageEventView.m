//
//  ZYHomePageEventView.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageEventView.h"
#import "ZYHomePageEventCell.h"

#define MAX_COUNT 5

@interface ZYHomePageEventView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZYHomePageEventView
{
    UITableView *eventTableView;
}
+ (CGFloat)defaultHeight
{
    return 140;
}
- (void)layoutSubviews
{
    NSInteger maxCount = MAX_COUNT;
    eventTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, FUll_SCREEN_WIDTH, [ZYHomePageEventCell defaultHeight]*maxCount+20*2) style:UITableViewStylePlain];
    eventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    eventTableView.delegate = self;
    eventTableView.dataSource = self;
    eventTableView.scrollEnabled = NO;
    eventTableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:eventTableView];
    
    eventTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FUll_SCREEN_WIDTH, [ZYHomePageEventCell defaultHeight])];
    eventTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FUll_SCREEN_WIDTH, [ZYHomePageEventCell defaultHeight])];
    
    [[self rac_signalForSelector:@selector(tableView:cellForRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)] subscribeNext:^(RACTuple *x) {
        return;
    }];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHomePageEventCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYHomePageEventCell defaultIdentifier]];
    if(cell==nil)
    {
        cell = [ZYHomePageEventCell cellWithActionBlock:nil];
        [cell setLineHidden:YES];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell loadDataSource:_eventArr[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _eventArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZYHomePageEventCell defaultHeight];
}

- (void)setEventArr:(NSArray *)eventArr
{
    _eventArr = eventArr;
    [eventTableView reloadData];
}
+ (CGSize)defaultSize
{
    NSInteger maxCount = MAX_COUNT;
    return CGSizeMake(FUll_SCREEN_WIDTH, [ZYHomePageEventCell defaultHeight]*maxCount+20*2);
}
@end
