//
//  ZYHomePageWarningEventTitleCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageWarningEventTitleCell.h"

@interface ZYHomePageWarningEventTitleCell ()

//@property (weak, nonatomic) IBOutlet UILabel *eventCountLabel;

@property (strong, nonatomic)UILabel *eventCountLabel;
@property (strong, nonatomic)UILabel *titleLabel;

@end

@implementation ZYHomePageWarningEventTitleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, 60, [ZYHomePageWarningEventTitleCell defaultHeight])];
        _titleLabel.text = @"预警事项";
        _titleLabel.textColor = BLUE;
        _titleLabel.font = FONT(14);
        [self addSubview:_titleLabel];
        
        _eventCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(2*GAP+_titleLabel.width, 0, FUll_SCREEN_WIDTH-_titleLabel.width-3*GAP, [ZYHomePageWarningEventTitleCell defaultHeight])];
        _eventCountLabel.textColor = ORANGE;
        _eventCountLabel.textAlignment = NSTextAlignmentRight;
        _eventCountLabel.text = [NSString stringWithFormat:@"共(%ld)条",(long)_eventCount];
        _eventCountLabel.font = FONT(14);
        [self addSubview:_eventCountLabel];
    }
    return self;
}
- (void)setEventCount:(NSInteger)eventCount
{
    _eventCount = eventCount;
    _eventCountLabel.text = [NSString stringWithFormat:@"共(%ld)条",(long)eventCount];
}

@end
