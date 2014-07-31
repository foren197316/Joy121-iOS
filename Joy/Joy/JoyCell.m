//
//  JoyCell.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "JoyCell.h"
#import "UIImageView+AFNetWorking.h"

@implementation JoyCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setInfo:(WelInfo *)info
{
    _info = info;
	_nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.text = [NSString stringWithFormat:@"%@", _info.welName];
	
	_describeLabel.font = [UIFont systemFontOfSize:14];
    _describeLabel.text = _info.longDescribe;
	
	_scoreLabel.font = [UIFont systemFontOfSize:13];
	_scoreLabel.text = [NSString stringWithFormat:@"%@:%@", NSLocalizedString(@"所需积分", nil), _info.score];
    [_iconImageView setImageWithURL:[NSURL URLWithString:info.headPic]];
}

- (IBAction)buyButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(buyButtonClicked:)]) {
        [self.delegate buyButtonClicked:_info];
    }
}
@end
