//
//  ZYBusinessProcessingController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/21.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYBusinessProcessingController.h"
#import "ZYTableViewController.h"
#import "ZYFilterBar.h"
#import "ZYSearchViewController.h"
#import "ZYFadeTransion.h"
#import "ZYBusinessProcessCell.h"
#import "ZYForeclosureHouseController.h"
#import <CYLTableViewPlaceHolder.h>
#import <MJRefresh.h>
#import "ZYBusinessProcessStatueCell.h"
#import "ZYBussinessProcessingStateEditController.h"

@interface ZYBusinessProcessingController ()<ZYFilterBarDelegate,UIViewControllerTransitioningDelegate,UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZYBusinessProcessingController
{
    UIPercentDrivenInteractiveTransition *percentDrivenTransition;
    ZYFadeTransion *transion;
    
    ZYFilterBar *filterBar;
}
ZY_VIEW_MODEL_GET(ZYBusinessProcessingViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    transion = [[ZYFadeTransion alloc] init];
    
    CGFloat barHeight = 40;
    CGFloat navHeight = 64;
    filterBar = [[ZYFilterBar alloc] initWithController:self frame:CGRectMake(0, 64, FUll_SCREEN_WIDTH, barHeight) delegate:self];
    filterBar.dropTableTopMargin = navHeight+barHeight;
    filterBar.showKey = @"product_name";
    [self.view addSubview:filterBar];

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYBusinessProcessCell class]) bundle:nil] forCellReuseIdentifier:[ZYBusinessProcessCell defaultIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYBusinessProcessStatueCell class]) bundle:nil] forCellReuseIdentifier:[ZYBusinessProcessStatueCell defaultIdentifier]];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_footer resetNoMoreData];
        self.viewModel.searchKeywordModel = nil;
        [self.viewModel requestBussinessProcessLoadMore:NO search:NO];
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(self.viewModel.searchKeywordModel)
        {
            [self.viewModel requestBussinessProcessLoadMore:YES search:YES];
        }
        else
        {
            [self.viewModel requestBussinessProcessLoadMore:YES search:NO];
        }
    }];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
    
    [self.viewModel loadCache:[ZYUser user]];
    [self.tableView.mj_header beginRefreshing];
    
    [self.viewModel requestBussinessStateCount:[ZYUser user]];
    [self.viewModel requestProduceListWith:[ZYUser user]];
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
    [[RACObserve(self.viewModel, searchKeywordModel) skip:1] subscribeNext:^(ZYSearchHistoryModel *searchKeywordModel) {
        if(searchKeywordModel)
        {
            [self loading:YES];
            [self.tableView.mj_footer resetNoMoreData];
            [self.viewModel requestBussinessProcessLoadMore:NO search:YES];
        }
    }];
}
- (IBAction)searchButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"search" sender:[self.viewModel businessProcessingSearchHistorySignal]];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        ZYBusinessProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYBusinessProcessCell defaultIdentifier]];
        cell.model = self.viewModel.businessProcessingArr[indexPath.section];
        return cell;
    }
    else
    {
        ZYBusinessProcessStatueCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYBusinessProcessStatueCell defaultIdentifier]];
        cell.model = self.viewModel.businessProcessingArr[indexPath.section];
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.businessProcessingArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0)
    {
        [self performSegueWithIdentifier:@"info" sender:self.viewModel.businessProcessingArr[indexPath.row]];
    }
    else if(indexPath.row==1)
    {
        [self performSegueWithIdentifier:@"edit" sender:self.viewModel.businessProcessingArr[indexPath.row]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return [ZYBusinessProcessCell defaultHeight];
    }
    if(indexPath.row==1)
    {
        return [ZYBusinessProcessStatueCell defaultHeight];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.f;
}
- (UIView*)makePlaceHolderView
{
    ZYPlaceHolderView *view = [[ZYPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, self.tableView.height) type:self.viewModel.tablePlaceHolderType];
    return view;
}
- (BOOL)enableScrollWhenPlaceHolderViewShowing
{
    return YES;
}
#pragma mark - filter代理
- (NSArray*)filterBarTitles:(ZYFilterBar *)bar
{
    return @[@"全部产品",@"全部状态"];
}
- (NSArray*)filterBar:(ZYFilterBar *)bar itemsWithIndex:(NSInteger)index level:(NSInteger)level
{
    if(level==0&&index==0)
    {
        return self.viewModel.businessProcessingProductArr;
    }
    if(level==0&&index==1)
    {
        return self.viewModel.businessProcessingStateShowArr;
    }
    return nil;
}
- (NSInteger)filterBar:(ZYFilterBar *)bar levelCountWithIndex:(NSInteger)index
{
    return 1;
}
- (BOOL)filterBar:(ZYFilterBar *)bar selecedWithIndex:(NSInteger)index level:(NSInteger)level row:(NSInteger)row object:(id)object
{
    if(index==0&&level==0)
    {
        [bar changeTitle:self.viewModel.businessProcessingProductArr[row] atIndex:index];
        if(row==0)
        {
            self.viewModel.businessProcessProductType = nil;
        }
        else
        {
            ZYProductModel *model = object;
            self.viewModel.businessProcessProductType = model;
        }
        [_tableView.mj_header beginRefreshing];
        return NO;
    }
    if(index==1&&level==0)
    {
        [bar changeTitle:self.viewModel.businessProcessingStateArr[row] atIndex:index];
        if(row==0)
        {
            self.viewModel.businessProcessState = nil;
        }
        else
        {
            NSString *model = self.viewModel.businessProcessingStateArr[row];
            self.viewModel.businessProcessState = model;
        }
        [_tableView.mj_header beginRefreshing];
        return NO;
    }
    return YES;
}
- (void)filterBarTitles:(ZYFilterBar *)bar selecedIndex:(NSInteger)selecedIndex
{
    
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"info"])
    {
        ZYForeclosureHouseController *controller = [segue destinationViewController];
        controller.edit = [(ZYBusinessProcessModel*)sender infoEdit];
        controller.projectID = [(ZYBusinessProcessModel*)sender project_id];
    }
    if([segue.identifier isEqualToString:@"edit"])
    {
        ZYBussinessProcessingStateEditController *controller = [segue destinationViewController];
        controller.businessProcessingID = [(ZYBusinessProcessModel*)sender biz_handle_id];
        [controller.editSuccessSignal subscribeNext:^(id x) {
            [self.tableView.mj_header beginRefreshing];
        }];
    }
    if([segue.identifier isEqualToString:@"search"])
    {
        ZYSearchViewController *controller = [segue destinationViewController];
        controller.placeHolder = @"请输入产品名称";
        controller.netSearch = YES;
        RACSignal *signal = sender;
        NSString *key = @"searchKeyword";
        ZYSearchViewModel *viewModel = [ZYSearchViewModel viewModelWithSignal:signal];
        @weakify(self)
        [[RACObserve(viewModel, searchSelecedObj) skip:1] subscribeNext:^(id x) {
            @strongify(self)
            ZYSearchHistoryModel *model = x;
            if(model.searchKeyword.length>0)
            {
                self.viewModel.searchKeywordModel = x;
            }
        }];
        [viewModel.keyboardSearchButtonPressedSignal subscribeNext:^(NSString *keyword) {
            @strongify(self)
            if(keyword.length>0)
            {
                ZYSearchHistoryModel *model = [[ZYSearchHistoryModel alloc] init];
                model.searchKeyword = keyword;
                model.searchDate = [NSDate date];
                self.viewModel.searchKeywordModel = model;
            }
        }];
        [viewModel.cleanButtonPressedSignal subscribeNext:^(id x) {
            @strongify(self)
            [self.viewModel cleanSearchHistory];
        }];
        viewModel.showPropertyKey = key;
        controller.viewModel = viewModel;
        segue.destinationViewController.transitioningDelegate = self;
    }
}
#pragma mark - 转场动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return transion;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return transion;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return percentDrivenTransition;
}
-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return percentDrivenTransition;
}

@end
