//
//  ApplyImageCell.h
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyCommondCell.h"

typedef void (^ImageUpdateHandler)(UIImageView *imageView, UIImageView *imageView2);
typedef void (^ImageClickHandler)(UIImageView *imageView, int indexSelect);

@interface ApplyImageCell : ApplyCommondCell

- (instancetype)initWithLabelString:(NSString *)labelString
                         labelImage:(UIImage *)labelImage
                         hintString:(NSString *)hintString
                                num:(int)num
                      updateHandler:(ImageUpdateHandler)updateHandler
                      clickHandler:(ImageClickHandler)clickHandler;

@end
