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
		_categoryID = attributes[@"category_id"];
		_name = attributes[@"category_name"];
		_URLString = attributes[@"category_url"];
//		NSString *colorString = attributes[@"category_color"];
//		if (colorString) {
//			_color = [UIColor hexRGB:[colorString hexUInteger]];
//		}
		_multiGoods = [DSHGoods multiWithAttributesArray:attributes[@"category_goods"]];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<_categoryID: %@>", _categoryID];
}

@end
