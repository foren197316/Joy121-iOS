//
//  ModelCollectionViewCell.h
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Module.h"

@interface ModelCollectionViewCell : UICollectionViewCell

+ (CGSize)size;

@property (nonatomic, strong) Module *module;
@property (nonatomic, strong) UIImage *icon;//TODO: maybe useless if server return icon url

@end
