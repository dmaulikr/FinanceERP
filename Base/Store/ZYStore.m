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
#import "ZYCustomerDetailViewModel.h"

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
            /**
             *  清空表数据
             */
            [[ZYBankModel getUsingLKDBHelper] executeForTransaction:^BOOL(LKDBHelper *helper) {
                if([[ZYBankModel getUsingLKDBHelper] isExistsClass:[ZYBankModel class] where:nil])
                {
                    if(![[ZYBankModel getUsingLKDBHelper] deleteWithClass:[ZYBankModel class] where:nil])
                    {
                        return NO;//删除失败回滚
                    }
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

    NSArray *cooperLookDesc = @[@"随手记",@"小赢",@"融安",@"亚桐",@"中鼎在线",@"资安"];
    NSArray *pid = @[@(13783),@(13784),@(13785),@(13786),@(13787),@(13866),];
    for(int i=0;i<cooperLookDesc.count;i++)
    {
        ZYCooperativeOrganizationModel *cooper = [[ZYCooperativeOrganizationModel alloc] init];
        cooper.look_desc = cooperLookDesc[i];
        cooper.pid = [pid[i] longLongValue];
        cooper.num = i;
        [[ZYCooperativeOrganizationModel getUsingLKDBHelper] insertWhenNotExists:cooper];
    }
    
    NSArray *interLookDesc = @[@"中原地产",@"Q房网",@"链家",@"新峰地产",@"中天置业",@"中天置业",@"我爱我家"
                               ,@"家家顺"];
    NSArray *interpid = @[@(13772),
                          @(13774),
                          @(13774),
                          @(13775),
                          @(13776),
                          @(13777),
                          @(13778),];
    for(int i=0;i<cooperLookDesc.count;i++)
    {
        ZYIntermediaryModel *inter = [[ZYIntermediaryModel alloc] init];
        inter.look_desc = interLookDesc[i];
        inter.pid = [interpid[i] longLongValue];
        inter.num = i;
        [[ZYIntermediaryModel getUsingLKDBHelper] insertWhenNotExists:inter];
    }
    
    NSArray *educatDesc = @[@"小学",@"初中",@"高中",@"大专",@"本科",@"研究生",@"博士研究生"
                               ,@"博士后研究生"];
    NSArray *educatpid = @[@(13161),
                          @(13162),
                          @(13163),
                          @(13164),
                          @(13165),
                          @(13166),
                          @(13167),
                          @(13168),];
    for(int i=0;i<educatDesc.count;i++)
    {
        ZYEducationModel *model = [[ZYEducationModel alloc] init];
        model.name = educatDesc[i];
        model.pid = [educatpid[i] longLongValue];
        model.num = i;
        [[ZYEducationModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    
    NSArray *titleDesc = @[@"正高级",@"副高级",@"中级",@"助理级",@"技术员",@"其他"];
    NSArray *titlepid = @[@(13185),
                           @(13186),
                           @(13187),
                           @(13188),
                           @(13189),
                           @(13110),];
    for(int i=0;i<titleDesc.count;i++)
    {
        ZYWorkTitleModel *model = [[ZYWorkTitleModel alloc] init];
        model.name = titleDesc[i];
        model.pid = [titlepid[i] longLongValue];
        model.num = i;
        [[ZYWorkTitleModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *incomeTypeDesc = @[@"工资卡",@"现金",@"红包",@"保险",@"实物",@"其他"];
    NSArray *incomeTypepid = @[@(13201),
                          @(13202),
                          @(13203),
                          @(13204),
                          @(13205),
                          @(13206),];
    for(int i=0;i<incomeTypeDesc.count;i++)
    {
        ZYIncomeTypeModel *model = [[ZYIncomeTypeModel alloc] init];
        model.name = incomeTypeDesc[i];
        model.pid = [incomeTypepid[i] longLongValue];
        model.num = i;
        [[ZYIncomeTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *sucialPayTypeDesc = @[@"是",@"否"];
    NSArray *sucialPayTypepid = @[@(1),
                               @(2),];
    for(int i=0;i<sucialPayTypeDesc.count;i++)
    {
        ZYSocialSecurityPayStatuModel *model = [[ZYSocialSecurityPayStatuModel alloc] init];
        model.name = sucialPayTypeDesc[i];
        model.pid = [sucialPayTypepid[i] longLongValue];
        model.num = i;
        [[ZYSocialSecurityPayStatuModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *accountTypeDesc = @[@"个人结算账户",@"储蓄账户",@"个人支票帐户",@"信用卡账户",@"其他"];
    NSArray *accountTypepid = @[@(13221),
                                @(13222),
                                @(13223),
                                @(13224),
                                @(13225),];
    for(int i=0;i<accountTypeDesc.count;i++)
    {
        ZYAccountTypeModel *model = [[ZYAccountTypeModel alloc] init];
        model.name = accountTypeDesc[i];
        model.pid = [accountTypepid[i] longLongValue];
        model.num = i;
        [[ZYAccountTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *accountPurDesc = @[@"贷款还款账户",@"贷款回款账户",@"代发工资账户"];
    NSArray *accountPurpid = @[@(13234),
                                @(13235),
                                @(13236)];
    for(int i=0;i<accountPurDesc.count;i++)
    {
        ZYAccountPurposeModel *model = [[ZYAccountPurposeModel alloc] init];
        model.name = accountPurDesc[i];
        model.pid = [accountPurpid[i] longLongValue];
        model.num = i;
        [[ZYAccountPurposeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *liveStateDesc = @[@"自有居住",@"住房按揭",@"租房",@"其他"];
    NSArray *liveStatepid = @[@(13213),
                               @(13214),
                               @(13215),
                              @(13216)];
    for(int i=0;i<liveStateDesc.count;i++)
    {
        ZYLiveStatuModel *model = [[ZYLiveStatuModel alloc] init];
        model.name = liveStateDesc[i];
        model.pid = [liveStatepid[i] longLongValue];
        model.num = i;
        [[ZYLiveStatuModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *liveTypeDesc = @[@"别墅",@"商品房",@"小产权房",@"其他"];
    NSArray *liveTypepid = @[@(13217),
                              @(13218),
                              @(13219),
                              @(13220)];
    for(int i=0;i<liveStateDesc.count;i++)
    {
        ZYLiveTypeModel *model = [[ZYLiveTypeModel alloc] init];
        model.name = liveTypeDesc[i];
        model.pid = [liveTypepid[i] longLongValue];
        model.num = i;
        [[ZYLiveTypeModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *liveIndentityDesc = @[@"是",@"否"];
    NSArray *liveIndentitypid = @[@(1),
                                  @(2),];
    for(int i=0;i<liveIndentityDesc.count;i++)
    {
        ZYLiveIdentityModel *model = [[ZYLiveIdentityModel alloc] init];
        model.name = liveIndentityDesc[i];
        model.pid = [liveIndentitypid[i] longLongValue];
        model.num = i;
        [[ZYLiveIdentityModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
    
    NSArray *relationDesc = @[@"亲属",@"朋友",@"上下级"];
    NSArray *relationpid = @[@(13244),
                             @(13245),
                             @(13246)];
    for(int i=0;i<relationDesc.count;i++)
    {
        ZYRelationModel *model = [[ZYRelationModel alloc] init];
        model.name = relationDesc[i];
        model.pid = [relationpid[i] longLongValue];
        model.num = i;
        [[ZYRelationModel getUsingLKDBHelper] insertWhenNotExists:model];
    }
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
