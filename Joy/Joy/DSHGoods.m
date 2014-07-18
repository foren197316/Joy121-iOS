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
    
	_goodsID = [NSString stringWithFormat:@"%@", attributes[@"Id"]];
    _name = attributes[@"ComName"];
	_shopPrice = [NSString stringWithFormat:@"%@",  attributes[@"MarketPrice"]];
	_marketPrice = [NSString stringWithFormat:@"%@",  attributes[@"MarketPrice"]];
	
	NSString *host = [JAFHTTPClient shared].baseURL.absoluteString;
	
	if (attributes[@"Picture"]) {
		NSString *path = [NSString stringWithFormat:@"%@%@%@", host, @"files/img/s_", attributes[@"Picture"]];
		_imageThumbPath = path;
		_imagePath = path;
	}
	
	NSString *string = attributes[@"AppPicture"];
	if (string.length) {
		NSArray *array = [string componentsSeparatedByString:@";"];
		NSMutableArray *pics = [NSMutableArray array];
		for (int i = 0; i < array.count; i++) {
			NSString *path = [NSString stringWithFormat:@"%@%@%@", host, @"files/img/", array[i]];
			[pics addObject:path];
		}
		_pictures = [NSArray arrayWithArray:pics];
	}
    return self;
}

- (NSString *)shopPrice
{
	return _shopPrice;
}

- (NSString *)marketPrice
{
	return _marketPrice;
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
