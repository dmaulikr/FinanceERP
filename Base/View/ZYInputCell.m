//
//  ZYInputCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYInputCell.h"

#define FLOAT @"0123456789."
#define INT @"0123456789"

@interface ZYInputCell()<UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
//@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
//@property (weak, nonatomic) IBOutlet UILabel *tailLabel;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTailLabelWidth;

@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) UITextField *cellTextField;
@property (strong, nonatomic) UILabel *tailLabel;
@property(nonatomic,assign)BOOL checkInput;///检查是否为空  用于赋值

@end

@implementation ZYInputCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellError = @"";///初始化为空字符串 防止放入数组筛选出现错误
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 100, [ZYInputCell defaultHeight])];
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.font = FONT(14);
        _cellTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellTitleLabel];
        
        _tailLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 0, [ZYInputCell defaultHeight])];
        _tailLabel.font = FONT(14);
        _tailLabel.textColor = TITLE_COLOR;
        [self addSubview:_tailLabel];
        
        _cellTextField = [[UITextField alloc] initWithFrame:CGRectMake(_cellTitleLabel.width+2*GAP, 0, FUll_SCREEN_WIDTH-4*GAP-_cellTitleLabel.width-_tailLabel.width, [ZYInputCell defaultHeight])];
        _cellTextField.font = FONT(12);
        _cellTextField.textColor = TITLE_COLOR;
        [self addSubview:_cellTextField];
        
        _cellTextField.delegate = self;
        @weakify(self)
        [_cellTextField.rac_textSignal subscribeNext:^(NSString *text) {
            @strongify(self)
            self.cellText = text;
            if(_checkInput)
            {
                [self setCellTitle:self.cellTitle];
            }
        }];
    }
    return self;
}
- (void)setSelecedObj:(id)selecedObj
{
    _selecedObj = selecedObj;
    if(!self.hiddenSelecedObj&&selecedObj)
    {
        if([selecedObj isKindOfClass:[NSString class]])
        {
            self.cellText = selecedObj;
        }
        else if (self.showKey.length!=0)
        {
            self.cellText = [selecedObj valueForKey:self.showKey];
        }
    }
}
- (void)setOnlyFloat:(BOOL)onlyFloat
{
    _onlyFloat = onlyFloat;
    self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}
- (void)setOnlyInt:(BOOL)onlyInt
{
    _onlyInt = onlyInt;
    self.keyboardType = UIKeyboardTypeNumberPad;
}
- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    _cellTextField.keyboardType = keyboardType;
}
- (void)setCellText:(NSString *)cellText
{
    _cellText = cellText;
    _cellTextField.text = cellText;
}
- (void)setCellTailText:(NSString *)cellTailText
{
    _cellTailText = cellTailText;
    _tailLabel.text = cellTailText;
    CGSize size = [cellTailText sizeWithAttributes:@{NSFontAttributeName:_tailLabel.font}];
    _tailLabel.width = size.width;
    _tailLabel.X = FUll_SCREEN_WIDTH-size.width-GAP;
    _cellTextField.width = FUll_SCREEN_WIDTH-_tailLabel.width-_cellTitleLabel.width-4*GAP;
}
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;

    BOOL isValid = YES;
    if(self.cellRegular.length!=0&&_cellText.length!=0)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.cellRegular];
        isValid = [predicate evaluateWithObject:_cellText];
        if(!isValid)
        {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",cellTitle]];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attrStr.length)];
            _cellTitleLabel.attributedText = attrStr;
            self.cellError = [NSString stringWithFormat:@"请输入正确的%@",cellTitle];
        }
        else
        {
            self.cellError = @"";
        }
        return;
    }
    
    
    if(!_cellNullable)
    {
        if(!_checkInput||(_checkInput&&_cellText.length!=0))///需要检查是否为空
        {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",cellTitle]];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
            _cellTitleLabel.attributedText = attrStr;
            self.cellError = @"";
        }
        else
        {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",cellTitle]];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attrStr.length)];
            _cellTitleLabel.attributedText = attrStr;
            self.cellError = self.cellPlaceHolder==nil?[NSString stringWithFormat:@"请输入%@",cellTitle]:self.cellPlaceHolder;
        }
    }
    else
    {
        _cellTitleLabel.text = cellTitle;
        self.cellError = @"";
    }
}
- (void)setCellNullable:(BOOL)cellNullable
{
    _cellNullable = cellNullable;
    [self setCellTitle:_cellTitle];
}
- (void)setCellPlaceHolder:(NSString *)cellPlaceHolder
{
    _cellPlaceHolder = cellPlaceHolder;
    _cellTextField.placeholder = cellPlaceHolder;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(self.onlyFloat)
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
        _maxLength = _maxLength==0?11:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    else if (self.onlyInt)
    {
        NSCharacterSet*cs;///限制输入类型 为float
        cs = [[NSCharacterSet characterSetWithCharactersInString:INT] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
        _maxLength = _maxLength==0?10:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    else if (self.onlyCustom&&_customInput.length>0)
    {
        NSCharacterSet*cs;///限制输入类型 为float
        cs = [[NSCharacterSet characterSetWithCharactersInString:_customInput] invertedSet];
        NSString*filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest) {
            return NO;
        }
        _maxLength = _maxLength==0?5:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    else
    {
        _maxLength = _maxLength==0?10:_maxLength;
        if(textField.text.length+string.length>_maxLength)///限制长度
        {
            NSMutableString *str = [NSMutableString stringWithString:textField.text];
            [str replaceCharactersInRange:range withString:string];
            textField.text = [str substringToIndex:_maxLength];
            return NO;
        }
    }
    return YES;
}
- (NSString*)checkInput:(BOOL)checkInput
{
    _checkInput = checkInput;
    if(_checkInput)
    {
        [self setCellTitle:self.cellTitle];
    }
    return self.cellError;
}
- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
    [super setAccessoryType:accessoryType];
    if(accessoryType!=UITableViewCellAccessoryNone)
    {
        _cellTextField.width = FUll_SCREEN_WIDTH-4*GAP-_cellTitleLabel.width-_tailLabel.width-80;
    }
    else
    {
        _cellTextField.width = FUll_SCREEN_WIDTH-4*GAP-_cellTitleLabel.width-_tailLabel.width;
    }
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    super.userInteractionEnabled = userInteractionEnabled;
    if(userInteractionEnabled)
    {
        [self setCellNullable:NO];
        _cellTextField.placeholder = self.cellPlaceHolder;
    }
    else
    {
        [self setCellNullable:YES];
        _cellTextField.placeholder = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
@end
