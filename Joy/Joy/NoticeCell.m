//
//  NoticeCell.m
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "NoticeCell.h"

static CGFloat height = 130;

@interface NoticeCell ()

@property (readwrite) UITextView *textView;
@property (readwrite) UILabel *titleLabel;
@property (readwrite) UILabel *postTimeLabel;
@property (readwrite) UIImageView *iconView;

@end

@implementation NoticeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        [titleView setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
        [self.contentView addSubview:titleView];
        
		_iconView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 2, 25, 25)];
        [self.contentView addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 30)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor orangeColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_titleLabel];
        
        _postTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 80, 30)];
        [_postTimeLabel setBackgroundColor:[UIColor clearColor]];
        [_postTimeLabel setTextColor:[UIColor orangeColor]];
        [_postTimeLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_postTimeLabel];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 100)];
        [_textView setUserInteractionEnabled:NO];
        [self.contentView addSubview:_textView];
    }
    return self;
}

- (CGFloat)height
{
    return height;
}

- (void)setNotice:(Notice *)notice
{
    _notice = notice;
    [_titleLabel setText:notice.title];
    [_postTimeLabel setText:notice.postTime];
    
    [_textView setText:[NSString stringWithFormat:@"%@", notice.content]];
    [_textView setFrame:CGRectMake(0, 30, [self contentSizeOfTextView:_textView].width, [self contentSizeOfTextView:_textView].height)];
    height = [self contentSizeOfTextView:_textView].height + 30;
}

- (void)setBExpired:(BOOL)bExpired
{
	_bExpired = bExpired;
	_iconView.image = _bExpired ? [UIImage imageNamed:@"NoticeExpired"] : [UIImage imageNamed:@"Notice"];
}

- (CGSize)contentSizeOfTextView:(UITextView *)tView
{
    CGSize textViewSize = [tView sizeThatFits:CGSizeMake(tView.frame.size.width, FLT_MAX)];
    return textViewSize;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
