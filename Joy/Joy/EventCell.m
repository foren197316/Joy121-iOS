//
//  EventCell.m
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "EventCell.h"
#import "UIImageView+AFNetworking.h"

static CGFloat height = 130;

@implementation EventCell {
    UILabel *titleLabel;
    UIImageView *iconImageView;
    UILabel *startTimeLabel;
    UILabel *locationLabel;
    UILabel *endTimeLabel;
    UILabel *countLabel;
    UIButton *joinButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [titleView setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
        [self.contentView addSubview:titleView];
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
        [iconImage setImage:[UIImage imageNamed:@"event"]];
        [self.contentView addSubview:iconImage];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 30)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor orangeColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:titleLabel];
        
        iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32.5, 140, 95)];
        [iconImageView setBackgroundColor:[UIColor grayColor]];
        [self.contentView addSubview:iconImageView];
        
        NSMutableArray *labelsArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(145, 30 + 20 * i, 175, 20)];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setTextColor:[UIColor lightGrayColor]];
            [label setFont:[UIFont systemFontOfSize:11]];
            [self.contentView addSubview:label];
            [labelsArray addObject:label];
        }
        startTimeLabel = labelsArray[0];
        locationLabel = labelsArray[1];
        endTimeLabel = labelsArray[2];
        countLabel = labelsArray[3];
        
        joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [joinButton setBackgroundColor:[UIColor orangeColor]];
        [joinButton setFrame:CGRectMake(240, 110, 70, 20)];
        [joinButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [joinButton setTitle:@"报名" forState:UIControlStateNormal];
        [joinButton addTarget:self action:@selector(joinButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:joinButton];
    }
    return self;
}

- (void)joinButtonClick
{
    NSLog(@"加入!!!");
    if ([self.delegate respondsToSelector:@selector(joinButtonClicked:)]) {
        [self.delegate joinButtonClicked:_event];
    }
}

- (void)setEvent:(Event *)event
{
    _event = event;
    [titleLabel setText:_event.title];
    [iconImageView setImageWithURL:[NSURL URLWithString:event.iconUrl]];
    startTimeLabel.text = [NSString stringWithFormat:@"活动开始时间:%@", event.startTime];
    endTimeLabel.text = [NSString stringWithFormat:@"报名截止时间:%@", event.endTime];
    locationLabel.text = [NSString stringWithFormat:@"活动地点:%@", event.location];
    countLabel.text = [NSString stringWithFormat:@"已报名人数/报名人数限制:%@/%@", event.joinCount, event.limitCount];
}

- (CGFloat)height
{
    return height;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
