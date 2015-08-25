//
//  ApplyCommondCell.h
//  Joy
//
//  Created by gejw on 15/8/25.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Picker,
    TextFiled,
    Image,
    Radio
} ApplyCellType;

typedef struct {
    __unsafe_unretained UIImage *icon;
    __unsafe_unretained UILabel *label;
    ApplyCellType type;
}CellItem;

@interface ApplyCommondCell : UITableViewCell

@property (nonatomic, strong) NSString *labelString;

@property (nonatomic, strong) UIImage *labelImage;

@property (nonatomic, strong) UILabel *labelLabel;

@property (nonatomic, strong) UIImageView *labelImageView;

@property (nonatomic, assign) float height;

- (instancetype)initWithLabelString:(NSString *)labelString
                         labelImage:(UIImage *)labelImage
                    reuseIdentifier:(NSString *)reuseIdentifier;

- (void)initViews;

- (void)updateView;

@end
