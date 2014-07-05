//
//  OrderInfo.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "OrderInfo.h"

@implementation OrderInfo

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_orderNo = attributes[@"OrderId"];
		_score = attributes[@"Points"];
		_status = [attributes[@"Flag"] integerValue] == 2 ? @"已确认" : @"待处理";
		_createTime = [attributes[@"CreateTime"] getCorrectDate];
		_welArrays = [WelInfo multiWithAttributesArray:attributes[@"LstCommoditySet"]];
	}
	return self;
}

@end
