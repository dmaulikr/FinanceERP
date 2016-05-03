//
//  ZYSelectListController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/31.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSelectListController.h"
#import "ZYSelectListCell.h"

@interface ZYSelectListController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYSelectListController
ZY_VIEW_MODEL_GET(ZYSelectListViewModel)
- (instancetype)initWithViewModel:(ZYSelectListViewModel*)viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    ZYSelectListViewModel *viewModel = self.viewModel;
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYSelectListCell class]) bundle:nil] forCellReuseIdentifier:[ZYSelectListCell defaultIdentifier]];
    ZYSection *section = [ZYSection sectionSupportingReuseWithTitle:nil cellHeight:[ZYSelectListCell defaultHeight] cellCount:^NSInteger(UITableView *tableView, NSInteger section) {
        return viewModel.dataSource.count;
    } cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        ZYSelectListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYSelectListCell defaultIdentifier]];
        cell.cellTitle = [viewModel contentForItem:row];
        return cell;
    } actionBlock:^(UITableView *tableView, NSInteger row) {
        [self selectItemWith:viewModel.dataSource[row]];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.sections = @[section];
}
- (void)blendViewModel
{
    ZYSelectListViewModel *viewModel = self.viewModel;
    [RACObserve(viewModel,dataSource) subscribeNext:^(NSString *dataSource) {
        [_myTableView reloadData];
    }];
    RAC(self, title) = RACObserve(viewModel, title);
}
- (UITableView*)tableView
{
    return _myTableView;
}
- (void)selectItemWith:(NSDictionary*)item{}
- (RACSignal*)selectSignal
{
    if(_selectSignal==nil)
    {
        _selectSignal = [[self rac_signalForSelector:@selector(selectItemWith:)] map:^id(RACTuple *value) {
            return value.first;
        }];
    }
    return _selectSignal;
}
@end
