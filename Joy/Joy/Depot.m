//
//  Depot.m
//  Joy
//
//  Created by zhangbin on 11/17/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "Depot.h"

@implementation Depot

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = attributes[@"Id"];
		_name = attributes[@"Name"];
		_number = attributes[@"CurrentNumber"];
		_imagePath = attributes[@"Pictures"];
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"< ID: %@, name: %@>", _ID, _name];
}

@end
