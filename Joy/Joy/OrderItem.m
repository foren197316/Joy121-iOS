//
//  OrderItem.m
//  Joy
//
//  Created by zhangbin on 7/29/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "OrderItem.h"
#import "JAFHTTPClient.h"

@implementation OrderItem

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super init];
	if (self) {
		_name = attributes[@"ProductName"];
		if (attributes[@"ProductPicture"]) {
			NSString *host = [JAFHTTPClient shared].baseURL.absoluteString;
			_imageULRString = [NSString stringWithFormat:@"%@%@%@", host, @"files/img/s_", attributes[@"ProductPicture"]];
			_amount = attributes[@"Amount"];
			_propertyString = attributes[@"Property"];
		}
	}
	return self;
}

- (NSString *)displayProperty
{
	NSMutableString *string = [NSMutableString string];
	if (_propertyString.length) {
		NSArray *kvs = [_propertyString componentsSeparatedByString:@";"];
		for (NSString *kv in kvs) {
			NSArray *keyAndValue = [kv componentsSeparatedByString:@":"];
			[string appendFormat:@"%@ ", keyAndValue.count > 1 ? keyAndValue[1] : @""];
		}
	}
	return string;
}

@end
