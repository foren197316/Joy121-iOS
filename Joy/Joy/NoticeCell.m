//
//  NoticeCell.m
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "NoticeCell.h"

static CGFloat height = 130;

@implementation NoticeCell {
    UITextView *textView;
    UILabel *titleLabel;
    UILabel *postTimeLabel;
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
        [iconImage setImage:[UIImage imageNamed:@"notice"]];
        [self.contentView addSubview:iconImage];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 30)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextColor:[UIColor orangeColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:titleLabel];
        
        postTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 80, 30)];
        [postTimeLabel setBackgroundColor:[UIColor clearColor]];
        [postTimeLabel setTextColor:[UIColor orangeColor]];
        [postTimeLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:postTimeLabel];
        
        textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 100)];
        [textView setUserInteractionEnabled:NO];
        [self.contentView addSubview:textView];
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
    [titleLabel setText:notice.title];
    [postTimeLabel setText:notice.postTime];
    
    [textView setText:[NSString stringWithFormat:@"%@\n%@\n%@\n%@\n", notice.content, notice.content, notice.content, notice.content]];
    [textView setFrame:CGRectMake(0, 30, [self contentSizeOfTextView:textView].width, [self contentSizeOfTextView:textView].height)];
    height = [self contentSizeOfTextView:textView].height + 30;
}

- (CGSize)contentSizeOfTextView:(UITextView *)tView
{
    CGSize textViewSize = [tView sizeThatFits:CGSizeMake(tView.frame.size.width, FLT_MAX)];
    return textViewSize;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
