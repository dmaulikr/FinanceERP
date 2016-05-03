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
    
    ZYForeclosureHouseOrderInfoCell *orderInfoPowerOfAttorney;
    ZYForeclosureHouseOrderInfoTextCell *orderInfoPowerOfAttorneyContent;
    ZYForeclosureHouseOrderInfoCell *orderInfoIdentificationCard;
    ZYForeclosureHouseOrderInfoTextCell *orderInfoIdentificationCardContent;
    ZYForeclosureHouseOrderInfoCell *orderInfoCardForBuilding;
    ZYForeclosureHouseOrderInfoTextCell *orderInfoCardForBuildingContent;
    ZYForeclosureHouseOrderInfoCell *orderInfoBankbook;
    ZYForeclosureHouseOrderInfoTextCell *orderInfoBankbookContent;
    ZYForeclosureHouseOrderInfoCell *orderInfoSecurityAgreement;
    ZYForeclosureHouseOrderInfoTextCell *orderInfoSecurityAgreementContent;
    ZYForeclosureHouseOrderInfoCell *orderInfoMortgageContract;
    ZYForeclosureHouseOrderInfoTextCell *orderInfoMortgageContractContent;
    
    ZYSection *headerSection;
    ZYSection *section1;
    ZYSection *section2;
    ZYSection *section3;
    ZYSection *section4;
    ZYSection *section5;
    ZYSection *section6;
    ZYSection *section7;
    ZYSection *section8;
    ZYSection *section9;
    ZYSection *section10;
    ZYSection *section11;
    ZYSection *section12;
    ZYSection *buttonSection;
}
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title];
    if (self) {
        
    }
    return self;
}
- (void)initSection
{
    header = [ZYForeclosureHouseOrderInfoHeader cellWithActionBlock:nil];
    header.frame = CGRectMake(0, 0, FUll_SCREEN_WIDTH, [ZYForeclosureHouseOrderInfoHeader defaultHeight]);
    headerSection = [ZYSection sectionWithCells:@[header]];
    
    orderInfoPowerOfAttorney = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
    orderInfoPowerOfAttorney.cellTitle = @"公正委托书";
    
    orderInfoPowerOfAttorneyContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
    orderInfoPowerOfAttorneyContent.cellTitle = @"备注:";
    
    section1 = [ZYSection sectionWithCells:@[orderInfoPowerOfAttorney]];
    section2 = [ZYSection sectionWithCells:@[orderInfoPowerOfAttorneyContent]];
    section2.hasFold = YES;
    [orderInfoPowerOfAttorney.buttonPressedSignal subscribeNext:^(id x) {
        orderInfoPowerOfAttorney.buttonRotate = section2.hasFold;
        if(section2.hasFold)
        {
            [self showSection:YES sectionIndex:2];
            [orderInfoPowerOfAttorneyContent becomeFirstResponder];
        }
        else
        {
            [self showSection:NO sectionIndex:2];
        }
    }];
    
    orderInfoIdentificationCard = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
    orderInfoIdentificationCard.cellTitle = @"业主及借款人身份证";
    
    orderInfoIdentificationCardContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
    orderInfoIdentificationCardContent.cellTitle = @"备注:";
    
    section3 = [ZYSection sectionWithCells:@[orderInfoIdentificationCard]];
    section4 = [ZYSection sectionWithCells:@[orderInfoIdentificationCardContent]];
    section4.hasFold = YES;
    [orderInfoIdentificationCard.buttonPressedSignal subscribeNext:^(id x) {
        orderInfoIdentificationCard.buttonRotate = section4.hasFold;
        if(section4.hasFold)
        {
            [self showSection:YES sectionIndex:4];
            [orderInfoIdentificationCardContent becomeFirstResponder];
        }
        else
        {
            [self showSection:NO sectionIndex:4];
        }
    }];
    
    orderInfoCardForBuilding = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
    orderInfoCardForBuilding.cellTitle = @"供楼卡";
    
    orderInfoCardForBuildingContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
    orderInfoCardForBuildingContent.cellTitle = @"备注:";
    
    section5 = [ZYSection sectionWithCells:@[orderInfoCardForBuilding]];
    section6 = [ZYSection sectionWithCells:@[orderInfoCardForBuildingContent]];
    section6.hasFold = YES;
    [orderInfoCardForBuilding.buttonPressedSignal subscribeNext:^(id x) {
        orderInfoCardForBuilding.buttonRotate = section6.hasFold;
        if(section6.hasFold)
        {
            [self showSection:YES sectionIndex:6];
            [orderInfoCardForBuildingContent becomeFirstResponder];
        }
        else
        {
            [self showSection:NO sectionIndex:6];
        }
    }];
    
    orderInfoBankbook = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
    orderInfoBankbook.cellTitle = @"存折";
    
    orderInfoBankbookContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
    orderInfoBankbookContent.cellTitle = @"备注:";
    
    section7 = [ZYSection sectionWithCells:@[orderInfoBankbook]];
    section8 = [ZYSection sectionWithCells:@[orderInfoBankbookContent]];
    section8.hasFold = YES;
    [orderInfoBankbook.buttonPressedSignal subscribeNext:^(id x) {
        orderInfoBankbook.buttonRotate = section8.hasFold;
        if(section8.hasFold)
        {
            [self showSection:YES sectionIndex:8];
            [orderInfoBankbookContent becomeFirstResponder];
        }
        else
        {
            [self showSection:NO sectionIndex:8];
        }
    }];
    
    orderInfoSecurityAgreement = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
    orderInfoSecurityAgreement.cellTitle = @"担保服务协议";
    
    orderInfoSecurityAgreementContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
    orderInfoSecurityAgreementContent.cellTitle = @"备注:";
    
    section9 = [ZYSection sectionWithCells:@[orderInfoSecurityAgreement]];
    section10 = [ZYSection sectionWithCells:@[orderInfoSecurityAgreementContent]];
    section10.hasFold = YES;
    [orderInfoSecurityAgreement.buttonPressedSignal subscribeNext:^(id x) {
        orderInfoSecurityAgreement.buttonRotate = section10.hasFold;
        if(section10.hasFold)
        {
            [self showSection:YES sectionIndex:10];
            [orderInfoSecurityAgreementContent becomeFirstResponder];
        }
        else
        {
            [self showSection:NO sectionIndex:10];
        }
    }];
    
    orderInfoMortgageContract = [ZYForeclosureHouseOrderInfoCell cellWithActionBlock:nil];
    orderInfoMortgageContract.cellTitle = @"原借款抵押合同";
    
    orderInfoMortgageContractContent = [ZYForeclosureHouseOrderInfoTextCell cellWithActionBlock:nil];
    orderInfoMortgageContractContent.cellTitle = @"备注:";
    
    section11 = [ZYSection sectionWithCells:@[orderInfoMortgageContract]];
    section12 = [ZYSection sectionWithCells:@[orderInfoMortgageContractContent]];
    section12.hasFold = YES;
    [orderInfoMortgageContract.buttonPressedSignal subscribeNext:^(id x) {
        orderInfoMortgageContract.buttonRotate = section12.hasFold;
        if(section12.hasFold)
        {
            [self showSection:YES sectionIndex:12];
            [orderInfoMortgageContractContent becomeFirstResponder];
        }
        else
        {
            [self showSection:NO sectionIndex:12];
        }
    }];
    ZYDoubleButtonCell *buttonCell = [ZYDoubleButtonCell cellWithActionBlock:nil];
    [buttonCell.rightButtonPressedSignal subscribeNext:^(id x) {
        [self cellNextStep:nil];
    }];
    [buttonCell.leftButtonPressedSignal subscribeNext:^(id x) {
        [self cellLastStep];
    }];
    buttonSection = [ZYSection sectionWithCells:@[buttonCell]];

}
- (void)blendModel:(ZYForeclosureHouseValueModel*)model
{
    [self initSection];
    RACChannelTo(model,orderInfoPowerOfAttorneyContent) = RACChannelTo(orderInfoPowerOfAttorneyContent,cellText);
    RACChannelTo(model,orderInfoIdentificationCardContent) = RACChannelTo(orderInfoIdentificationCardContent,cellText);
    RACChannelTo(model,orderInfoCardForBuildingContent) = RACChannelTo(orderInfoCardForBuildingContent,cellText);
    RACChannelTo(model,orderInfoBankbookContent) = RACChannelTo(orderInfoBankbookContent,cellText);
    RACChannelTo(model,orderInfoSecurityAgreementContent) = RACChannelTo(orderInfoSecurityAgreementContent,cellText);
    RACChannelTo(model,orderInfoMortgageContractContent) = RACChannelTo(orderInfoMortgageContractContent,cellText);
    
    RACChannelTo(model,orderInfoPowerOfAttorney) = RACChannelTo(orderInfoPowerOfAttorney,cellLeftSteps);
    RACChannelTo(model,orderInfoIdentificationCard) = RACChannelTo(orderInfoIdentificationCard,cellLeftSteps);
    RACChannelTo(model,orderInfoCardForBuilding) = RACChannelTo(orderInfoCardForBuilding,cellLeftSteps);
    RACChannelTo(model,orderInfoBankbook) = RACChannelTo(orderInfoBankbook,cellLeftSteps);
    RACChannelTo(model,orderInfoSecurityAgreement) = RACChannelTo(orderInfoSecurityAgreement,cellLeftSteps);
    RACChannelTo(model,orderInfoMortgageContract) = RACChannelTo(orderInfoMortgageContract,cellLeftSteps);
    
    RACChannelTo(model,orderInfoPowerOfAttorneyCopy) = RACChannelTo(orderInfoPowerOfAttorney,cellRightSteps);
    RACChannelTo(model,orderInfoIdentificationCardCopy) = RACChannelTo(orderInfoIdentificationCard,cellRightSteps);
    RACChannelTo(model,orderInfoCardForBuildingCopy) = RACChannelTo(orderInfoCardForBuilding,cellRightSteps);
    RACChannelTo(model,orderInfoBankbookCopy) = RACChannelTo(orderInfoBankbook,cellRightSteps);
    RACChannelTo(model,orderInfoSecurityAgreementCopy) = RACChannelTo(orderInfoSecurityAgreement,cellRightSteps);
    RACChannelTo(model,orderInfoMortgageContractCopy) = RACChannelTo(orderInfoMortgageContract,cellRightSteps);
    
    RAC(orderInfoPowerOfAttorney,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoIdentificationCard,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoCardForBuilding,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoBankbook,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoSecurityAgreement,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoMortgageContract,userInteractionEnabled) = RACObserve(self, edit);
    
    RAC(orderInfoPowerOfAttorneyContent,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoIdentificationCardContent,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoCardForBuildingContent,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoBankbookContent,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoSecurityAgreementContent,userInteractionEnabled) = RACObserve(self, edit);
    RAC(orderInfoMortgageContractContent,userInteractionEnabled) = RACObserve(self, edit);
    
    [RACObserve(self, edit) subscribeNext:^(id x) {
        if(self.edit)
        {
            self.sections = @[headerSection,
                              section1,
                              section2,
                              section3,
                              section4,
                              section5,
                              section6,
                              section7,
                              section8,
                              section9,
                              section10,
                              section11,
                              section12,buttonSection];
        }
        else
        {
            self.sections = @[headerSection,
                              section1,
                              section2,
                              section3,
                              section4,
                              section5,
                              section6,
                              section7,
                              section8,
                              section9,
                              section10,
                              section11,
                              section12];
        }
    }];
}
- (NSString*)error
{
    return nil;//全部都非必填
}

@end
