//
//  DSHCart.m
//  dushuhu
//
//  Created by zhangbin on 3/29/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "ZBModel.h"
#import "DSHGoods.h"

@interface DSHGoodsForCart : ZBModel

@property (nonatomic, strong) DSHGoods *goods;
@property (nonatomic, strong) NSNumber *quanlity;

- (NSNumber *)totalPrice;

@end


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

@end


#import "DSHCart.h"

static NSMutableDictionary *cart;

@implementation DSHCart

+ (instancetype)shared;
{
	static DSHCart *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
		_shared = [[DSHCart alloc] init];
		cart = [NSMutableDictionary dictionary];
	});
    
    return _shared;
}

- (void)increaseGoods:(DSHGoods *)goods
{
	DSHGoodsForCart *goodsForCart = cart[goods.goodsID];
	if (goodsForCart) {
		goodsForCart.quanlity = @(goodsForCart.quanlity.integerValue + 1);
	} else {
		[self setGoods:goods quanlity:@(1)];
	}
}

- (void)decreaseGoods:(DSHGoods *)goods
{
	DSHGoodsForCart *goodsForCart = cart[goods.goodsID];
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
	goodsForCart.goods = goods;
	goodsForCart.quanlity = quanlity;
	cart[goods.goodsID] = goodsForCart;
}

- (NSArray *)allGoods
{
	NSMutableArray *allGoods = [NSMutableArray array];
	for (DSHGoodsForCart *goodsForCart in cart.allValues) {
		[allGoods addObject:goodsForCart.goods];
	}
	return allGoods;
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
		if ([goodsForCart.goods.goodsID isEqualToString:goods.goodsID]) {
			return YES;
		}
	}
	return NO;
}

- (NSNumber *)quanlityOfGoods:(DSHGoods *)goods
{
	DSHGoodsForCart *goodsForCart = cart[goods.goodsID];
	if (goodsForCart) {
		return goodsForCart.quanlity;
	}
	return nil;
}

- (void)removeGoods:(DSHGoods *)goods
{
	[cart removeObjectForKey:goods.goodsID];
}

- (BOOL)isEmpty
{
	return cart.count == 0;
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
//	if (!validation) {
//		if ([self creditsGoodsExists]) {
//			*message = [NSString stringWithFormat:NSLocalizedString(@"亲!您尚未登录,不能选购积分商品,请移除积分商品后再提交!", nil), currentCredits];
//			return NO;
//		}
//	}
	
//	if (currentCredits.floatValue < [self sumCredits].floatValue) {
//		*message = [NSString stringWithFormat:NSLocalizedString(@"亲!您当前积分为:%@,积分不够,请从购物车中移除/减少积分商品后再提交订单!", nil), currentCredits];
//		return NO;
//	}
	
//	if ([self sumPrice].floatValue == 0.0f && [self creditsGoodsExists]) {//所有商品都是积分商品
//		return YES;
//	}
	
//	if ([self sumPrice].floatValue < minimum.floatValue) {
//		*message = [NSString stringWithFormat:NSLocalizedString(@"亲!购物需要满%@才送货,再选几个吧!", nil), minimum];
//		return NO;
//	}
	return YES;
}

- (NSDictionary *)multiGoodsAttributes
{
	NSMutableDictionary *multiGoodsAttributes = [NSMutableDictionary dictionary];
	for (DSHGoodsForCart *goodsForCart in cart.allValues) {
		multiGoodsAttributes[goodsForCart.goods.goodsID] = [goodsForCart orderAttributes];
	}
	return multiGoodsAttributes;
}

- (void)reset
{
	[cart removeAllObjects];
}

- (NSString *)describe
{
	NSMutableString *describe = [NSMutableString string];
	for (DSHGoodsForCart *goodsForCart in cart.allValues) {
		[describe appendFormat:@"%@(数量%@);", goodsForCart.goods.name, goodsForCart.quanlity];
	}
	return describe;
}

@end
