//
//  GoodsProperty.m
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "GoodsProperty.h"

@implementation GoodsProperty

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_identifier = attributes[@"PropertyMetaId"];
	_displayName = attributes[@"PropertyMetaDispName"];
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"< identifier: %@, displayName: %@ value: %@ >", _identifier, _displayName, _value];
}

@end
