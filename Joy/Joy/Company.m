//
//  Company.m
//  Joy
//
//  Created by zhangbin on 7/7/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_identifier = attributes[@"Company"];
		_name = attributes[@"CompName"];
		_address = attributes[@"CompAddr"];
		_phoneNumber = attributes[@"CompPhone"];
	}
	return self;
}

@end
