//
//  ZYSearchViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/11.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSearchViewController.h"
#import "ZYTableViewCell.h"
#import "ZYBankModel.h"
#import "ZYSearchCleanCell.h"
#import <CYLTableViewPlaceHolder.h>

@interface ZYSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CYLTableViewPlaceHolderDelegate>

@property(nonatomic,weak)IBOutlet UITableView *tableView;
@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;


@end

@implementation ZYSearchViewController
{
    CGFloat offY;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchBar.placeholder = self.placeHolder;
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    if(_netSearch)
    {
       [_searchBar becomeFirstResponder];
    }
    [self searchBar:_searchBar textDidChange:_searchBar.text];
    if(_netSearch)
    {
        ZYSearchCleanCell *cell = [[ZYSearchCleanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell.cleanButtonPressedSignal subscribeNext:^(id x) {
            [self.viewModel cleanButtonPressed];
            self.viewModel.dataSourceArr = nil;
            [self.tableView reloadData];
        }];
        self.tableView.tableFooterView = cell;
    }
}
- (void)blendViewModel
{
    ZYSearchViewModel *viewModel = self.viewModel;
    RACChannelTo(viewModel,searchText) = RACChannelTo(_searchBar,text);
    [RACObserve(viewModel, loading) subscribeNext:^(NSNumber *loading) {
        if(loading.boolValue)
        {
            [self loading];
        }
        else
        {
            [self stop];
        }
        [self.tableView reloadData];
    }];
}
- (IBAction)cancelButtonPressed:(id)sender {
    [_searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(ABS(scrollView.contentOffset.y-self.tableView.contentOffset.y)>60)
    {
        [self.searchBar resignFirstResponder];
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    offY = self.tableView.contentOffset.y;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(_netSearch)
    {
        [self.viewModel keyboardSearchButtonPressed:searchBar.text];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(_netSearch)
    {
        [[self.viewModel searchSignal] subscribeNext:^(id x) {
            self.viewModel.dataSourceArr = x;
            if(self.netSearch)
            {
                [self.tableView reloadData];
            }
            else
            {
                [self.tableView cyl_reloadData];
            }
            
        }];
    }
    else
    {
        [[self.viewModel searchWithText:searchText] subscribeNext:^(id x) {
            if(self.netSearch)
            {
                [self.tableView reloadData];
            }
            else
            {
                [self.tableView cyl_reloadData];
            }
        }];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYTableViewCell defaultIdentifier]];
    if(cell==nil)
    {
        cell = [[ZYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ZYTableViewCell defaultIdentifier]];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    if(_netSearch)
    {
        cell.textLabel.text = [self.viewModel.dataSourceArr[indexPath.row] valueForKey:self.viewModel.showPropertyKey];
    }
    else
    {
        NSString *initial = self.viewModel.initialArr[indexPath.section];
        NSArray *subArr = self.viewModel.filterDict[initial];
        cell.textLabel.text = [subArr[indexPath.row] valueForKey:self.viewModel.showPropertyKey];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_netSearch)
    {
        return self.viewModel.dataSourceArr.count;
    }
    else
    {
        NSString *initial = self.viewModel.initialArr[section];
        NSArray *subArr = self.viewModel.filterDict[initial];
        return subArr.count;
    }
    
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(_netSearch)
    {
        return nil;
    }
    else
    {
        return self.viewModel.initialArr[section];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_netSearch)
    {
        return 1;
    }
    else
    {
        return self.viewModel.initialArr.count;
    }
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(_netSearch)
    {
        return nil;
    }
    else
    {
        return self.viewModel.initialArr;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    if(_netSearch)
    {
        self.viewModel.searchSelecedObj = self.viewModel.dataSourceArr[indexPath.row];
    }
    else
    {
        NSString *initial = self.viewModel.initialArr[indexPath.section];
        NSArray *subArr = self.viewModel.filterDict[initial];
        self.viewModel.searchSelecedObj = subArr[indexPath.row];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (UIView*)makePlaceHolderView
{
    ZYPlaceHolderView *view = [[ZYPlaceHolderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, self.tableView.height) type:self.viewModel.tablePlaceHolderType];
    return view;
}

@end
