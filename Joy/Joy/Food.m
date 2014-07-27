//
//  Food.m
//  Joy
//
//  Created by zhangbin on 7/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "Food.h"

@implementation Food

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_imageName = attributes[@"image"];
	_name = attributes[@"name"];
	_describe = attributes[@"describe"];
	_price = attributes[@"price"];
	
	return self;
}

@end
