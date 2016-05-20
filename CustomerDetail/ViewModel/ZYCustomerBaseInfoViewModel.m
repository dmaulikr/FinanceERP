//
//  ZYCustomerBaseInfoViewModel.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCustomerBaseInfoViewModel.h"
#import "ZYCustomerInfoRequest.h"

@implementation ZYCustomerBaseInfoViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headImageUploadSuccess = YES;
    }
    return self;
}
- (void)requestCustomerInfo
{
    ZYCustomerInfoRequest *request = [ZYCustomerInfoRequest request];
    request.user_id = [ZYUser user].pid;
    request.customer_id = self.customerID;
    self.loading = YES;
    [[[ZYRoute route] customerInfo:request] subscribeNext:^(ZYCustomerModel *model) {
        model.pid = self.customerID;//列表与内部详情id字段不一样
        self.headImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOST,model.file_url]];
        self.customerName = model.customer_name;
        self.customerCardNum = model.card_no;
        self.customerTelephone = model.phone_num;
        self.customerAddress = model.comm_address;
        
        self.customer = model;
        self.loading = NO;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
    } completed:^{
        
    }];
}
- (void)requestEditCustomer
{
    ZYCustomerBaseInfoEditRequest *request = [ZYCustomerBaseInfoEditRequest request];
    request.customer_id = self.customerID;
    request.comm_address = self.customerAddress;
    request.file_id = self.fileID;
    request.user_id = [ZYUser user].pid;
    request.phone_num = self.customerTelephone;
    request.customer_id = self.customerID;
    request.card_no = self.customerCardNum;
    request.customer_name = self.customerName;
    self.loading = YES;
    self.editSuccess = NO;
    [[[ZYRoute route] customerBaseInfoEdit:request] subscribeNext:^(RACTuple *value) {
        if(self.add)
        {
            self.customer = [[ZYCustomerModel alloc] init];
            self.customer.customer_id = [value.second longLongValue];
            self.customer.pid = [value.second longLongValue];
            self.customerID = self.customer.customer_id;
        }
        self.editSuccess = YES;
        self.loading = NO;
    } error:^(NSError *error) {
        self.loading = NO;
        self.error = error.domain;
    } completed:^{
        
    }];
}
- (void)uploadHeadImage
{
    ZYUploadFileRequest *request = [[ZYUploadFileRequest alloc] init];
    request.image = self.headImage;
    request.userId = [ZYUser user].pid;
    request.imageUrl = self.headImageUrl;
    self.headImageUploadSuccess = NO;
    [[[ZYRoute route] uploadFile:request] subscribeNext:^(NSNumber *fileID) {
        self.fileID = fileID.longLongValue;
        self.headImageUrl = self.headImageUrl;
        self.headImageUploadSuccess = YES;
        self.loading = NO;
    } error:^(NSError *error) {
        self.headImageUploadSuccess = NO;
        self.loading = NO;
        self.error = @"头像上传失败，请重试";
    } completed:^{
        
    }];
}
@end
