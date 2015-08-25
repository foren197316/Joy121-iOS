//
//  ApplyPickerCell.m
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "ApplyPickerCell.h"


@interface ApplyPickerCell () {
    PickerUpdateHandler _updateHandler;
    ClickHandler _clickHandler;
}

@end

@implementation ApplyPickerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithLabelString:(NSString *)labelString
                         labelImage:(UIImage *)labelImage
                      updateHandler:(PickerUpdateHandler)updateHandler
                       clickHandler:(ClickHandler)clickHandler {
    _updateHandler = updateHandler;
    _clickHandler = clickHandler;
    self.height = 50;
    self = [super initWithLabelString:labelString labelImage:labelImage reuseIdentifier:@"pickercell"];
    if (self) {
    }
    return self;
}

- (void)initViews {
    [super initViews];
    
    _pickerButton = [[UIButton alloc] initWithFrame:CGRectMake(self.labelLabel.right + 5, 15, winSize.width - self.labelLabel.right - 20, 20)];
    [_pickerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _pickerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_pickerButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_pickerButton];
}

- (void)updateView {
    _updateHandler(_pickerButton);
}

- (void)clickButton:(id)sender {
    _clickHandler();
}

@end
