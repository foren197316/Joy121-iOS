//
//  Module.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "Module.h"

@implementation Module

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = attributes[@"ModuleId"];
		_name = attributes[@"ModuleName"];
	}
	return self;
}

@end
