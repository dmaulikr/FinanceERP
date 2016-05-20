//
//  ZYFeedbackViewViewModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYViewModel.h"


@interface ZYFeedbackViewViewModel : ZYViewModel

@property(nonatomic,strong)NSString *feedbackText;
- (void)feedbackRequest;

@property(nonatomic,assign)BOOL loading;
@property(nonatomic,strong)NSString *error;

@property(nonatomic,assign)BOOL feedbackSuccess;

@end
