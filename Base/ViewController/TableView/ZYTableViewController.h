//
//  ZYTableViewController.h
//  FinanceERP
//
//  Created by zhangyu on 16/4/1.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYSection.h"
#import "ZYTableViewCell.h"
#import "ZYViewController.h"
#import "ZYPlaceHolderView.h"

@interface ZYTableViewController : ZYViewController

@property(nonatomic,strong)UITableView *tableView;
/**
 *  cell分组
 */
@property (strong,nonatomic) NSArray *sections;

@property (assign,nonatomic) BOOL autoReload;///默认自动刷新

//- (UITableView*)tableView;

- (void)showSection:(BOOL)show sectionIndex:(NSInteger)sectionIndex;

@property(nonatomic,assign)CGRect frame;

- (void)reloadData;
- (void)reloadDataWithType:(ZYPlaceHolderViewType)type;

- (void)beginRefresh;
- (void)stopRefresh;

- (void)beginLoadmore;
- (void)stopLoadmore;

- (void)noMoreData;
/**
 *  网络支持 包括下拉刷新 还有无数据时候 空的占位的 view
 */
@property(nonatomic,assign)BOOL networkSupport;
@property(nonatomic,strong)RACSignal *refreshSignal;
@property(nonatomic,strong)RACSignal *loadmoreSignal;
@end
