//
//  ApplyTextFiledCell.m
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "ApplyTextFiledCell.h"

@interface ApplyTextFiledCell () {
    TextFiledUpdateHandler _updateHandler;
    TextFiledChangeHandler _changeHandler;
}

@end

@implementation ApplyTextFiledCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithLabelString:(NSString *)labelString
                         labelImage:(UIImage *)labelImage
                      updateHandler:(TextFiledUpdateHandler)updateHandler
                      changeHandler:(TextFiledChangeHandler)changeHandler {
    _updateHandler = updateHandler;
    _changeHandler = changeHandler;
    self.height = 50;
    self = [super initWithLabelString:labelString labelImage:labelImage reuseIdentifier:@"textiledcell"];
    if (self) {
    }
    return self;
}

- (void)initViews {
    [super initViews];
    
    _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(self.labelLabel.right + 5, 15, winSize.width - self.labelLabel.right - 20, 20)];
    _textFiled.textColor = [UIColor blackColor];
    _textFiled.font = [UIFont systemFontOfSize:15];
    [_textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textFiled];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorWithRed:0.84 green:0.91 blue:0.96 alpha:1].CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, _textFiled.height - 0.5, _textFiled.width, 0.5)].CGPath;
    border.lineWidth = .5f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@6, @6];
    [_textFiled.layer addSublayer:border];
}

- (void)textFieldDidChange:(UITextField *)textField{
    _changeHandler(textField.text);
}

- (void)updateView {
    _updateHandler(_textFiled);
}

@end
