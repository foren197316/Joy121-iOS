//
//  UIColor+Joy.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "UIColor+Joy.h"
#import "JAFHTTPClient.h"

@implementation UIColor (Joy)

+ (instancetype)themeColor;
{
	if ([JAFHTTPClient isTommy]) {//TODO:
		return [UIColor colorWithRed:9/255.0 green:22/255.0 blue:77/255.0 alpha:1.0];
	}
	return [UIColor colorWithRed:244.0/255.0 green:123.0/255.0 blue:41.0/255.0 alpha:1.0];
}

+ (instancetype)secondaryColor
{
	if ([JAFHTTPClient isTommy]) {//TODO:
		return [UIColor colorWithRed:0/255.0 green:191/255.0 blue:0/255.0 alpha:1.0];
	}
	return [UIColor blackColor];
}

@end
