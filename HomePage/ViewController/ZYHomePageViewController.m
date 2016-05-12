//
//  ZYHomePageViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/26.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageViewController.h"
#import "ZYHomePageScrollAdCell.h"
#import "ZYHomePageViewModel.h"
#import "ZYHomePageCheckInCell.h"
#import "ZYHomePageFunctionButtonCell.h"
#import "ZYHomePageWarningEventTitleCell.h"
#import "ZYHomePageEventView.h"
#import "ZYTools.h"
#import "ZYNavCenterView.h"
#import "ZYBusinessProcessingController.h"
#import "ZYWebController.h"

@interface ZYHomePageViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYHomePageViewController
{
    /**
     *  顶部广告cell
     */
    ZYHomePageScrollAdCell *scrollAdCell;
    ZYHomePageCheckInCell *checkInCell;
    ZYHomePageFunctionButtonCell *founctionButtonCell;
    ZYHomePageWarningEventTitleCell *eventTitleCell;
    
    ZYHomePageEventView *eventListView;
    
    ZYNavCenterView *navCenterView;
}
ZY_VIEW_MODEL_GET(ZYHomePageViewModel)
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tabBarHidden = NO;
    /**
     *  初始化UI
     */
    [self buildUI];
    /**
     *  绑定数据
     */
    [self blendViewModel];
}
- (UITableView*)tableView
{
    return _myTableView;
}
- (void)buildUI
{
#pragma mark- 广告cell
    navCenterView = [ZYNavCenterView navCenterView];
    self.navigationItem.titleView = navCenterView;
    
    scrollAdCell = [ZYHomePageScrollAdCell cellWithActionBlock:^{
        
    }];
    
    checkInCell = [ZYHomePageCheckInCell cellWithActionBlock:^{
        
    }];
    
    founctionButtonCell = [ZYHomePageFunctionButtonCell cellWithActionBlock:nil];
   
    [founctionButtonCell setLineHidden:YES];
    
    eventTitleCell = [ZYHomePageWarningEventTitleCell cellWithActionBlock:^{
        
    }];
    
    CGSize size = [ZYHomePageEventView defaultSize];
    eventListView = [[ZYHomePageEventView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        
    [self buildCells];
}
- (void)buildCells
{
    ZYHomePageViewModel *viewModel = self.viewModel;
    if(viewModel.eventArr.count>0)
    {
        ZYSection *section = [ZYSection sectionWithCells:@[scrollAdCell,checkInCell,founctionButtonCell,eventTitleCell,eventListView]];
        self.sections = @[section];
    }
    else
    {
        ZYSection *section = [ZYSection sectionWithCells:@[scrollAdCell,checkInCell,founctionButtonCell]];
        self.sections = @[section];
    }
}
- (void)blendViewModel
{
    ZYHomePageViewModel *viewModel = self.viewModel;
    
    [RACObserve(viewModel, navState) subscribeNext:^(NSString *state) {
        navCenterView.statue = state;
    }];
    [RACObserve(viewModel, navLoading) subscribeNext:^(NSNumber *navLoading) {
        navCenterView.loading = navLoading.boolValue;
    }];
    
    //登陆通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGIN_NOTIFICATION object:nil] subscribeNext:^(NSNotification *notification) {
        if([ZYUser user].loginState==ZYUserLoginSuccess)//已经登陆成功 user返回有可能是缓存数据
        {
            viewModel.navLoading = NO;//登录成功
            viewModel.navState = @"首页";
            [ZYStore updateDB];//登录成功后 更新数据库
        }
        [founctionButtonCell reloadFunctionButton:[ZYUser user]];
        [viewModel requestBannerArr:[ZYUser user]];
        [viewModel requestCheckInDays:[ZYUser user]];
        [viewModel requestWarningEvent:[ZYUser user]];
    }];
    
    //登出通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGOUT_NOTIFICATION object:nil] subscribeNext:^(NSNotification *notification) {
        viewModel.needShowLoginController = YES;
    }];
    
//    @weakify(self);
    [RACObserve(viewModel, needShowLoginController) subscribeNext:^(NSNumber *needShowLoginController) {
        if(needShowLoginController.boolValue)
        {
            [self.tabBarController performSegueWithIdentifier:@"login" sender:nil];
        }
        else
        {
            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
            [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                if(manager.reachable&&![ZYTools checkLogin])
                {
                    viewModel.navLoading = YES;//正在登录
                    viewModel.navState = @"登录中...";
                    [ZYUser user].loginState = ZYUserLoging;
                    [viewModel autoLogin];//自动登录
                }
            }];
            [manager startMonitoring];
        }
    }];
    
    
    RAC(scrollAdCell,bannerArr) = RACObserve(viewModel, bannerArr);
    
    [[scrollAdCell.bannerTapSignal map:^id(NSNumber *index) {
        return viewModel.bannerArr[[index longLongValue]];
    }] subscribeNext:^(ZYBannerItem *item) {
        [self performSegueWithIdentifier:@"web" sender:item.adv_url];
    }];
    
    
#pragma mark - 签到
    
    RAC(checkInCell,checkInDays) = RACObserve(viewModel, checkInDays);
    RAC(checkInCell,hasCheckIn) = RACObserve(viewModel, hasCheckIn);
    
    [[RACObserve(viewModel, error) skip:1] subscribeNext:^(NSString *checkInError) {
        [self tip:checkInError touch:NO];
    }];
    [checkInCell.checkInButtonPressedSignal subscribeNext:^(id x) {
        [viewModel requestCheckIn:[ZYUser user]];
    }];
    
#pragma mark - 功能列表
    [founctionButtonCell.functionButtonPressSignal subscribeNext:^(NSNumber *tag) {
        switch (tag.longLongValue) {
            case 0:
                [self performSegueWithIdentifier:@"applyList" sender:nil];
                break;
            case 1:
                [self performSegueWithIdentifier:@"processing" sender:nil];
                break;
            case 2:
                [self performSegueWithIdentifier:@"myBussiness" sender:nil];
                break;
            case 3:
                [self performSegueWithIdentifier:@"customer" sender:nil];
                break;
            default:
                break;
        }
    }];
    
    RAC(eventTitleCell,eventCount) = [RACObserve(viewModel, eventArr) map:^id(NSArray *eventArr) {
        return @(eventArr.count);
    }];
    [RACObserve(eventTitleCell,eventCount) subscribeNext:^(NSNumber *count) {
        [self buildCells];
    }];
    RAC(eventListView,eventArr) = RACObserve(viewModel, eventArr);
    
    [viewModel loadCache];///加载缓存
    [founctionButtonCell reloadFunctionButton:[ZYUser user]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"processing"])
    {
//        ZYBusinessProcessingController *controller = [segue destinationViewController];
    }
    if([segue.identifier isEqualToString:@"myBussiness"])
    {
    }
    if([segue.identifier isEqualToString:@"web"])
    {
        ZYWebController *controller = [segue destinationViewController];
        controller.url = sender;
    }
}


@end
