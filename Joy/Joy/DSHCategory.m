//
//  DSHCategory.m
//  dushuhu
//
//  Created by zhangbin on 3/27/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHCategory.h"
#import "DSHGoods.h"

@implementation DSHCategory

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
{
	self = [self init];
	if (self) {
		_categoryID = attributes[@"Id"];
		_name = attributes[@"CategoryName"];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<_categoryID: %@>", _categoryID];
}

@end
