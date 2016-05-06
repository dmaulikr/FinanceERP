//
//  ZYStore.m
//  FinanceERP
//
//  Created by zhangyu on 16/5/5.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYStore.h"
#import "ZYBankModel.h"
#import "ZYForeclosureHouseViewModel.h"
#import "ZYPaperModel.h"

@implementation ZYStore

+ (void)copyDBWhenNotExit
{
    NSFileManager*fileManager =[NSFileManager defaultManager];
    NSError*error;
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    
    NSString*dbPath =[documentsDirectory stringByAppendingPathComponent:@"db"];
    NSString*path =[documentsDirectory stringByAppendingPathComponent:@"db/LKDB.db"];
    
    if([fileManager fileExistsAtPath:path]== NO){
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dbPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(success)
        {
            NSString*resourcePath =[[NSBundle mainBundle] pathForResource:@"LKDB" ofType:@"db"];
            if(![fileManager copyItemAtPath:resourcePath toPath:path error:&error])
            {
                NSLog(@"数据库复制失败%@",error);
            }
        }
    }
}
+ (void)copyDB
{
    NSFileManager*fileManager =[NSFileManager defaultManager];
    NSError*error;
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];
    
    NSString*path =[documentsDirectory stringByAppendingPathComponent:@"db/LKDB.db"];
    NSString*dbPath =[documentsDirectory stringByAppendingPathComponent:@"db"];
    
    if([fileManager fileExistsAtPath:path]== YES){
        [fileManager removeItemAtPath:path error:&error];
    }
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dbPath withIntermediateDirectories:YES attributes:nil error:&error];
    if(success)
    {
        NSString*resourcePath =[[NSBundle mainBundle] pathForResource:@"LKDB" ofType:@"db"];
        if(![fileManager copyItemAtPath:resourcePath toPath:path error:&error])
        {
            NSLog(@"数据库复制失败%@",error);
        }
    }
}
+ (void)updateDB
{
    ZYBanksRequest *request = [ZYBanksRequest request];
    request.user_id = [ZYUser user].pid;
    [[[ZYRoute route] banks:request] subscribeNext:^(NSArray *banks) {
        if(banks.count>0)
        {
            if(![[ZYBankModel getUsingLKDBHelper] getTableCreatedWithClass:[ZYBankModel class]])
            {
                NSLog(@"创建表失败");
                return;
            }
            /**
             *  清空表数据
             */
            [[ZYBankModel getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper *helper) {
                if(![[ZYBankModel getUsingLKDBHelper] deleteWithClass:[ZYBankModel class] where:nil])
                {
                    return NO;//删除失败回滚
                }
                NSInteger i = 1;
                for(ZYBankModel *model in banks)
                {
                    model.rowid = i;
                    if(![[ZYBankModel getUsingLKDBHelper] insertWhenNotExists:model])
                    {
                        return NO;
                    }
                    i++;
                }
                return YES;
            }];
        }
        
    }];
}
- (void)creatData
{
    [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] dropAllTable];
    for(int i=0;i<5;i++)
    {
        ZYForeclosureHouseComeFromTypeModel *model = [[ZYForeclosureHouseComeFromTypeModel alloc] init];
        model.title = [self foreclosureHouseBussinessInfoComeFromArr][i];
        model.type = i;
        model.pid = [self comeTypeIDFromViewModel:model.type];
        [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    for(int i=0;i<2;i++)
    {
        ZYForeclosureHouseOrderTypeModel *model = [[ZYForeclosureHouseOrderTypeModel alloc] init];
        model.title = [self foreclosureHouseBussinessInfoOrderArr][i];
        model.type = i;
        model.pid = [self orderTypeIDFromViewModel:model.type];
        [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    for(int i=0;i<2;i++)
    {
        ZYForeclosureHouseTransactionTypeModel *model = [[ZYForeclosureHouseTransactionTypeModel alloc] init];
        model.title = [self foreclosureHouseBussinessInfoTransactionArr][i];
        model.type = i;
        model.pid = [self transactionTypeIDFromViewModel:model.type];
        [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    for(int i=0;i<2;i++)
    {
        ZYCostInfoChargeTypeModel *model = [[ZYCostInfoChargeTypeModel alloc] init];
        model.title = [self costInfoChargeTypeArr][i];
        model.type = i;
        model.pid = [self chargeTypeIDFromViewModel:model.type];
        [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    for(int i=0;i<4;i++)
    {
        ZYBankLoanTypeModel *model = [[ZYBankLoanTypeModel alloc] init];
        model.title = [self loanTypeArr][i];
        model.type = i;
        model.pid = [self paymentTypeIDFromViewModel:model.type];
        [[ZYForeclosureHouseComeFromTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    for(NSString *title in @[@"公正委托书",@"业务及借款人身份证",@"供楼卡",@"存折",@"担保服务协议",@"原借款/抵押合同",@"供楼清单",@"提前还款申请/回执",@"资金监管协方、到账凭证",@"承诺书/介绍函",@"房产证"])
    {
        ZYPaperModel *model = [[ZYPaperModel alloc] init];
        model.orderInfoPaperTitle = title;
        if(![[ZYPaperModel getUsingLKDBHelper] insertWhenNotExists:model])
        {
            NSLog(@"插入失败");
        }
    }
    
    
    LKDBHelper *helper = [ZYBankModel getUsingLKDBHelper];
    
    
    if(![helper getTableCreatedWithClass:[ZYCooperativeOrganizationModel class]])
    {
        NSLog(@"创建表失败");
    }
    
    ZYCooperativeOrganizationModel *cooper;
    cooper = [[ZYCooperativeOrganizationModel alloc] init];
    cooper.look_desc = @"随手记";
    cooper.pid = 13783;
    
    [helper insertWhenNotExists:cooper];
    
    cooper = [[ZYCooperativeOrganizationModel alloc] init];
    cooper.look_desc = @"小赢";
    cooper.pid = 13784;
    
    [helper insertWhenNotExists:cooper];
    
    cooper = [[ZYCooperativeOrganizationModel alloc] init];
    cooper.look_desc = @"融安";
    cooper.pid = 13785;
    
    [helper insertWhenNotExists:cooper];
    
    cooper = [[ZYCooperativeOrganizationModel alloc] init];
    cooper.look_desc = @"亚桐";
    cooper.pid = 13786;
    
    [helper insertWhenNotExists:cooper];
    
    cooper = [[ZYCooperativeOrganizationModel alloc] init];
    cooper.look_desc = @"中鼎在线";
    cooper.pid = 13787;
    
    [helper insertWhenNotExists:cooper];
    
    cooper = [[ZYCooperativeOrganizationModel alloc] init];
    cooper.look_desc = @"资安";
    cooper.pid = 13866;
    
    [helper insertWhenNotExists:cooper];
    
    if(![helper getTableCreatedWithClass:[ZYIntermediaryModel class]])
    {
        NSLog(@"创建表失败");
    }
    
    ZYIntermediaryModel *inter;
    inter = [[ZYIntermediaryModel alloc] init];
    inter.look_desc = @"中原地产";
    inter.pid = 13772;
    
    [helper insertWhenNotExists:inter];
    
    inter = [[ZYIntermediaryModel alloc] init];
    inter.look_desc = @"Q房网";
    inter.pid = 13774;
    
    [helper insertWhenNotExists:inter];
    
    inter = [[ZYIntermediaryModel alloc] init];
    inter.look_desc = @"链家";
    inter.pid = 13774;
    
    [helper insertWhenNotExists:inter];
    
    inter = [[ZYIntermediaryModel alloc] init];
    inter.look_desc = @"新峰地产";
    inter.pid = 13775;
    
    [helper insertWhenNotExists:inter];
    
    inter = [[ZYIntermediaryModel alloc] init];
    inter.look_desc = @"中天置业";
    inter.pid = 13776;
    
    [helper insertWhenNotExists:inter];
    
    inter = [[ZYIntermediaryModel alloc] init];
    inter.look_desc = @"我爱我家";
    inter.pid = 13777;
    
    [helper insertWhenNotExists:inter];
    
    inter = [[ZYIntermediaryModel alloc] init];
    inter.look_desc = @"家家顺";
    inter.pid = 13778;
    
    [helper insertWhenNotExists:inter];
}
- (NSArray*)foreclosureHouseBussinessInfoComeFromArr
{
    return @[@"银行",@"中介",@"朋友",@"合作机构",@"其他"];
}
- (NSArray*)foreclosureHouseBussinessInfoOrderArr
{
    return  @[@"内单",@"外单"];
}
- (NSArray*)foreclosureHouseBussinessInfoTransactionArr
{
    return @[@"交易",@"非交易"];
}
- (NSArray*)costInfoChargeTypeArr
{
    return @[@"贷前收费",@"贷后收费"];
}
- (NSArray*)loanTypeArr
{
    return @[@"商业贷款",@"混合贷款",@"公积金贷款",@"一次付清"];
}
- (NSInteger)comeTypeIDFromViewModel:(ZYForeclosureHouseBussinessInfoComeFromType)type
{
    switch (type) {
        case ZYForeclosureHouseBussinessInfoComeFromBank:
            return 13779;
            break;
        case ZYForeclosureHouseBussinessInfoComeFromIntermediary:
            return 13780;
            break;
        case ZYForeclosureHouseBussinessInfoComeFromFriend:
            return 13781;
            break;
        case ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization:
            return 13782;
            break;
        case ZYForeclosureHouseBussinessInfoComeFromOther:
            return 13859;
            break;
        default:
            return 13779;
            break;
    }
}
- (ZYForeclosureHouseBussinessInfoComeFromType)comeTypeTypeFromID:(NSInteger)ID
{
    switch (ID) {
        case 13779:
            return ZYForeclosureHouseBussinessInfoComeFromBank;
            break;
        case 13780:
            return ZYForeclosureHouseBussinessInfoComeFromIntermediary;
            break;
        case 13781:
            return ZYForeclosureHouseBussinessInfoComeFromFriend;
            break;
        case 13782:
            return ZYForeclosureHouseBussinessInfoComeFromCooperativeOrganization;
            break;
        case 13859:
            return ZYForeclosureHouseBussinessInfoComeFromOther;
            break;
        default:
            return ZYForeclosureHouseBussinessInfoComeFromBank;
            break;
    }
}
- (NSInteger)orderTypeIDFromViewModel:(ZYForeclosureHouseBussinessInfoOrderType)type
{
    switch (type) {
        case ZYForeclosureHouseBussinessInfoOrderInside:
            return 1;
            break;
        case ZYForeclosureHouseBussinessInfoOrderOutside:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}
- (ZYForeclosureHouseBussinessInfoOrderType)orderTypeTypeFromID:(NSInteger)ID
{
    switch (ID) {
        case 1:
            return ZYForeclosureHouseBussinessInfoOrderInside;
            break;
        case 2:
            return ZYForeclosureHouseBussinessInfoOrderOutside;
            break;
        default:
            return ZYForeclosureHouseBussinessInfoOrderInside;
            break;
    }
}

- (NSInteger)transactionTypeIDFromViewModel:(ZYForeclosureHouseBussinessInfoTransactionType)type
{
    switch (type) {
        case ZYForeclosureHouseBussinessInfoTransaction:
            return 13755;
            break;
        case ZYForeclosureHouseBussinessInfoIsNotTransaction:
            return 13756;
            break;
        default:
            return 13755;
            break;
    }
}
- (ZYForeclosureHouseBussinessInfoTransactionType)transactionTypeTypeFromID:(NSInteger)ID
{
    switch (ID) {
        case 13755:
            return ZYForeclosureHouseBussinessInfoTransaction;
            break;
        case 13756:
            return ZYForeclosureHouseBussinessInfoIsNotTransaction;
            break;
        default:
            return ZYForeclosureHouseBussinessInfoTransaction;
            break;
    }
}

- (NSInteger)paymentTypeIDFromViewModel:(ZYBankLoanType)type
{
    switch (type) {
        case ZYBankLoanTypeBussiness:
            return 1;
            break;
        case ZYBankLoanTypeAdmixture:
            return 2;
            break;
        case ZYBankLoanTypePublicFunds:
            return 3;
            break;
        case ZYBankLoanTypePaymentInFull:
            return 4;
            break;
        default:
            return 1;
            break;
    }
}
- (ZYBankLoanType)paymentTypeTypeFromID:(NSInteger)ID
{
    switch (ID) {
        case 1:
            return ZYBankLoanTypeBussiness;
            break;
        case 2:
            return ZYBankLoanTypeAdmixture;
            break;
        case 3:
            return ZYBankLoanTypePublicFunds;
            break;
        case 4:
            return ZYBankLoanTypePaymentInFull;
            break;
        default:
            return ZYBankLoanTypeBussiness;
            break;
    }
}

- (NSInteger)chargeTypeIDFromViewModel:(ZYCostInfoChargeType)type
{
    switch (type) {
        case ZYCostInfoChargeTypeBeforeLoan:
            return 1;
            break;
        case ZYCostInfoChargeTypeAfterLoan:
            return 2;
            break;
        default:
            return 1;
            break;
    }
}
- (ZYCostInfoChargeType)chargeTypeTypeFromID:(NSInteger)ID
{
    switch (ID) {
        case 1:
            return ZYCostInfoChargeTypeBeforeLoan;
            break;
        case 2:
            return ZYCostInfoChargeTypeAfterLoan;
            break;
        default:
            return ZYCostInfoChargeTypeBeforeLoan;
            break;
    }
}

@end
