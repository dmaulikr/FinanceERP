//
//  ZYMyCustomerController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/9.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYMyCustomerController.h"
#import "ZYTableViewCell.h"
#import <MJRefresh.h>
#import <CYLTableViewPlaceHolder.h>
#import "ZYCustomerBaseInfoController.h"

@interface ZYMyCustomerController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;
@end

@implementation ZYMyCustomerController
ZY_VIEW_MODEL_GET(ZYMyCustomerViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
    
}
- (void)buildUI
{
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYMyCustomerCell class]) bundle:nil] forCellReuseIdentifier:[ZYMyCustomerCell defaultIdentifier]];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_footer resetNoMoreData];
        [self.viewModel requestCustomerArr:NO];
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.viewModel requestCustomerArr:YES];
    }];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
    
    [self.viewModel loadCache];
    [self.tableView.mj_header beginRefreshing];
    
    self.searchBar.placeholder = @"请输入客户姓名";
}
- (void)blendViewModel
{
    [[RACObserve(self.viewModel, loading) skip:1] subscribeNext:^(NSNumber *loading) {
        if(!loading.boolValue)
        {
            [self.tableView cyl_reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self stop];
        }
    }];
    [[RACObserve(self.viewModel, hasMore) skip:1] subscribeNext:^(NSNumber *loading) {
        if(!loading.boolValue)
        {
            [self.tableView cyl_reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self stop];
        }
    }];
    [[RACObserve(self.viewModel, error) skip:1] subscribeNext:^(NSString *error) {
        [self tip:error touch:NO];
    }];
}
- (IBAction)addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"info" sender:nil];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    ZYSearchHistoryModel *model = [[ZYSearchHistoryModel alloc] init];
    model.searchKeyword = searchText;
    model.searchDate = [NSDate date];
    model.type = ZYHistoryTypeMyCustomer;
    self.viewModel.searchKeywordModel = model;
    
    [self loading:YES];
    [self.tableView.mj_footer resetNoMoreData];
    [self.viewModel requestCustomerArr:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.tableView)
    {
        return self.viewModel.customerArr.count;
    }
    return self.viewModel.searchResultArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYMyCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYMyCustomerCell defaultIdentifier]];
    if(tableView==self.tableView)
    {
        [cell loadData:self.viewModel.customerArr[indexPath.row]];
    }
    else
    {
        [cell loadData:self.viewModel.searchResultArr[indexPath.row]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZYMyCustomerCell defaultHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"info" sender:self.viewModel.customerArr[indexPath.row]];
}


- (UIView*)makePlaceHolderView
{
    ZYPlaceHolderView *view = [[ZYPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.height) type:self.viewModel.tablePlaceHolderType];
    return view;
}
- (BOOL)enableScrollWhenPlaceHolderViewShowing
{
    return YES;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if([segue.identifier isEqualToString:@"info"])
     {
         ZYCustomerModel *model = sender;
         if(sender)//编辑查看
         {
             ZYCustomerBaseInfoController *customerInfoCtl = [segue destinationViewController];
             customerInfoCtl.customerID = model.pid;
             [customerInfoCtl.hasEditSignal subscribeNext:^(ZYCustomerModel *customer) {
                 //             if([self.viewModel.customerArr indexOfObject:model]!=NSNotFound)
                 //             {
                 //                 NSInteger index = [self.viewModel.customerArr indexOfObject:model];
                 //                 [self.viewModel.customerArr replaceObjectAtIndex:index withObject:customer];
                 //                 [self.tableView cyl_reloadData];
                 //             }
                 [self.tableView.mj_header beginRefreshing];
             }];
         }
         else
         {
             ZYCustomerBaseInfoController *customerInfoCtl = [segue destinationViewController];
             [customerInfoCtl.hasEditSignal subscribeNext:^(ZYCustomerModel *customer) {
                 //             if([self.viewModel.customerArr indexOfObject:model]!=NSNotFound)
                 //             {
                 //                 NSInteger index = [self.viewModel.customerArr indexOfObject:model];
                 //                 [self.viewModel.customerArr replaceObjectAtIndex:index withObject:customer];
                 //                 [self.tableView cyl_reloadData];
                 //             }
                 [self.tableView.mj_header beginRefreshing];
             }];
         }
     }
 }

@end
