//
//  ZYUserCenterViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserCenterViewController.h"
#import "ZYUserCenterUserInfoCell.h"
#import "ZYUserCenterCell.h"
#import "ZYUserCenterLogoutCell.h"

@interface ZYUserCenterViewController ()

//@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYUserCenterViewController
{
    ZYUserCenterUserInfoCell *userInfoCell;
}
ZY_VIEW_MODEL_GET(ZYUserCenterViewModel)
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    userInfoCell.user = [ZYTools checkLogin]?[ZYUser user]:nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarHidden = NO;
    
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    ZYUserCenterViewModel *viewModel = self.viewModel;
    userInfoCell = [ZYUserCenterUserInfoCell cellWithXibHeight:[ZYUserCenterUserInfoCell defaultHeight] actionBlock:^{
        if(![ZYTools checkLogin])
        {
            [self performSegueWithIdentifier:@"login" sender:nil];
        }
        else
        {
            [self performSegueWithIdentifier:@"info" sender:nil];
        }
    }];
    ZYSection *userInfoSection = [ZYSection sectionWithCells:@[userInfoCell]];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYUserCenterCell class]) bundle:nil] forCellReuseIdentifier:[ZYUserCenterCell defaultIdentifier]];
    
    ZYSection *section = [ZYSection sectionSupportingReuseWithTitle:nil cellHeight:[ZYUserCenterCell defaultHeight] cellCount:^NSInteger(UITableView *tableView, NSInteger section) {
        return self.viewModel.dataSource.count;
    } cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        ZYUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYUserCenterCell defaultIdentifier]];
        cell.imageName = [viewModel imageForIndex:row];
        cell.cellTitle = [viewModel contentForIndex:row];
        return cell;
    } actionBlock:^(UITableView *tableView, NSInteger row) {
        if(![ZYTools checkLogin])
        {
            [self performSegueWithIdentifier:@"login" sender:nil];
        }
        if(row==0)
        {
            [self performSegueWithIdentifier:@"myBussiness" sender:nil];
        }
        if(row==1)
        {
            [self performSegueWithIdentifier:@"customer" sender:nil];
        }
        if(row==2)
        {
            [self tip:@"功能建设中" touch:NO];
        }
        if(row==3)
        {
            [self performSegueWithIdentifier:@"feedback" sender:nil];
        }
        if(row==4)
        {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4009393888"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }];
    
    ZYUserCenterLogoutCell *logoutCell = [ZYUserCenterLogoutCell cellWithXibHeight:[ZYUserCenterLogoutCell defaultHeight] actionBlock:nil];
    logoutCell.hidden = ![ZYTools checkLogin];
    [logoutCell setLineHidden:YES];
    [[logoutCell logoutSignal] subscribeNext:^(id x) {
        if(![ZYTools checkLogin])
        {
            [self performSegueWithIdentifier:@"login" sender:nil];
        }
        
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [ZYTools saveKeychain:[ZYTools appVersionToken] data:usernamepasswordKVPairs];//清除账号信息
        [ZYTools clearCache];//清除缓存
        [ZYStore copyDB];//还原数据库
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_NOTIFICATION object:nil];
    }];
    
    ZYSection *logoutSection = [ZYSection sectionWithCells:@[logoutCell]];
    
    self.sections = @[userInfoSection,section,logoutSection];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGIN_NOTIFICATION object:nil] subscribeNext:^(NSNotification *notification) {
        logoutCell.hidden = NO;
        userInfoCell.user = [ZYUser user];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGOUT_NOTIFICATION object:nil] subscribeNext:^(NSNotification *notification) {
        logoutCell.hidden = YES;
        userInfoCell.user = nil;
    }];
    
    self.tableFrame = CGRectMake(0, 64, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT);
}

- (void)blendViewModel
{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGIN_NOTIFICATION object:nil] subscribeNext:^(id x) {
        userInfoCell.user = [ZYUser user];
    }];
    [self.tableView reloadData];
}

@end
