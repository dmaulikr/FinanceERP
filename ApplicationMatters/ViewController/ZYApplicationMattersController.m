//
//  ZYApplicationMattersController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYApplicationMattersController.h"
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
#import "ZYRefundFeeController.h"

@interface ZYApplicationMattersController ()<ZYFilterBarDelegate,UIViewControllerTransitioningDelegate,UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZYApplicationMattersController
{
    UIPercentDrivenInteractiveTransition *percentDrivenTransition;
    ZYFadeTransion *transion;
    
    ZYFilterBar *filterBar;
}
ZY_VIEW_MODEL_GET(ZYApplicationMattersViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    transion = [[ZYFadeTransion alloc] init];
    
    if(self.type==ZYApplicationMattersTypeRefundCounterFee)
    {
        self.navigationItem.title = @"退手续费";
    }
    if(self.type==ZYApplicationMattersTypeRefundConsultingFee)
    {
        self.navigationItem.title = @"退咨询费";
    }
    if(self.type==ZYApplicationMattersTypeRefundRetainageFee)
    {
        self.navigationItem.title = @"退尾款";
    }
    
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
        [self.viewModel requestApplyLoadMore:NO search:NO];
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(self.viewModel.searchKeywordModel)
        {
            [self.viewModel requestApplyLoadMore:YES search:YES];
        }
        else
        {
            [self.viewModel requestApplyLoadMore:YES search:NO];
        }
    }];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
    
    RACChannelTo(self.viewModel,type) = RACChannelTo(self,type);
    
    [self.viewModel loadCache:[ZYUser user]];
    [self.tableView.mj_header beginRefreshing];
    
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
            [self.viewModel requestApplyLoadMore:NO search:YES];
        }
    }];
}
- (IBAction)searchButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"search" sender:[self.viewModel searchHistorySignal]];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        ZYBusinessProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYBusinessProcessCell defaultIdentifier]];
        cell.model = self.viewModel.applyArr[indexPath.section];
        return cell;
    }
    else
    {
        ZYBusinessProcessStatueCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYBusinessProcessStatueCell defaultIdentifier]];
        cell.model = self.viewModel.applyArr[indexPath.section];
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.applyArr.count;
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
        [self performSegueWithIdentifier:@"info" sender:self.viewModel.applyArr[indexPath.section]];
    }
    else if(indexPath.row==1)
    {
        [self performSegueWithIdentifier:@"edit" sender:self.viewModel.applyArr[indexPath.section]];
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
    return @[@"全部产品",@"未申请"];
}
- (NSArray*)filterBar:(ZYFilterBar *)bar itemsWithIndex:(NSInteger)index level:(NSInteger)level
{
    if(level==0&&index==0)
    {
        return self.viewModel.applyProductArr;
    }
    if(level==0&&index==1)
    {
        return self.viewModel.applyStateArr;
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
        [bar changeTitle:self.viewModel.applyProductArr[row] atIndex:index];
        if(row==0)
        {
            self.viewModel.applyProductType = nil;
        }
        else
        {
            ZYProductModel *model = object;
            self.viewModel.applyProductType = model;
        }
        [_tableView.mj_header beginRefreshing];
        return NO;
    }
    if(index==1&&level==0)
    {
        [bar changeTitle:self.viewModel.applyStateArr[row] atIndex:index];
        if(row==0)
        {
            self.viewModel.applyState = 1;
        }
        else
        {
            self.viewModel.applyState = 2;
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
        controller.edit = NO;
        controller.projectID = [(ZYApplyMattersModel*)sender project_id];
        
    }
    if([segue.identifier isEqualToString:@"edit"])
    {
        ZYRefundFeeController *controller = [segue destinationViewController];
        controller.model = sender;
        controller.type = self.type;
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
