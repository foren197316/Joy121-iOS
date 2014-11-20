//
//  UIView+Joy.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "UIView+Joy.h"

@implementation UIView (Joy)

+ (instancetype)companyTitleViewWithURLString:(NSString *)URLString {
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
	[imageView setImageWithURL:[NSURL URLWithString:URLString]];
	return imageView;
}

@end
