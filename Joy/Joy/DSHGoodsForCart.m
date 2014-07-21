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
	//TODO: hard code
	//第三个参数表示类型，logo store 和商品都是1，福利是2
	return [NSString stringWithFormat:@"[%@][%@][%@][%ld]", _goods.goodsID, [_goods propertiesString], @"1", _quanlity.integerValue];
}

@end
