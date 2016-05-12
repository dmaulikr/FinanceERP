//
//  ZYCalculatorViewController.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/29.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorViewController.h"
#import "ZYCalculatorResultViewController.h"
#import "ZYCalculatorSections.h"

@interface ZYCalculatorViewController ()


/**
 *   选中的标示
 */
@property (weak, nonatomic) IBOutlet UIView *selectedLine;
/**
 *  选中标示 左边间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedLineLeftGap;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *middleButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation ZYCalculatorViewController
{
    ZYCalculatorSections *bussinessSections;
    ZYCalculatorSections *publicFundSections;
    ZYCalculatorSections *admixtureSections;
    
    ZYCalculatorViewModel *bussinessViewModel;
    ZYCalculatorViewModel *publicFundViewModel;
    ZYCalculatorViewModel *admixtureViewModel;
    
    NSArray *sectionsArr;
    
    UITableViewCell *firstResponderCell;//正在选择的cell
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    bussinessViewModel = [ZYCalculatorViewModel viewModelWithType:ZYCalculatorTypeBusinessLoan];
    publicFundViewModel = [ZYCalculatorViewModel viewModelWithType:ZYCalculatorTypePublicFunds];
    admixtureViewModel = [ZYCalculatorViewModel viewModelWithType:ZYCalculatorTypeAdmixture];
    
    [self buildUI];
    [self blendViewModel];
    [self buildTableViewController];
}
- (void)buildUI
{
//    ZYCalculatorViewModel *viewModel = self.viewModel;
    [self buildPickerView];///本页需要picker
    self.pickerViewTapBlankHidden = YES;

    bussinessSections = [[ZYCalculatorSections alloc] initWithTitle:@"商贷"];
    publicFundSections = [[ZYCalculatorSections alloc] initWithTitle:@"公积金"];
    admixtureSections = [[ZYCalculatorSections alloc] initWithTitle:@"综合贷"];
    
    sectionsArr = @[bussinessSections,
                    publicFundSections,
                    admixtureSections];
    
    [[RACObserve(bussinessSections, sections) skip:2] subscribeNext:^(id x) {
        [self reloadTableViewAtIndex:0];
    }];
    [[RACObserve(publicFundSections, sections) skip:2] subscribeNext:^(id x) {
        [self reloadTableViewAtIndex:1];
    }];
    [[RACObserve(admixtureSections, sections) skip:2] subscribeNext:^(id x) {
        [self reloadTableViewAtIndex:2];
    }];
    
    @weakify(self)
    RACSignal *leftSignal = [[_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(UIButton *button) {
        return @(0);
    }];
    RACSignal *middleSignal = [[_middleButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(UIButton *button) {
        return @(1);
    }];
    RACSignal *rightSignal = [[_rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(UIButton *button) {
        return @(2);
    }];
    [[RACSignal merge:@[leftSignal,middleSignal,rightSignal]] subscribeNext:^(NSNumber *value) {
        @strongify(self)
        [self changePage:[value longLongValue]];
    }];
    
    [[RACSignal merge:@[bussinessSections.pickerByDataSourceSignal,publicFundSections.pickerByDataSourceSignal,admixtureSections.pickerByDataSourceSignal]] subscribeNext:^(RACTuple *value) {
        firstResponderCell = value.first;
        NSArray *dataSource = value.second;
        self.components = @[dataSource];//二维数组 可以多列
        if([firstResponderCell isKindOfClass:[ZYCalculatorSelectCell class]])
        {
            self.selecedRow = [(ZYCalculatorSelectCell*)firstResponderCell selecedIndex];
        }
        [self showPickerView:YES];
    }];
    [[[RACSignal merge:@[bussinessSections.nextStepSignal,publicFundSections.nextStepSignal,admixtureSections.nextStepSignal]] filter:^BOOL(RACTuple *value) {
        NSString *error = value.first;
        if(error.length>0)
        {
            [self tip:error touch:NO];
            return NO;
        }
        return YES;
    }] subscribeNext:^(RACTuple *value) {
        [self performSegueWithIdentifier:@"result" sender:bussinessViewModel.valueModel];
    }];
    
    [RACObserve(self, selecedRow) subscribeNext:^(id x) {
        if([firstResponderCell isKindOfClass:[ZYCalculatorSelectCell class]])
        {
            [(ZYCalculatorSelectCell*)firstResponderCell setSelecedIndex:self.selecedRow];
        }
    }];
#pragma mark - 键盘展现
    [[self rac_signalForSelector:@selector(keyboardWillShow:)] subscribeNext:^(id x) {
        [self showPickerView:NO];
    }];
    
    
}
- (void)blendViewModel
{
    [bussinessSections blendViewModel:bussinessViewModel];
    [publicFundSections blendViewModel:publicFundViewModel];
    [admixtureSections blendViewModel:admixtureViewModel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"result"])
    {
        ZYCalculatorResultViewController *result = [segue destinationViewController];
        ZYCalculatorValueModel *valueModel = sender;
        ZYCalculatorType calculatorType = valueModel.calculatorType;
        ZYCalculatorResultViewModel *resultModel = [ZYCalculatorResultViewModel viewModelWithType:calculatorType];
        resultModel.valueModel = valueModel;
        result.viewModel = resultModel;
    }
}
- (ZYSections*)sliderController:(ZYSliderViewController*)controller sectionsWithPage:(NSInteger)page
{
    return sectionsArr[page];
}
- (NSInteger)countOfControllerSliderController:(ZYSliderViewController *)controller
{
    return sectionsArr.count;
}
- (CGRect)sliderController:(ZYSliderViewController*)controller frameWithPage:(NSInteger)page
{
    return CGRectMake(page*FUll_SCREEN_WIDTH, 0, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-40-64);
}
- (CGRect)frameOfScrollViewSliderController:(ZYSliderViewController *)controller
{
    return CGRectMake(0, 64+40, FUll_SCREEN_WIDTH, FUll_SCREEN_HEIGHT-40-64);
}
- (void)sliderController:(ZYSliderViewController *)controller changingPage:(NSInteger)index direction:(ZYSliderDirection)direction rate:(CGFloat)rate
{
    CGFloat width = self.view.width/3.f*2.f;
    self.selectedLineLeftGap.constant = rate*width;
}
- (void)sliderController:(ZYSliderViewController *)controller didChangePage:(NSInteger)index direction:(ZYSliderDirection)direction
{
    [self.view endEditing:YES];
    [self showPickerView:NO];
}
@end
