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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(WelInfo *)info
{
    _info = info;
    _nameLabel.text = [NSString stringWithFormat:@"【%@】%@", _info.welName, _info.shortDescribe];
    _describeTextView.text = _info.longDescribe;
    [_iconImageView setImageWithURL:[NSURL URLWithString:info.headPic]];
}

- (IBAction)buyButtonClick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(buyButtonClicked:)]) {
        [self.delegate buyButtonClicked:_info];
    }
}
@end
