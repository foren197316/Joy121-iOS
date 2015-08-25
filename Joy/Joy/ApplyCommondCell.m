//
//  ApplyCommondCell.m
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "ApplyCommondCell.h"

@interface ApplyCommondCell () {
}

@end

@implementation ApplyCommondCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithLabelString:(NSString *)labelString
                          labelImage:(UIImage *)labelImage
                    reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _labelString = labelString;
        _labelImage = labelImage;
        [self initViews];
    }
    return self;
}

- (void)initViews {
    _labelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 25, 20)];
    _labelImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_labelImageView];
    
    _labelLabel = [[UILabel alloc] initWithFrame:CGRectMake(_labelImageView.right + 5, 0, 0, 50)];
    _labelLabel.textColor = [UIColor colorWithRed:0.4 green:0.51 blue:0.61 alpha:1];
    _labelLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelLabel];
    
    _labelImageView.image = _labelImage;
    _labelLabel.text = _labelString;
    CGSize textSize = [_labelLabel.text calcTextSize:CGSizeZero font:_labelLabel.font];
    _labelLabel.frame = CGRectMake(_labelLabel.x, _labelLabel.y, textSize.width, _labelLabel.height);
}

- (void)updateView {
    
}

@end
