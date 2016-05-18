//
//  ZYForeclosureHouseApplicationContentCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/20.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYForeclosureHouseApplicationContentCell.h"

@interface ZYForeclosureHouseApplicationContentCell()<UITextViewDelegate>

@property(nonatomic,strong)UITextView *textContent;
@property(nonatomic,strong)UILabel *cellTitleLabel;

@end

@implementation ZYForeclosureHouseApplicationContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 100, 44)];
        _cellTitleLabel.font = FONT(14);
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellTitleLabel];
        
        _textContent = [[UITextView alloc] initWithFrame:CGRectMake(_cellTitleLabel.width+2*GAP, GAP, FUll_SCREEN_WIDTH-(_cellTitleLabel.width+2*GAP), [ZYForeclosureHouseApplicationContentCell defaultHeight]-2*GAP)];
        _textContent.delegate = self;
        [self addSubview:_textContent];
        
        RACChannelTo(_textContent,text) = RACChannelTo(self,cellContent);
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
- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;
}
+ (CGFloat)defaultHeight
{
    return 120.f;
}
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    super.userInteractionEnabled = userInteractionEnabled;
    if(userInteractionEnabled)
    {
        _textContent.textColor = TITLE_COLOR;
    }
    else
    {
        _textContent.textColor = TEXT_COLOR;
    }
}
@end
