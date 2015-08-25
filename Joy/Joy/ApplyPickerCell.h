//
//  ApplyPickerCell.h
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyCommondCell.h"

typedef void (^PickerUpdateHandler)(UIButton *button);
typedef void (^ClickHandler)();

@interface ApplyPickerCell : ApplyCommondCell

@property (nonatomic, strong) UIButton *pickerButton;

- (instancetype)initWithLabelString:(NSString *)labelString
                         labelImage:(UIImage *)labelImage
                      updateHandler:(PickerUpdateHandler)updateHandler
                       clickHandler:(ClickHandler)clickHandler;

@end
