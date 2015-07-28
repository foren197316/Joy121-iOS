//
//  Order.m
//  Joy
//
//  Created by zhangbin on 7/29/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "Order.h"
#import "OrderItem.h"

@implementation Order

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super init];
	if (self) {
		_ID = attributes[@"OrderId"];
		NSString *flag = attributes[@"Flag"];
		//_status = [flag isEqualToString:@"2"] ? NSLocalizedString(@"已确认", nil) : NSLocalizedString(@"待处理", nil);
        _status = flag;
		_dateString = [attributes[@"CreateTime"] getCorrectDate];
		_points = attributes[@"Points"];
		
		if (attributes[@"CurProductsInfo"]) {
			_items = [OrderItem multiWithAttributesArray:attributes[@"CurProductsInfo"]];
		}
		
	}
	return self;
}



@end
