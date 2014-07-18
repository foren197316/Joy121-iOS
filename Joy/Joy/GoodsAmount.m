//
//  GoodsAmount.m
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "GoodsAmount.h"
#import "GoodsProperty.h"

@implementation GoodsAmount

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super init];
	if (!self) {
		return nil;
	}
	
	_goodsID = [NSString stringWithFormat:@"%@", attributes[@"CommodityId"]];
	_amount = [NSString stringWithFormat:@"%@", attributes[@"Amount"]];
	
	NSMutableArray *tmp = [NSMutableArray array];
	_propertiesString = attributes[@"PropertyValues"];
	if (_propertiesString.length) {
		NSArray *array = [_propertiesString componentsSeparatedByString:@";"];
		for (int i = 0; i < array.count; i++) {
			NSString *p = array[i];
			if (p.length) {
				NSArray *pArray = [p componentsSeparatedByString:@":"];
				if (pArray.count == 2) {//key and value
					GoodsProperty *goodsProperty = [[GoodsProperty alloc] init];
					goodsProperty.identifier = pArray[0];
					goodsProperty.value = pArray[1];
					[tmp addObject:goodsProperty];
				}
			}
		}
	}
	_properties = tmp;
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"< _amount: %@, propertiesString: %@ >", _amount, _propertiesString];
}

@end
