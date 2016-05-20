//
//  ZYUserInfoController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYUserInfoController.h"
#import "ZYUserInfoHeadCell.h"
#import "ZYImageBrowerController.h"

@interface ZYUserInfoController ()

@end

@implementation ZYUserInfoController
{
    ZYUserInfoHeadCell *headImageCell;
}
ZY_VIEW_MODEL_GET(ZYUserInfoViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}
- (void)buildUI
{
    headImageCell = [ZYUserInfoHeadCell cellWithXibHeight:[ZYUserInfoHeadCell defaultHeight] actionBlock:^{
        [self showActionSheet:@[@"相机",@"相册"]];
    }];
    headImageCell.headImageURL = self.viewModel.headImageUrl;
    ZYSection *headSection = [ZYSection sectionWithCells:@[headImageCell]];
    
    ZYSection *section = [ZYSection sectionSupportingReuseWithTitle:nil cellHeight:[ZYTableViewCell defaultHeight] cellCount:^NSInteger(UITableView *tableView, NSInteger section) {
        return self.viewModel.titleArr.count;
    } cellForRowBlock:^UITableViewCell *(UITableView *tableView, NSInteger row) {
        ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ZYTableViewCell defaultIdentifier]];
        if(cell==nil)
        {
            cell = [[ZYTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[ZYTableViewCell defaultIdentifier]];
            cell.textLabel.textColor = TITLE_COLOR;
            cell.textLabel.font = FONT(14);
            cell.detailTextLabel.textColor = TEXT_COLOR;
            cell.detailTextLabel.font = FONT(14);
        }
        cell.textLabel.text = self.viewModel.titleArr[row];
        switch (row) {
            case 0:
                cell.detailTextLabel.text = [ZYUser user].member_id;
                break;
            case 1:
                cell.detailTextLabel.text = [ZYUser user].real_name;
                break;
            case 2:
                cell.detailTextLabel.text = [ZYUser user].phone;
                break;
            case 3:
                cell.detailTextLabel.text = [ZYUser user].org_name;
                break;
            case 4:
                cell.detailTextLabel.text = [ZYUser user].job_title;
                break;
            default:
                break;
        }
        
        return cell;
    } actionBlock:^(UITableView *tableView, NSInteger row) {
        
    }];
    
    self.sections = @[headSection,section];
    
    self.tableFrame = CGRectMake(0, 64, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT);
}
- (void)blendViewModel
{
    [[RACObserve(self, actionSheetRow) skip:1] subscribeNext:^(NSNumber *index) {
        if(index.longLongValue==0)
        {
            [self performSegueWithIdentifier:@"camera" sender:nil];
        }
        if(index.longLongValue==1)
        {
            [self performSegueWithIdentifier:@"imageBrower" sender:nil];
        }
    }];
    
    [[RACObserve(self.viewModel, loading) skip:1] subscribeNext:^(id x) {
        if([x boolValue])
        {
            [self loading:YES];
        }
        else
        {
            [self stop];
        }
    }];
    [[RACObserve(self.viewModel, error) skip:1] subscribeNext:^(id x) {
        [self tip:x touch:NO];
    }];
    [[RACObserve(self.viewModel, headImageUploadSuccess) skip:1] subscribeNext:^(id x) {
        if([x boolValue])
        {
            headImageCell.headImageURL = self.viewModel.headImageUrl;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"camera"])
    {
        ZYCameraController *camera = [segue destinationViewController];
        @weakify(self)
        [camera.imagePickerSignal subscribeNext:^(RACTuple *value) {
            @strongify(self)
            self.viewModel.headImage = value.first;
            self.viewModel.headImageUrl = value.second;
            [self.viewModel uploadHeadImage];
        }];
    }
    if([segue.identifier isEqualToString:@"imageBrower"])
    {
        ZYImageBrowerController *brower = [segue destinationViewController];
        NSArray *imageArr = sender;
        if(imageArr)
        {
            brower.imageArr = imageArr;
        }
        else
        {
            brower.sigleSelected = YES;
            @weakify(self)
            [brower.sigleSelecedSignal subscribeNext:^(RACTuple *value) {
                @strongify(self)
                self.viewModel.headImage = value.first;
                self.viewModel.headImageUrl = value.second;
                [self.viewModel uploadHeadImage];
            }];
        }
    }
}


@end
