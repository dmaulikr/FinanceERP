//
//  ZYOrderInfoSections.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYOrderInfoSections.h"
#import "ZYForeclosureHouseOrderInfoCell.h"
#import "ZYForeclosureHouseOrderInfoTextCell.h"
#import "ZYForeclosureHouseOrderInfoHeader.h"

@implementation ZYOrderInfoSections
{
    ZYForeclosureHouseOrderInfoHeader *header;
    ZYSection *headerSection;
    ZYSection *buttonSection;
}
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        [self initSection];
    }
    return self;
}
- (void)initSection
{
    header = [ZYForeclosureHouseOrderInfoHeader cellWithActionBlock:nil];
    header.frame = CGRectMake(0, 0, FUll_SCREEN_WIDTH, [ZYForeclosureHouseOrderInfoHeader defaultHeight]);
    headerSection = [ZYSection sectionWithCells:@[header]];
    
//    orderInfoPowerOfAttorney = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
//    orderInfoPowerOfAttorney.cellTitle = @"公正委托书";
//    
//    orderInfoPowerOfAttorneyContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
//    orderInfoPowerOfAttorneyContent.cellTitle = @"备注:";
//    
//    section1 = [ZYSection sectionWithCells:@[orderInfoPowerOfAttorney]];
//    section2 = [ZYSection sectionWithCells:@[orderInfoPowerOfAttorneyContent]];
//    section2.hasFold = YES;
//    [orderInfoPowerOfAttorney.buttonPressedSignal subscribeNext:^(id x) {
//        orderInfoPowerOfAttorney.buttonRotate = section2.hasFold;
//        if(section2.hasFold)
//        {
//            [self showSection:YES sectionIndex:2];
//            [orderInfoPowerOfAttorneyContent becomeFirstResponder];
//        }
//        else
//        {
//            [self showSection:NO sectionIndex:2];
//        }
//    }];
//    
//    orderInfoIdentificationCard = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
//    orderInfoIdentificationCard.cellTitle = @"业主及借款人身份证";
//    
//    orderInfoIdentificationCardContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
//    orderInfoIdentificationCardContent.cellTitle = @"备注:";
//    
//    section3 = [ZYSection sectionWithCells:@[orderInfoIdentificationCard]];
//    section4 = [ZYSection sectionWithCells:@[orderInfoIdentificationCardContent]];
//    section4.hasFold = YES;
//    [orderInfoIdentificationCard.buttonPressedSignal subscribeNext:^(id x) {
//        orderInfoIdentificationCard.buttonRotate = section4.hasFold;
//        if(section4.hasFold)
//        {
//            [self showSection:YES sectionIndex:4];
//            [orderInfoIdentificationCardContent becomeFirstResponder];
//        }
//        else
//        {
//            [self showSection:NO sectionIndex:4];
//        }
//    }];
//    
//    orderInfoCardForBuilding = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
//    orderInfoCardForBuilding.cellTitle = @"供楼卡";
//    
//    orderInfoCardForBuildingContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
//    orderInfoCardForBuildingContent.cellTitle = @"备注:";
//    
//    section5 = [ZYSection sectionWithCells:@[orderInfoCardForBuilding]];
//    section6 = [ZYSection sectionWithCells:@[orderInfoCardForBuildingContent]];
//    section6.hasFold = YES;
//    [orderInfoCardForBuilding.buttonPressedSignal subscribeNext:^(id x) {
//        orderInfoCardForBuilding.buttonRotate = section6.hasFold;
//        if(section6.hasFold)
//        {
//            [self showSection:YES sectionIndex:6];
//            [orderInfoCardForBuildingContent becomeFirstResponder];
//        }
//        else
//        {
//            [self showSection:NO sectionIndex:6];
//        }
//    }];
//    
//    orderInfoBankbook = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
//    orderInfoBankbook.cellTitle = @"存折";
//    
//    orderInfoBankbookContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
//    orderInfoBankbookContent.cellTitle = @"备注:";
//    
//    section7 = [ZYSection sectionWithCells:@[orderInfoBankbook]];
//    section8 = [ZYSection sectionWithCells:@[orderInfoBankbookContent]];
//    section8.hasFold = YES;
//    [orderInfoBankbook.buttonPressedSignal subscribeNext:^(id x) {
//        orderInfoBankbook.buttonRotate = section8.hasFold;
//        if(section8.hasFold)
//        {
//            [self showSection:YES sectionIndex:8];
//            [orderInfoBankbookContent becomeFirstResponder];
//        }
//        else
//        {
//            [self showSection:NO sectionIndex:8];
//        }
//    }];
//    
//    orderInfoSecurityAgreement = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
//    orderInfoSecurityAgreement.cellTitle = @"担保服务协议";
//    
//    orderInfoSecurityAgreementContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
//    orderInfoSecurityAgreementContent.cellTitle = @"备注:";
//    
//    section9 = [ZYSection sectionWithCells:@[orderInfoSecurityAgreement]];
//    section10 = [ZYSection sectionWithCells:@[orderInfoSecurityAgreementContent]];
//    section10.hasFold = YES;
//    [orderInfoSecurityAgreement.buttonPressedSignal subscribeNext:^(id x) {
//        orderInfoSecurityAgreement.buttonRotate = section10.hasFold;
//        if(section10.hasFold)
//        {
//            [self showSection:YES sectionIndex:10];
//            [orderInfoSecurityAgreementContent becomeFirstResponder];
//        }
//        else
//        {
//            [self showSection:NO sectionIndex:10];
//        }
//    }];
//    
//    orderInfoMortgageContract = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
//    orderInfoMortgageContract.cellTitle = @"原借款抵押合同";
//    
//    orderInfoMortgageContractContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
//    orderInfoMortgageContractContent.cellTitle = @"备注:";
//    
//    section11 = [ZYSection sectionWithCells:@[orderInfoMortgageContract]];
//    section12 = [ZYSection sectionWithCells:@[orderInfoMortgageContractContent]];
//    section12.hasFold = YES;
//    [orderInfoMortgageContract.buttonPressedSignal subscribeNext:^(id x) {
//        orderInfoMortgageContract.buttonRotate = section12.hasFold;
//        if(section12.hasFold)
//        {
//            [self showSection:YES sectionIndex:12];
//            [orderInfoMortgageContractContent becomeFirstResponder];
//        }
//        else
//        {
//            [self showSection:NO sectionIndex:12];
//        }
//    }];
    ZYDoubleButtonCell *buttonCell = [ZYDoubleButtonCell cellWithActionBlock:nil];
    [buttonCell.rightButtonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:nil];
    }];
    [buttonCell.leftButtonPressedSignal subscribeNext:^(id x) {
        [self cellLastStep];
    }];
    buttonSection = [ZYSection sectionWithCells:@[buttonCell]];

}
- (void)blendModel:(ZYForeclosureHouseViewModel*)model
{
    [RACObserve(model, orderInfoPaperArr) subscribeNext:^(NSArray *orderInfoPaperArr) {
        NSMutableArray *sectionArr = [NSMutableArray arrayWithCapacity:orderInfoPaperArr.count];
        [sectionArr addObject:headerSection];
        
        NSInteger idx = 1;
       for(ZYPaperModel *paper in orderInfoPaperArr)
       {
           ZYForeclosureHouseOrderInfoCell *infoCell = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
           infoCell.cellTitle = paper.orderInfoPaperTitle;
           infoCell.userInteractionEnabled = self.edit;
           RACChannelTo(infoCell,cellLeftSteps) = RACChannelTo(paper,orderInfoPaperCount);
           RACChannelTo(infoCell,cellRightSteps) = RACChannelTo(paper,orderInfoPaperCopyCount);
           ZYSection *infoSection = [ZYSection sectionWithCells:@[infoCell]];
           
           ZYForeclosureHouseOrderInfoTextCell *contentCell = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
           contentCell.cellTitle = @"备注";
           contentCell.userInteractionEnabled = self.edit;
           RACChannelTo(contentCell,cellText) = RACChannelTo(paper,orderInfoPaperContent);
           ZYSection *contentSection = [ZYSection sectionWithCells:@[contentCell]];
           contentSection.hasFold = YES;
           [sectionArr addObject:infoSection];
           if(self.edit)
           {
               [infoCell.buttonPressedSignal subscribeNext:^(id x) {
                   infoCell.buttonRotate = contentSection.hasFold;
                   if(contentSection.hasFold)
                   {
                       [self showSection:YES sectionIndex:idx*2];
                       [contentCell becomeFirstResponder];
                   }
                   else
                   {
                       [self showSection:NO sectionIndex:idx*2];
                   }
               }];
               [sectionArr addObject:contentSection];
           }
           else
           {
               if(paper.orderInfoPaperContent.length>0)
               {
                   [sectionArr addObject:contentSection];
               }
               infoCell.buttonRotateHidden = YES;
               header.contentTitleHidden = YES;
           }
           
           idx++;
       }
        if(self.edit)
        {
           [sectionArr addObject:buttonSection];
        }
        self.sections = sectionArr;
    }];
    
//    RACChannelTo(orderInfoPowerOfAttorneyContent,cellText) = RACChannelTo(model,orderInfoPowerOfAttorneyContent);
//    RACChannelTo(orderInfoIdentificationCardContent,cellText) = RACChannelTo(model,orderInfoIdentificationCardContent);
//    RACChannelTo(orderInfoCardForBuildingContent,cellText) = RACChannelTo(model,orderInfoCardForBuildingContent);
//    RACChannelTo(orderInfoBankbookContent,cellText) = RACChannelTo(model,orderInfoBankbookContent);
//    RACChannelTo(orderInfoSecurityAgreementContent,cellText) = RACChannelTo(model,orderInfoSecurityAgreementContent);
//    RACChannelTo(orderInfoMortgageContractContent,cellText) = RACChannelTo(model,orderInfoMortgageContractContent);
//    
//    RACChannelTo(orderInfoPowerOfAttorney,cellLeftSteps) = RACChannelTo(model,orderInfoPowerOfAttorney);
//    RACChannelTo(orderInfoIdentificationCard,cellLeftSteps) = RACChannelTo(model,orderInfoIdentificationCard);
//    RACChannelTo(orderInfoCardForBuilding,cellLeftSteps) = RACChannelTo(model,orderInfoCardForBuilding);
//    RACChannelTo(orderInfoBankbook,cellLeftSteps) = RACChannelTo(model,orderInfoBankbook);
//    RACChannelTo(orderInfoSecurityAgreement,cellLeftSteps) = RACChannelTo(model,orderInfoSecurityAgreement);
//    RACChannelTo(orderInfoMortgageContract,cellLeftSteps) = RACChannelTo(model,orderInfoMortgageContract);
//    
//    RACChannelTo(orderInfoPowerOfAttorney,cellRightSteps) = RACChannelTo(model,orderInfoPowerOfAttorneyCopy);
//    RACChannelTo(orderInfoIdentificationCard,cellRightSteps) = RACChannelTo(model,orderInfoIdentificationCardCopy);
//    RACChannelTo(orderInfoCardForBuilding,cellRightSteps) = RACChannelTo(model,orderInfoCardForBuildingCopy);
//    RACChannelTo(orderInfoBankbook,cellRightSteps) = RACChannelTo(model,orderInfoBankbookCopy);
//    RACChannelTo(orderInfoSecurityAgreement,cellRightSteps) = RACChannelTo(model,orderInfoSecurityAgreementCopy);
//    RACChannelTo(orderInfoMortgageContract,cellRightSteps) = RACChannelTo(model,orderInfoMortgageContractCopy);
    
//    RAC(orderInfoPowerOfAttorney,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoIdentificationCard,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoCardForBuilding,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoBankbook,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoSecurityAgreement,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoMortgageContract,userInteractionEnabled) = RACObserve(self, edit);
//    
//    RAC(orderInfoPowerOfAttorneyContent,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoIdentificationCardContent,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoCardForBuildingContent,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoBankbookContent,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoSecurityAgreementContent,userInteractionEnabled) = RACObserve(self, edit);
//    RAC(orderInfoMortgageContractContent,userInteractionEnabled) = RACObserve(self, edit);
    
//    [RACObserve(self, edit) subscribeNext:^(id x) {
//        if(self.edit)
//        {
//            self.sections = @[headerSection,
//                              section1,
//                              section2,
//                              section3,
//                              section4,
//                              section5,
//                              section6,
//                              section7,
//                              section8,
//                              section9,
//                              section10,
//                              section11,
//                              section12,buttonSection];
//        }
//        else
//        {
//            self.sections = @[headerSection,
//                              section1,
//                              section2,
//                              section3,
//                              section4,
//                              section5,
//                              section6,
//                              section7,
//                              section8,
//                              section9,
//                              section10,
//                              section11,
//                              section12];
//        }
//    }];
}
- (NSString*)error
{
    return nil;//全部都非必填
}

@end
