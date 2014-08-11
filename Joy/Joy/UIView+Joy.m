//
//  UIView+Joy.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "UIView+Joy.h"

@implementation UIView (Joy)

+ (instancetype)tommyTitleView
{
	UIImage *image = [UIImage imageNamed:@"TommyLogo"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];	
	return imageView;
}

@end
