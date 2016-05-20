//
//  ZYCustomerBaseInfoController.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/13.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerBaseInfoController.h"
#import "ZYCustomerBaseInfoSections.h"
#import "ZYTableViewController.h"
#import <MWPhotoBrowser.h>
#import "ZYImageBrowerController.h"
#import "ZYCustomerDetailViewController.h"

@interface ZYCustomerBaseInfoController ()

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation ZYCustomerBaseInfoController
{
    ZYTableViewController *tableViewCtl;
    ZYCustomerBaseInfoSections *sections;
}
ZY_VIEW_MODEL_GET(ZYCustomerBaseInfoViewModel)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    [self blendViewModel];
}

- (void)buildUI
{
    tableViewCtl = [[ZYTableViewController alloc] init];
    tableViewCtl.frame = CGRectMake(0, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-64);
    [self.view addSubview:tableViewCtl.view];
    [self addChildViewController:tableViewCtl];
    
    sections = [[ZYCustomerBaseInfoSections alloc] initWithTitle:@"基本信息"];
    [sections blendModel:self.viewModel];
    
}
- (void)blendViewModel
{
    //是否加载成功
    [RACObserve(self.viewModel,customer) subscribeNext:^(ZYCustomerModel *customer) {
        self.editButton.hidden = (customer == nil);//加载失败 不能编辑
    }];
    
    RACChannelTo(self.viewModel,customerID) = RACChannelTo(self,customerID);
    
    //加载中
    [[RACObserve(self.viewModel, loading) skip:1] subscribeNext:^(NSNumber *loading) {
        if(loading.boolValue)
        {
            [self loading:YES];
        }
        else
        {
            [self stop];
        }
    }];
    //错误提示
    [[RACObserve(self.viewModel, error) skip:1] subscribeNext:^(NSString *error) {
        [self tip:error touch:NO];
    }];
    
    //编辑
    RACChannelTo(sections,edit) = RACChannelTo(self, edit);
    [RACObserve(self, edit) subscribeNext:^(NSNumber *edit) {
        if(edit.boolValue)
        {
            [sections becomeFirstResponder];
        }
        else
        {
            [self.view endEditing:YES];
        }
    }];
    //编辑信息
    [[RACObserve(self.viewModel, editSuccess) skip:1] subscribeNext:^(NSNumber *editSuccess) {
        if(editSuccess.boolValue)
        {
            if(self.viewModel.add)
            {
                [self performSegueWithIdentifier:@"detail" sender:nil];
                self.viewModel.add = NO;
            }
            else
            {
                [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
                self.edit = !_edit;
                [self hasEdit:self.viewModel.customer];
            }
        }
    }];
    [sections.returnSignal subscribeNext:^(id x) {
        [self editButtonPressed:self.editButton];
    }];
    
    
    [sections.headImagePickSignal subscribeNext:^(NSArray *imageArr) {
        [self.view endEditing:YES];
        if(self.edit)
        {
            [self showActionSheet:@[@"相机",@"相册"]];
        }
        else
        {
            [self performSegueWithIdentifier:@"imageBrower" sender:imageArr];
        }
    }];
    
    [sections.detailCellPressedSignal subscribeNext:^(id x) {
       [self performSegueWithIdentifier:@"detail" sender:nil];
    }];
    
    [sections.nextStepSignal subscribeNext:^(RACTuple *value) {
        NSString *error = value.first;
        if(error)
        {
            [self tip:error touch:NO];
        }
        else
        {
            //添加
            [self.viewModel requestEditCustomer];
        }
    }];

    
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
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            [self.editButton setTitle:@"完成" forState:UIControlStateNormal];
        }
    }];
    
    
    if(self.customerID!=0)
    {
        [self.viewModel requestCustomerInfo];
    }
    else
    {
        self.viewModel.add = YES;
        
    }
    //根据是否是添加 动态变换
    [RACObserve(self.viewModel, add) subscribeNext:^(id x) {//根据是否是添加  重新加载页面
        tableViewCtl.sections = sections.sections;
        if(self.viewModel.add)
        {
            self.edit = YES;
            self.editButton.hidden = YES;
        }
        else
        {
            self.edit = NO;
            self.editButton.hidden = NO;
        }
    }];
    
    
}
- (IBAction)editButtonPressed:(id)sender {
    
    if(!_edit)///编辑
    {
        self.edit = !_edit;
    }
    else
    {
        if(sections.error)
        {
            [self tip:sections.error touch:NO];
            return;
        }
        [self.viewModel requestEditCustomer];
    }
    
}
- (RACSignal*)hasEditSignal
{
    if(_hasEditSignal==nil)
    {
        _hasEditSignal = [self rac_signalForSelector:@selector(hasEdit:)];
    }
    return [_hasEditSignal map:^id(RACTuple *value) {
        return value.first;
    }];
}
- (void)hasEdit:(ZYCustomerModel*)model{}
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
    if([segue.identifier isEqualToString:@"detail"])
    {
        ZYCustomerDetailViewController *detail = [segue destinationViewController];
//        RACChannelTo(detail,edit) = RACChannelTo(self,edit);
        detail.edit = self.edit;
        detail.customer = self.viewModel.customer;
    }
}


@end
