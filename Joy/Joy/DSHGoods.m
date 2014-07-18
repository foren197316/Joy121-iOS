//
//  DSHGoods.m
//  dushuhu
//
//  Created by zhangbin on 3/5/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHGoods.h"
#import "GoodsAmount.h"
#import "GoodsProperty.h"

@interface DSHGoods ()

@property (nonatomic, strong) NSArray *uniqueProperies;

@end

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

- (void)setAmounts:(NSArray *)amounts
{
	_amounts = amounts;
	if (_amounts.count) {
		_uniqueProperies = [self _uniqueProperties];
	}
}

- (NSArray *)_uniqueProperties
{
	NSMutableArray *ps = [NSMutableArray array];
	NSMutableArray *identifiers = [NSMutableArray array];
	for (int i = 0; i < _amounts.count; i++) {
		GoodsAmount *amount = _amounts[i];
		NSArray *properties = amount.properties;
		for (int j = 0; j < properties.count; j++) {
			GoodsProperty *p = properties[j];
			if (![identifiers containsObject:p.identifier]) {
				[identifiers addObject:p.identifier];
				[ps addObject:p];
			}
		}
	}
	return ps;
}

- (NSInteger)propertyTypes
{
	return _uniqueProperies.count;
}

- (GoodsProperty *)propertyAtIndex:(NSInteger)index
{
	if (index < _uniqueProperies.count) {
		return _uniqueProperies[index];
	}
	return nil;
}

- (NSString *)propertyIdentifierAtIndex:(NSInteger)index
{
	GoodsProperty *property = [self propertyAtIndex:index];
	return property.identifier;
}

- (NSInteger)numberOfPropertyValuesOfIdentifer:(NSString *)identifer
{
	NSMutableArray *values = [NSMutableArray array];
	for (int i = 0; i < _amounts.count; i++) {
		GoodsAmount *amount = _amounts[i];
		NSArray *properties = amount.properties;
		for (int j = 0; j < properties.count; j++) {
			GoodsProperty *p = properties[j];
			if ([p.identifier isEqualToString:identifer]) {
				if (![values containsObject:p.value]) {
					[values addObject:p.value];
				}
			}
		}
	}
	return values.count;
}

- (NSArray *)propertiesOfIdentifier:(NSString *)identifier
{
	NSMutableArray *properites = [NSMutableArray array];
	NSMutableArray *values = [NSMutableArray array];
	for (int i = 0; i < _amounts.count; i++) {
		GoodsAmount *amount = _amounts[i];
		NSArray *ps = amount.properties;
		for (int j = 0; j < ps.count; j++) {
			GoodsProperty *p = ps[j];
			if ([p.identifier isEqualToString:identifier]) {
				if (![values containsObject:p.value]) {
					[properites addObject:p];
					[values addObject:p.value];
				}
			}
		}
	}
	return properites;
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
