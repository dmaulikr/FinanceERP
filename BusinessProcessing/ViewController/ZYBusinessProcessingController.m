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

@interface ZYBusinessProcessingController ()<ZYFilterBarDelegate,UIViewControllerTransitioningDelegate,UISearchBarDelegate>

@end

@implementation ZYBusinessProcessingController
{
    UIPercentDrivenInteractiveTransition *percentDrivenTransition;
    ZYFadeTransion *transion;
    
    ZYTableViewController *tableViewCtl;
    
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
    ZYBusinessProcessingViewModel *viewModel = self.viewModel;
    
    transion = [[ZYFadeTransion alloc] init];
    
    CGFloat barHeight = 40;
    CGFloat navHeight = 64;
    filterBar = [[ZYFilterBar alloc] initWithController:self frame:CGRectMake(0, 64, FUll_SCREEN_WIDTH/2.f, barHeight) delegate:self];
    filterBar.showKey = @"product_name";
    [self.view addSubview:filterBar];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(filterBar.width, 64, FUll_SCREEN_WIDTH/2.f, barHeight)];
    searchBar.delegate = self;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:searchBar];
    
    CGFloat lineWidth = 1/[UIScreen mainScreen].scale;
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    line.frame = CGRectMake(0, navHeight+barHeight-lineWidth, FUll_SCREEN_WIDTH, lineWidth);
    [self.view addSubview:line];

    tableViewCtl = [[ZYTableViewController alloc] init];
    tableViewCtl.networkSupport = YES;
    tableViewCtl.frame = CGRectMake(0, navHeight+barHeight, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-navHeight-barHeight);
    [self.view addSubview:tableViewCtl.view];
    [self addChildViewController:tableViewCtl];
    
    
    [tableViewCtl.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYBusinessProcessCell class]) bundle:nil] forCellReuseIdentifier:[ZYBusinessProcessCell defaultIdentifier]];
    ZYSection *section = [ZYSection sectionSupportingReuseWithTitle:nil cellHeight:[ZYBusinessProcessCell defaultHeight] cellCount:^NSInteger(UITableView *tableView, NSInteger section) {
        return viewModel.businessProcessingArr.count;
    } cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        ZYBusinessProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYBusinessProcessCell defaultIdentifier]];
        cell.model = viewModel.businessProcessingArr[row];
        return cell;
    } actionBlock:^(UITableView *tableView, NSInteger row) {
        
    }];
    tableViewCtl.sections = @[section];
}
- (void)blendViewModel
{
    ZYBusinessProcessingViewModel *viewModel = self.viewModel;
    [RACObserve(viewModel, businessProcessingProductArr) subscribeNext:^(id x) {
        [filterBar reloadDataSource];
    }];
    [viewModel requestProduceListWith:[ZYUser user]];
    
    [[viewModel rac_signalForSelector:@selector(reloadDataSource)] subscribeNext:^(id x) {
        [tableViewCtl reloadDataWithType:viewModel.placeHolderViewType];
    }];
    [RACObserve(viewModel, refreshing) subscribeNext:^(NSNumber *refreshing) {
        if(refreshing.boolValue)
        {
            [tableViewCtl beginRefresh];
        }
        else
        {
            [tableViewCtl stopRefresh];
        }
    }];
    [tableViewCtl.refreshSignal subscribeNext:^(id x) {
        [viewModel requestBussinessProcess:[ZYUser user] loadMore:NO];
    }];
    [tableViewCtl.loadmoreSignal subscribeNext:^(id x) {
        [viewModel requestBussinessProcess:[ZYUser user] loadMore:YES];
    }];
    RACChannelTo(viewModel,isMyBussiness) = RACChannelTo(self,isMyBussiness);
    
    [viewModel loadCache:[ZYUser user]];
}
#pragma mark - searchBar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self performSegueWithIdentifier:@"search" sender:[self.viewModel businessProcessingSearchHistorySignal]];
    return NO;
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
        return self.viewModel.businessProcessingStateArr;
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
        return NO;
    }
    if(index==1&&level==0)
    {
        [bar changeTitle:self.viewModel.businessProcessingStateArr[row] atIndex:index];
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
    if([segue.identifier isEqualToString:@"search"])
    {
        ZYSearchViewController *controller = [segue destinationViewController];
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
