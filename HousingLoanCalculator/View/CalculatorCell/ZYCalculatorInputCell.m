//
//  ZYCalculatorInputCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/30.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYCalculatorInputCell.h"
#define FLOAT @"0123456789."
#define INT @"0123456789"

@interface ZYCalculatorInputCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property (weak, nonatomic) IBOutlet UILabel *cellTailLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTailLabelWidth;

@end

@implementation ZYCalculatorInputCell
- (void)awakeFromNib
{
    _maxLength = 5;
    
    _cellTextField.delegate = self;
    [_cellTextField.rac_textSignal subscribeNext:^(NSString *text) {
        self.cellDetail = text;
    }];
    
    @weakify(self)
    [RACObserve(self, selecedObj) subscribeNext:^(id x) {
        @strongify(self)
        if(!self.hiddenSelecedObj)
        {
            if([x isKindOfClass:[NSString class]])
            {
                self.cellDetail = x;
            }
            else if (self.showKey.length!=0)
            {
                self.cellDetail = [x valueForKey:self.showKey];
            }
        }
    }];
}
- (RACSignal*)inputTextSignal
{
    return self.cellTextField.rac_textSignal;
}
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    self.cellTitleLabel.text = cellTitle;
}
- (void)setTailText:(NSString *)tailText
{
    _tailText = tailText;
    CGSize size = [tailText sizeWithAttributes:@{NSFontAttributeName:_cellTailLabel.font}];
    _cellTailLabelWidth.constant = size.width;///动态调整label宽度
    self.cellTailLabel.text = tailText;
}
- (void)setCellDetail:(NSString *)cellDetail
{
    _cellDetail = cellDetail;
    self.cellTextField.text = cellDetail;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet*cs;///限制输入类型 为float
    if([textField.text rangeOfString:@"."].length==0)///没有小数点时候可以输入小数点
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:FLOAT] invertedSet];
    }
    else
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:INT] invertedSet];
    }
    NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest) {
        return NO;
    }
    if(textField.text.length+string.length>_maxLength)///限制长度
    {
        NSMutableString *str = [NSMutableString stringWithString:textField.text];
        [str replaceCharactersInRange:range withString:string];
        textField.text = [str substringToIndex:_maxLength];
        return NO;
    }
    return YES;
}
- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    [_cellTextField resignFirstResponder];
    return YES;
}
@end
