//
//  ZYBankLoanTypeModel.h
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStoreModel.h"

typedef enum : NSUInteger {
    ZYBankLoanTypeBussiness = 0,///商业贷款
    ZYBankLoanTypeAdmixture,///混合贷款
    ZYBankLoanTypePublicFunds,///公积金
    ZYBankLoanTypePaymentInFull///一次付清
} ZYBankLoanType;///贷款方式

@interface ZYBankLoanTypeModel : ZYStoreModel

@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)ZYBankLoanType type;
@property(nonatomic,assign)NSInteger pid;

@end
