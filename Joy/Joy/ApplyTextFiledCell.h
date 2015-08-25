//
//  ApplyTextFiledCell.h
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyCommondCell.h"

typedef void (^TextFiledUpdateHandler)(UITextField *textFiled);
typedef void (^TextFiledChangeHandler)(NSString *string);

@interface ApplyTextFiledCell : ApplyCommondCell

@property (nonatomic, strong) UITextField *textFiled;

- (instancetype)initWithLabelString:(NSString *)labelString
                         labelImage:(UIImage *)labelImage
                      updateHandler:(TextFiledUpdateHandler)updateHandler
                      changeHandler:(TextFiledChangeHandler)changeHandler;

@end
