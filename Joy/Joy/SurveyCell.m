//
//  SurveyCell.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SurveyCell.h"
#import "SurveyRate.h"

@interface SurveyCell ()

@property (readwrite) UIButton *voteButton;
@property (readwrite) NSMutableArray *labels;
@property (readwrite) NSMutableArray *checkButtons;
@property (readwrite) UILabel *titleLabel;
@property (readwrite) UILabel *endTimeLabel;

@end

@implementation SurveyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [titleView setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
        [self.contentView addSubview:titleView];
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 25, 25)];
        [iconImage setImage:[UIImage imageNamed:@"event"]];
        [self.contentView addSubview:iconImage];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 30)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor blackColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_titleLabel];
        
		_endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, self.frame.size.width - 20, 20)];
        [_endTimeLabel setBackgroundColor:[UIColor clearColor]];
        [_endTimeLabel setTextColor:[UIColor blackColor]];
        [_endTimeLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_endTimeLabel];
        //高度 120
		
		_voteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_voteButton setFrame:CGRectMake(230, 270, 70, 20)];
		
		_labels = [NSMutableArray array];
    }
    return self;
}

- (void)setSurvey:(Survey *)survey
{
    _survey = survey;
    _titleLabel.text = _survey.title;
    NSArray *surveyRates = _survey.surveyRates;
    BOOL hasAnswered = NO;
    NSDictionary *userAnsers = _survey.answers;
    NSArray *answerArray = [NSArray array];
    if (userAnsers) {
        hasAnswered = YES;
        answerArray = [userAnsers[@"Answers"] componentsSeparatedByString:@"^"];
    }
	
	NSMutableString *info = [NSMutableString stringWithFormat:@"截止日期:%@", _survey.endTime];
	if ([_survey isRadio]) {
		[info appendString:@"  单选"];
	} else {
		if (_survey.min) {
			[info appendFormat:@" 最少选%@项", _survey.min];
		}
		
		if (_survey.max) {
			[info appendFormat:@" 最多选%@项", _survey.max];
		}
	}
	
    _endTimeLabel.text = info;
	_checkButtons = [NSMutableArray array];
    //生成 buttons and label
    NSArray *questionArray = [survey.questions componentsSeparatedByString:@"^"];
    for (int i = 0; i < [questionArray count]; i ++) {
        UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkButton setFrame:CGRectMake(20, 55 + i * 25, 25, 25)];
		UIImage *normal;
		UIImage *selected;
		if ([_survey isRadio]) {
			normal = [UIImage imageNamed:@"widget_radio_n"];
			selected = [UIImage imageNamed:@"widget_radio_o"];
		} else {
			normal = [UIImage imageNamed:@"widget_checkbox_n"];
			selected = [UIImage imageNamed:@"widget_checkbox_o"];
		}
		[checkButton setBackgroundImage:normal forState:UIControlStateNormal];
		[checkButton setBackgroundImage:selected forState:UIControlStateSelected];
        [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:checkButton];
		[_checkButtons addObject:checkButton];
		
		if (_survey.bExpired) {
			checkButton.userInteractionEnabled = NO;
		}
        
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 55 + i * 25, 200, 25)];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setBackgroundColor:[UIColor clearColor]];
		
        if (hasAnswered) {
            BOOL selected = [answerArray[i] integerValue] == 1;
			
			BOOL exists = NO;
			for (int j = 0; j < surveyRates.count; j++) {
				SurveyRate *rate = surveyRates[j];
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
	
	UILabel *lastLabel = _labels.lastObject;
	CGRect frame = _voteButton.frame;
	frame.origin.y = CGRectGetMaxY(lastLabel.frame) + 5;
	_voteButton.frame = frame;
    [_voteButton setBackgroundColor:[UIColor secondaryColor]];
    [_voteButton setTitle:@"投票" forState:UIControlStateNormal];
    [_voteButton addTarget:self action:@selector(voteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_voteButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:_voteButton];
    if (hasAnswered) {
        [_voteButton setBackgroundColor:[UIColor grayColor]];
        [_voteButton setTitle:@"已投票" forState:UIControlStateNormal];
        [_voteButton setUserInteractionEnabled:NO];
    }
	
	if (_survey.bExpired) {
		[_voteButton setBackgroundColor:[UIColor grayColor]];
        [_voteButton setTitle:@"已过期" forState:UIControlStateNormal];
        [_voteButton setUserInteractionEnabled:NO];
	}
}

- (void)voteButtonClick
{
	NSMutableArray *votes = [NSMutableArray array];
	for (int i = 0; i < _checkButtons.count; i ++) {
		UIButton *button = _checkButtons[i];
		if ([button isSelected]) {
			[votes addObject:@"1"];
		} else {
			[votes addObject:@"0"];
		}
	}
	
	if ([self.delegate respondsToSelector:@selector(willSubmitSurvey:withVotes:)]) {
		[self.delegate willSubmitSurvey:_survey withVotes:votes];
	}
}

- (void)checkButtonClick:(UIButton *)sender
{
	if ([_survey isRadio]) {
		for (int i = 0; i < _checkButtons.count; i++) {
			UIButton *button = _checkButtons[i];
			button.selected = NO;
		}
		sender.selected = YES;
		return;
	}
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

+ (CGFloat)heightWithSurvey:(Survey *)survey;
{
	NSArray *questionArray = [survey.questions componentsSeparatedByString:@"^"];
	return MAX(questionArray.count * 30 + 60, 60);
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
