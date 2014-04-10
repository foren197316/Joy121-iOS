//
//  OrderCell.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "OrderCell.h"
#import "WelInfo.h"
#import "UIImageView+AFNetWorking.h"

@implementation OrderCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}

- (void)setInfo:(OrderInfo *)info
{
    _info = info;
    _orderNoLabel.text = [NSString stringWithFormat:@"订单:%@", _info.orderNo];
    _countLabel.text = [NSString stringWithFormat:@"共%d件", [_info.welArrays count]];
    _scoreLabel.text = [NSString stringWithFormat:@"积分:%@", _info.score];
    if ([_info.welArrays count] > 0) {
        WelInfo *welInfo = _info.welArrays[0];
        [_goodsImageView setImageWithURL:[NSURL URLWithString:welInfo.headPic]];
    }
    _orderDateLabel.text = _info.createTime;
}

@end
