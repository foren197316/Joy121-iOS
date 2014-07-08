//
//  DSHGoods.m
//  dushuhu
//
//  Created by zhangbin on 3/5/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHGoods.h"

@implementation DSHGoods

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _goodsID = attributes[@"goods_id"];
	
    _name = attributes[@"goods_name"];
	if (!_name) {
		_name = attributes[@"name"];
	}
	
	_shopPrice = attributes[@"shop_price"];
	if (!_shopPrice && attributes[@"goods_price"]) {
		_shopPrice = attributes[@"goods_price"];
	}
	
	_marketPrice = attributes[@"market_price"];
	
//	if (attributes[@"goods_img"]) {
//		_imagePath = [NSString stringWithFormat:@"%@%@", [[DSHAPIClient shared] baseURLString], attributes[@"goods_img"]];
//	}
	
//	if (attributes[@"goods_thumb"]) {
//		_imageThumbPath = [NSString stringWithFormat:@"%@%@", [[DSHAPIClient shared] baseURLString], attributes[@"goods_thumb"]];
//	}
//	if (!_imageThumbPath) {
//		if (attributes[@"thumb"]) {
//			_imageThumbPath = [NSString stringWithFormat:@"%@%@", [[DSHAPIClient shared] baseURLString], attributes[@"thumb"]];
//		}
//	}
	
	
	NSString *sCredits = attributes[@"cost_integral"];
	if (sCredits.floatValue > 0.0f) {
		_credits = @(sCredits.floatValue);
	}
	_boughtCount = attributes[@"bought_count"];
    return self;
}

- (NSString *)shopPrice
{
	return @"0.01";//TODO
	//return [NSString stringWithFormat:@"%@%.1f", @"￥", [_shopPrice priceNumber].floatValue];
}

- (NSString *)marketPrice
{
	return @"0.01";//TODO
//	return [NSString stringWithFormat:@"%@%.1f", @"￥", [_marketPrice priceNumber].floatValue];
}

- (NSString *)creditsPrice
{
	if (_credits) {
		return [NSString stringWithFormat:@"积分:%@", _credits];
	}
	return nil;
}

- (NSString *)boughtCount
{
	if (!_boughtCount) {
		return nil;
	}
	return [NSString stringWithFormat:@"%@%@", _boughtCount, NSLocalizedString(@"人购买过", nil)];
}

- (NSNumber *)price
{
	return @(1);//TODO:
	//return [_shopPrice priceNumber];
}

- (BOOL)needCredits
{
	return _credits.floatValue > 0.0f;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<goodsID: %@, name: %@, imageThumbPath: %@, boughtCount: %@, _credits: %@>", _goodsID, _name, _imageThumbPath, _boughtCount, _credits];
}


@end
