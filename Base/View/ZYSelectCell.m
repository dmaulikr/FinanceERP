//
//  ZYSelectCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/4/8.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYSelectCell.h"

@interface ZYSelectCell()

//@property (assign, nonatomic) IBOutlet UILabel *cellTitleLabel;
//@property (assign, nonatomic) IBOutlet UILabel *cellTextLabel;

@property (strong, nonatomic) UILabel *cellTitleLabel;
@property (strong, nonatomic) UILabel *cellTextLabel;
@property(nonatomic,assign)BOOL checkInput;///检查是否为空
@end

@implementation ZYSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellError = @"";///初始化为空字符串 防止放入数组筛选出现错误
        
        _cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 100, [ZYSelectCell defaultHeight])];
        _cellTitleLabel.textAlignment = NSTextAlignmentRight;
        _cellTitleLabel.font = FONT(14);
        _cellTitleLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellTitleLabel];
        
        _cellTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cellTitleLabel.width+2*GAP, 0, FUll_SCREEN_WIDTH-_cellTitleLabel.width-3*GAP, [ZYSelectCell defaultHeight])];
        _cellTextLabel.font = FONT(12);
        _cellTextLabel.textColor = TITLE_COLOR;
        [self addSubview:_cellTextLabel];
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
        else if ([selecedObj isKindOfClass:[NSDate class]])
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            self.cellText = [formatter stringFromDate:selecedObj];
        }
        else if (self.showKey.length!=0)
        {
            self.cellText = [selecedObj valueForKey:self.showKey];
        }
    }
}

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLabel.text = cellTitle;
    if(!_cellNullable)
    {
        if(!_checkInput||(_checkInput&&_cellText.length!=0))///需要检查是否为空
        {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",cellTitle]];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
            _cellTitleLabel.attributedText = attrStr;
            self.cellError = @"";
        }
        else if(_cellText.length==0)
        {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"* %@",cellTitle]];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attrStr.length)];
            _cellTitleLabel.attributedText = attrStr;
            self.cellError = [NSString stringWithFormat:@"请选择%@",cellTitle];
        }
    }
    else
    {
        _cellTitleLabel.text = cellTitle;
        self.cellError = @"";
    }
}
- (void)setCellText:(NSString *)cellText
{
    _cellText = cellText;
    _cellTextLabel.text = cellText;
    if(_checkInput)
    {
        [self setCellTitle:self.cellTitle];
    }
}
- (void)setCellNullable:(BOOL)cellNullable
{
    _cellNullable = cellNullable;
    [self setCellTitle:_cellTitle];
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
- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    super.userInteractionEnabled = userInteractionEnabled;
    if(userInteractionEnabled)
    {
        [self setCellNullable:NO];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        [self setCellNullable:YES];
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}
@end
