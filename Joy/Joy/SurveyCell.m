//
//  SurveryCell.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SurveyCell.h"
#import "SurveyRate.h"

static CGFloat height = 300;
#define VOTE_BUTTON_TAG  1000

@interface SurveyCell ()

@property (readwrite) UIButton *voteButton;
@property (readwrite) NSMutableArray *labels;

@end

@implementation SurveyCell {
    UILabel *titleLabel;
    UILabel *endTimeLabel;
    NSMutableString *voteString;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        voteString = [@"" mutableCopy];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [titleView setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
        [self.contentView addSubview:titleView];
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 25, 25)];
        [iconImage setImage:[UIImage imageNamed:@"event"]];
        [self.contentView addSubview:iconImage];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 30)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor themeColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:titleLabel];
        
		endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
        [endTimeLabel setBackgroundColor:[UIColor clearColor]];
        [endTimeLabel setTextColor:[UIColor blackColor]];
        [endTimeLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:endTimeLabel];
        //高度 120
		
		_voteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_voteButton setFrame:CGRectMake(230, 270, 70, 20)];
		
		_labels = [NSMutableArray array];
    }
    return self;
}

- (void)setSurvery:(Survey *)survery
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
        [checkButton setFrame:CGRectMake(20, 55 + i * 25, 25, 25)];
        [checkButton setBackgroundImage:[UIImage imageNamed:@"widget_checkbox_n"] forState:UIControlStateNormal];
        [checkButton setBackgroundImage:[UIImage imageNamed:@"widget_checkbox_o"] forState:UIControlStateSelected];
        [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:checkButton];
		
		if (_survery.bExpired) {
			checkButton.userInteractionEnabled = NO;
		}
        
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 55 + i * 25, 200, 25)];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setBackgroundColor:[UIColor clearColor]];
		
        if (hasAnswered) {
            BOOL selected = [answerArray[i] integerValue] == 1;
			
			BOOL exists = NO;
			for (int j = 0; j < surveryRates.count; j++) {
				SurveyRate *rate = surveryRates[j];
				if (rate.questionIndex.integerValue == i) {
					label.text = [NSString stringWithFormat:@"%@ (%@%@)", questionArray[i], rate.ratedCount, NSLocalizedString(@"票", nil)];
					exists = YES;
					break;
				}
			}
			
			if (!exists) {
				label.text = [NSString stringWithFormat:@"%@ (%@%@)", questionArray[i], @(0), NSLocalizedString(@"票", nil)];
			}
            [checkButton setSelected:selected];
            [checkButton setUserInteractionEnabled:NO];
        } else {
            [label setText:[NSString stringWithFormat:@"%@", questionArray[i]]];
        }
        [self.contentView addSubview:label];
		[_labels addObject:label];
    }
    
    [_voteButton setBackgroundColor:[UIColor themeColor]];
    [_voteButton setTitle:@"投票" forState:UIControlStateNormal];
    [_voteButton addTarget:self action:@selector(voteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_voteButton setTag:VOTE_BUTTON_TAG];
    [_voteButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_voteButton];
    if (hasAnswered) {
        [_voteButton setBackgroundColor:[UIColor grayColor]];
        [_voteButton setTitle:@"已投票" forState:UIControlStateNormal];
        [_voteButton setUserInteractionEnabled:NO];
    }
	
	if (_survery.bExpired) {
		[_voteButton setBackgroundColor:[UIColor grayColor]];
        [_voteButton setTitle:@"已过期" forState:UIControlStateNormal];
        [_voteButton setUserInteractionEnabled:NO];
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

- (void)prepareForReuse
{
	[super prepareForReuse];
	for (UILabel *label in _labels) {
		[label removeFromSuperview];
	}
	[_labels removeAllObjects];
}

@end
