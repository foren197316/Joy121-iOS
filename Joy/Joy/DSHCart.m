//
//  DSHCart.m
//  dushuhu
//
//  Created by zhangbin on 3/29/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHCart.h"
#import "ZBModel.h"
#import "DSHGoods.h"
#import "DSHGoodsForCart.h"
#import "WelInfoForCart.h"

static NSMutableDictionary *cart;
static NSMutableDictionary *welCart;

@implementation DSHCart

+ (instancetype)shared;
{
	static DSHCart *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		_shared = [[DSHCart alloc] init];
		cart = [NSMutableDictionary dictionary];
		welCart = [NSMutableDictionary dictionary];
	});
    
    return _shared;
}

- (void)increaseWel:(WelInfo *)wel
{
	WelInfoForCart *w = welCart[wel.wid];
	if (w) {
		w.quanlity = @(w.quanlity.integerValue + 1);
	} else {
		[self setWel:wel quanlity:@(1)];
	}
}

- (void)decreaseWel:(WelInfo *)wel
{
	WelInfoForCart *welInfoForCart = welCart[wel.wid];
	if (welInfoForCart) {
		NSInteger current = welInfoForCart.quanlity.integerValue;
		current--;
		if (current > 0) {
			welInfoForCart.quanlity = @(current);
		} else {
			[self removeWel:wel];
		}
	}
}

- (void)setWel:(WelInfo *)wel quanlity:(NSNumber *)quanlity
{
	WelInfoForCart *welInfoForCart = [[WelInfoForCart alloc] init];
	welInfoForCart.wel = wel;
	welInfoForCart.quanlity = quanlity;
	welCart[wel.wid] = welInfoForCart;
}

- (void)removeWel:(WelInfo *)wel
{
	[welCart removeObjectForKey:wel.wid];
}

- (NSArray *)allWels
{
	NSMutableArray *allWels = [NSMutableArray array];
	for (WelInfoForCart *welInfoForCart in welCart.allValues) {
		[allWels addObject:welInfoForCart.wel];
	}
	return allWels;
}

- (NSNumber *)quanlityOfWel:(WelInfo *)wel
{
	WelInfoForCart *welInfoForCart = welCart[wel.wid];
	if (welInfoForCart) {
		return welInfoForCart.quanlity;
	}
	return nil;
}



- (void)increaseGoods:(DSHGoods *)goods
{
	DSHGoodsForCart *goodsForCart = cart[[goods identifier]];
	if (goodsForCart) {
			goodsForCart.quanlity = @(goodsForCart.quanlity.integerValue + 1);
	} else {
		[self setGoods:goods quanlity:@(1)];
	}
}

- (void)decreaseGoods:(DSHGoods *)goods
{
	DSHGoodsForCart *goodsForCart = cart[[goods identifier]];
	if (goodsForCart) {
		NSInteger current = goodsForCart.quanlity.integerValue;
		current--;
		if (current > 0) {
			goodsForCart.quanlity = @(current);
		} else {
			[self removeGoods:goods];
		}
	}
}

- (void)setGoods:(DSHGoods *)goods quanlity:(NSNumber *)quanlity
{
	DSHGoodsForCart *goodsForCart = [[DSHGoodsForCart alloc] init];
	DSHGoods *_goods = [goods copy];
	goodsForCart.goods = _goods;
	goodsForCart.quanlity = quanlity;
	goodsForCart.propertyValues = [_goods propertyValues];
	cart[[_goods identifier]] = goodsForCart;
}

- (NSArray *)allGoods
{
	NSMutableArray *allGoods = [NSMutableArray array];
	for (DSHGoodsForCart *goodsForCart in cart.allValues) {
		[allGoods addObject:goodsForCart.goods];
	}
	return allGoods;
}

- (NSArray *)allGoodsForCart
{
	return cart.allValues;
}

- (NSNumber *)sumPrice
{
	CGFloat sum = 0.0f;
	for (DSHGoodsForCart *goodsForCart in cart.allValues) {
		sum += [goodsForCart totalPrice].floatValue;
	}
	return @(sum);
}

- (NSNumber *)sumCredits
{
	CGFloat sum = 0.0f;
	for (DSHGoodsForCart *goodsForCart in cart.allValues) {
		sum += [goodsForCart totalCredits].floatValue;
	}
	return @(sum);
}

- (BOOL)existsGoods:(DSHGoods *)goods
{
	for (DSHGoodsForCart *goodsForCart in cart.allValues) {
		if ([goodsForCart.goods isEqualToGoods:goods]) {
			return YES;
		}
	}
	return NO;
}

- (NSNumber *)quanlityOfGoods:(DSHGoods *)goods
{
	DSHGoodsForCart *goodsForCart = cart[[goods identifier]];
	if (goodsForCart) {
		return goodsForCart.quanlity;
	}
	return nil;
}

- (void)removeGoods:(DSHGoods *)goods
{
	[cart removeObjectForKey:[goods identifier]];
}

- (BOOL)isEmpty
{
	return cart.count == 0 && welCart.count == 0;
}

- (BOOL)needPay
{
	return [self sumPrice].floatValue > 0;
}

- (BOOL)creditsGoodsExists
{
	return [self sumCredits].floatValue > 0.0f;
}

- (BOOL)isValidOrder:(NSString **)message withMinimumPriceForOrder:(NSNumber *)minimum currentCredits:(NSNumber *)currentCredits sessionValidation:(BOOL)validation
{
	return YES;
}

- (void)reset
{
	[cart removeAllObjects];
	[welCart removeAllObjects];
}

- (NSString *)describe
{
	NSMutableString *describe = [NSMutableString string];
	NSArray *allGoodsForCart = cart.allValues;
	for (int i = 0; i < allGoodsForCart.count; i++) {
		DSHGoodsForCart *goodsForCart = allGoodsForCart[i];
		[describe appendFormat:@"%@", [goodsForCart describe]];
		if (i < allGoodsForCart.count - 1) {
			[describe appendString:@"|"];
		}
	}

	if (describe.length) {
		[describe appendString:@"|"];
	}
	
	NSArray *allWel = welCart.allValues;
	for (int i = 0; i < allWel.count; i++) {
		WelInfoForCart *welForCart = allWel[i];
		[describe appendFormat:@"%@", [welForCart describe]];
		if (i < allWel.count - 1) {
			[describe appendString:@"|"];
		}
	}
	return describe;
}

@end
