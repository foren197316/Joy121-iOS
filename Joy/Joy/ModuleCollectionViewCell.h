//
//  ModelCollectionViewCell.h
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Module.h"

@interface ModuleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) Module *module;
@property (nonatomic, strong) UIImage *icon;

+ (CGSize)size;

@end
