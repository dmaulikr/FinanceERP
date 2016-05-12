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

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ZYUserCenterViewController
{
    ZYUserCenterUserInfoCell *userInfoCell;
}
ZY_VIEW_MODEL_GET(ZYUserCenterViewModel)
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
            [self tip:@"登陆中,请稍后" touch:NO];
            return;
        }
        
    }];
    ZYSection *userInfoSection = [ZYSection sectionWithCells:@[userInfoCell]];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYUserCenterCell class]) bundle:nil] forCellReuseIdentifier:[ZYUserCenterCell defaultIdentifier]];
    
    ZYSection *section = [ZYSection sectionSupportingReuseWithTitle:nil cellHeight:[ZYUserCenterCell defaultHeight] cellCount:^NSInteger(UITableView *tableView, NSInteger section) {
        return 6;
    } cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        ZYUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYUserCenterCell defaultIdentifier]];
        cell.imageName = [viewModel imageForIndex:row];
        cell.cellTitle = [viewModel contentForIndex:row];
        return cell;
    } actionBlock:^(UITableView *tableView, NSInteger row) {
        if(![ZYTools checkLogin])
        {
            [self tip:@"登陆中,请稍后" touch:NO];
            return;
        }
    }];
    
    ZYUserCenterLogoutCell *logoutCell = [ZYUserCenterLogoutCell cellWithXibHeight:[ZYUserCenterLogoutCell defaultHeight] actionBlock:nil];
    [logoutCell setLineHidden:YES];
    [[logoutCell logoutSignal] subscribeNext:^(id x) {
        if(![ZYTools checkLogin])
        {
            [self tip:@"登陆中,请稍后" touch:NO];
            return;
        }
        
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [ZYTools saveKeychain:[ZYTools appVersionToken] data:usernamepasswordKVPairs];//清除账号信息
        [ZYTools clearCache];//清除缓存
        [ZYStore copyDB];//还原数据库
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_NOTIFICATION object:nil];
    }];
    
    ZYSection *logoutSection = [ZYSection sectionWithCells:@[logoutCell]];
    
    self.sections = @[userInfoSection,section,logoutSection];
}

- (void)blendViewModel
{
//    ZYUserCenterViewModel *viewModel = self.viewModel;
    userInfoCell.user = [ZYUser user];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LOGIN_NOTIFICATION object:nil] subscribeNext:^(id x) {
        userInfoCell.user = [ZYUser user];
    }];
    [self.myTableView reloadData];
}

- (UITableView*)tableView
{
    return _myTableView;
}
@end
