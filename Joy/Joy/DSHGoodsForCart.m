//
//  DSHGoodsForCart.m
//  Joy
//
//  Created by zhangbin on 7/19/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "DSHGoodsForCart.h"

@implementation DSHGoodsForCart

- (NSNumber *)totalPrice
{
	return @([_goods price].floatValue * _quanlity.integerValue);
}

- (NSNumber *)totalCredits
{
	return @(_goods.credits.floatValue * _quanlity.integerValue);
}

- (NSDictionary *)orderAttributes
{
	return @{@"goods_number" : _quanlity};
}

- (NSString *)describe
{
	return [NSString stringWithFormat:@"[%@][%@][%@][%ld]", _goods.goodsID, [_goods propertiesString], _goods.categoryID, _quanlity.integerValue];
}

@end
