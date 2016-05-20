//
//  ZYCustomerBaseInfoViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/16.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"
#import "ZYCustomerModel.h"

@interface ZYCustomerBaseInfoViewModel : ZYViewModel

@property(nonatomic,assign)NSInteger customerID;

- (void)requestCustomerInfo;

@property(nonatomic,strong)ZYCustomerModel *customer;

@property(nonatomic,assign)BOOL loading;

@property(nonatomic,strong)NSString *error;

/**
 *  页面显示信息 从对象中抽离 便于单个页面编辑提交数据
 */
@property(nonatomic,strong)NSString *customerName;
@property(nonatomic,strong)NSString *customerCardNum;
@property(nonatomic,strong)NSString *customerTelephone;
@property(nonatomic,strong)NSString *customerAddress;
/**
 *  编辑成功
 */
@property(nonatomic,assign)BOOL editSuccess;

- (void)requestEditCustomer;

/**
 *  头像上传
 */
@property(nonatomic,assign)NSInteger fileID;

@property(nonatomic,strong)UIImage *headImage;

@property(nonatomic,strong)NSURL *headImageUrl;

@property(nonatomic,assign)BOOL headImageUploadSuccess;

- (void)uploadHeadImage;

//添加一个客户
@property(nonatomic,assign)BOOL add;

@end
