//
//  ZYHomePageEventCell.m
//  FinanceERP
//
//  Created by zhangyu on 16/3/28.
//  Copyright © 2016年 张昱. All rights reserved.
//

#import "ZYHomePageEventCell.h"

@interface ZYHomePageEventCell ()

//@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (strong, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) ZYWarningEvent *event;
@end

@implementation ZYHomePageEventCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _eventLabel = [[UILabel alloc] initWithFrame:CGRectMake(GAP, 0, FUll_SCREEN_WIDTH-2*GAP, [ZYHomePageEventCell defaultHeight])];
        _eventLabel.font = FONT(12);
        _eventLabel.textColor = ORANGE;
        _eventLabel.text = _event.project_name;
        [self addSubview:_eventLabel];
    }
    return self;
}

+ (CGFloat)defaultHeight
{
    return 20.f;
}
- (void)loadDataSource:(ZYWarningEvent*)event
{
    _event = event;
    _eventLabel.text = event.project_name;
}
@end
