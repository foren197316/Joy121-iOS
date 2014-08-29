//
//  EventCell.m
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "EventCell.h"

static CGFloat height = 130;

@interface EventCell ()

@property (readwrite) UILabel *titleLabel;
@property (readwrite) UIImageView *thumbView;
@property (readwrite) UIImageView *iconView;
@property (readwrite) UILabel *startTimeLabel;
@property (readwrite) UILabel *endTimeLabel;
@property (readwrite) UILabel *locationLabel;
@property (readwrite) UILabel *countLabel;
@property (readwrite) UIButton *joinButton;

@end

@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [titleView setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
        [self.contentView addSubview:titleView];
        
		_iconView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 25, 25)];
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 30)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_titleLabel];
        
        _thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32.5, 140, 95)];
        [_thumbView setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:_thumbView];
        
        NSMutableArray *labelsArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(145, 30 + 20 * i, 175, 20)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor lightGrayColor]];
            [label setFont:[UIFont systemFontOfSize:11]];
            [self.contentView addSubview:label];
            [labelsArray addObject:label];
        }
        _startTimeLabel = labelsArray[0];
        _locationLabel = labelsArray[1];
        _endTimeLabel = labelsArray[2];
        _countLabel = labelsArray[3];
        
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_joinButton setBackgroundColor:[UIColor secondaryColor]];
        [_joinButton setFrame:CGRectMake(240, 110, 70, 20)];
        [_joinButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_joinButton setTitle:@"报名" forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(joinButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_joinButton];
    }
    return self;
}

- (void)joinButtonClick
{
    if ([self.delegate respondsToSelector:@selector(joinButtonClicked:)]) {
        [self.delegate joinButtonClicked:_event];
    }
}

- (void)setEvent:(Event *)event
{
    _event = event;
	
	[_joinButton setTitle:[_event status] forState:UIControlStateNormal];
    [_titleLabel setText:_event.title];
	_joinButton.backgroundColor = [_event isEnabled] ? [UIColor secondaryColor] : [UIColor grayColor];
	_joinButton.userInteractionEnabled = [_event isEnabled];
    [_thumbView setImageWithURL:[NSURL URLWithString:event.iconUrl]];
    _startTimeLabel.text = [NSString stringWithFormat:@"活动开始时间:%@", event.startTime];
    _endTimeLabel.text = [NSString stringWithFormat:@"报名截止时间:%@", event.endTime];
    _locationLabel.text = [NSString stringWithFormat:@"活动地点:%@", event.location];
    _countLabel.text = [NSString stringWithFormat:@"已报名人数/报名人数限制:%@/%@", event.joinCount, event.limitCount];
}

- (void)setBExpired:(BOOL)bExpired
{
	_bExpired = bExpired;
	_iconView.image = _bExpired ? [UIImage imageNamed:@"EventExpired"] : [UIImage imageNamed:@"Event"];
}

- (BOOL)hadJoined
{
	return [_event.loginName isEqualToString:[[JAFHTTPClient shared] userName]];
}

- (CGFloat)height
{
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
