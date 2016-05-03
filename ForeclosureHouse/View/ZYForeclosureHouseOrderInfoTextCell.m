//
//  ZYForeclosureHouseOrderInfoTextCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/19.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseOrderInfoTextCell.h"

@interface ZYForeclosureHouseOrderInfoTextCell()<UITextViewDelegate>
//@property (weak, nonatomic) IBOutlet UITextView *cellTextView;
@property (strong, nonatomic) UITextView *cellTextView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation ZYForeclosureHouseOrderInfoTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat titleHeight = 12;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, GAP, FUll_SCREEN_WIDTH-2*GAP, titleHeight)];
        _titleLabel.font = FONT(12);
        _titleLabel.numberOfLines = 1;
        _titleLabel.textColor = TITLE_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
        _cellTextView = [[UITextView alloc] initWithFrame:CGRectMake(GAP, titleHeight+2*GAP, FUll_SCREEN_WIDTH-2*GAP, [ZYForeclosureHouseOrderInfoTextCell defaultHeight]-3*GAP-titleHeight)];
        _cellTextView.delegate = self;
        RACChannelTo(_cellTextView,text) = RACChannelTo(self,cellText);
        [self addSubview:_cellTextView];
    }
    return self;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    _maxLength = _maxLength==0?100:_maxLength;
    if(textView.text.length+text.length>_maxLength)///限制长度
    {
        NSMutableString *str = [NSMutableString stringWithString:textView.text];
        [str replaceCharactersInRange:range withString:text];
        textView.text = [str substringToIndex:_maxLength];
        return NO;
    }
    return YES;
}
+ (CGFloat)defaultHeight
{
    return 100;
}
- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    if(self.userInteractionEnabled)
    {
        [_cellTextView becomeFirstResponder];
    }
    return YES;
}
- (void)setCellTitle:(NSString *)cellTitle
{
    _titleLabel.text = cellTitle;
    _cellTitle = cellTitle;
}

@end
