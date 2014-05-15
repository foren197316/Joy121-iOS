//
//  SurveryCell.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SurveryCell.h"

static CGFloat height = 300;
#define VOTE_BUTTON_TAG  1000

@implementation SurveryCell {
    UILabel *titleLabel;
    UILabel *endTimeLabel;
    NSMutableString *voteString;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        voteString = [@"" mutableCopy];
        
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
        
         endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
        [endTimeLabel setBackgroundColor:[UIColor clearColor]];
        [endTimeLabel setTextColor:[UIColor blackColor]];
        [endTimeLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:endTimeLabel];
        //高度 120
        
        
    }
    return self;
}

- (void)setSurvery:(Survery *)survery
{
    _survery = survery;
    titleLabel.text = _survery.title;
    NSArray *surveryRates = _survery.surveyRates;
    BOOL hasAnswered = NO;
    NSDictionary *userAnsers = _survery.answers;
    NSArray *answerArray = [NSArray array];
    if (userAnsers) {
        hasAnswered = YES;
        answerArray = [userAnsers[@"Answers"] componentsSeparatedByString:@"^"];
    }
    endTimeLabel.text = [NSString stringWithFormat:@"截止日期:%@", _survery.endTime];
    //生成 buttons and label
    NSArray *questionArray = [survery.questions componentsSeparatedByString:@"^"];
    for (int i = 0; i < [questionArray count]; i ++) {
        UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkButton setFrame:CGRectMake(60, 55 + i * 25, 25, 25)];
        [checkButton setBackgroundImage:[UIImage imageNamed:@"widget_checkbox_n"] forState:UIControlStateNormal];
        [checkButton setBackgroundImage:[UIImage imageNamed:@"widget_checkbox_o"] forState:UIControlStateSelected];
        [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:checkButton];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 55 + i * 25, 200, 25)];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setBackgroundColor:[UIColor clearColor]];
        if (hasAnswered) {
            BOOL selected = [answerArray[i] integerValue] == 1;
            [label setText:[NSString stringWithFormat:@"%@ (%@票)", questionArray[i], surveryRates[i][@"Rate"]]];
            [checkButton setSelected:selected];
            [checkButton setUserInteractionEnabled:NO];
        } else {
            [label setText:[NSString stringWithFormat:@"%@", questionArray[i]]];
        }
        [self.contentView addSubview:label];
    }
    
    UIButton *voteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voteButton setFrame:CGRectMake(230, 270, 70, 20)];
    [voteButton setBackgroundColor:[UIColor orangeColor]];
    [voteButton setTitle:@"投票" forState:UIControlStateNormal];
    [voteButton addTarget:self action:@selector(voteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [voteButton setTag:VOTE_BUTTON_TAG];
    [voteButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:voteButton];
    if (hasAnswered) {
        [voteButton setBackgroundColor:[UIColor grayColor]];
        [voteButton setTitle:@"已投票" forState:UIControlStateNormal];
        [voteButton setUserInteractionEnabled:NO];
    }
}

- (void)voteButtonClick
{
    BOOL first = YES;
    [voteString setString:@""];
    for (int i = 0; i < [[self.contentView subviews] count]; i ++) {
        id view = [self.contentView subviews][i];
        if ([view isKindOfClass:[UIButton class]] && [view tag] != VOTE_BUTTON_TAG) {
            if (!first) {
                [voteString appendString:@"^"];
            } else {
                first = NO;
            }
            if ([view isSelected]) {
                [voteString appendString:@"1"];
            } else {
                [voteString appendString:@"0"];
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(voteButtonClicked:andSurvery:)]) {
        [self.delegate voteButtonClicked:voteString andSurvery:_survery];
    }
}

- (void)checkButtonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
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
