//
//  ApplyImageCell.m
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "ApplyImageCell.h"

@interface ApplyImageCell () {
    ImageUpdateHandler _updateHandler;
    ImageClickHandler _clickHandler;
    NSString *_hintString;
    int _num;
    
    UIImageView *_imageView;
    UIImageView *_imageView2;
}

@end

@implementation ApplyImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithLabelString:(NSString *)labelString
                         labelImage:(UIImage *)labelImage
                         hintString:(NSString *)hintString
                                num:(int)num
                      updateHandler:(ImageUpdateHandler)updateHandler
                      clickHandler:(ImageClickHandler)clickHandler {
    _updateHandler = updateHandler;
    _clickHandler = clickHandler;
    _num = num;
    _hintString = hintString;
    self.height = 100;
    self = [super initWithLabelString:labelString labelImage:labelImage reuseIdentifier:@"imageCell"];
    if (self) {
    }
    return self;
}

- (void)initViews {
    [super initViews];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.labelLabel.x, self.labelLabel.y + 25, self.labelLabel.width, 50)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed: 0.6764 green: 0.6765 blue: 0.6765 alpha: 1.0];
    label.numberOfLines = 2;
    label.text = _hintString;
    [self.contentView addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.labelLabel.right + 10, 15, 80, 60)];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.width, button.height)];
    _imageView.contentMode = UIViewContentModeScaleToFill;
    _imageView.image = [UIImage imageNamed:@"image_add"];
    [button addSubview:_imageView];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(button.right + 5, button.y, button.width, button.height)];
    [button2 addTarget:self action:@selector(clickButton2:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button2];
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.width, button.height)];
    _imageView2.contentMode = UIViewContentModeScaleToFill;
    _imageView2.image = [UIImage imageNamed:@"image_add"];
    [button2 addSubview:_imageView2];
    if (_num == 1) {
        button2.hidden = YES;
    } else if (_num > 1) {
        button2.hidden = NO;
    }
}

- (void)updateView {
    _updateHandler(_imageView, _imageView2);
}

- (void)clickButton:(id)sender {
    _clickHandler(_imageView, 0);
}

- (void)clickButton2:(id)sender {
    _clickHandler(_imageView2, 1);
}

@end
