//
//  DSHGoods.m
//  dushuhu
//
//  Created by zhangbin on 3/5/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHGoods.h"

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
	_categoryID = [NSString stringWithFormat:@"%@", attributes[@"ComtCategory1"]];
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

- (NSString *)propertiesString
{
	NSMutableString *identifier= [NSMutableString string];
	NSArray *properties = _selectedProperties.allValues;
	for (int i = 0; i < properties.count; i++) {
		GoodsProperty *p = properties[i];
		[identifier appendFormat:@"%@:%@", p.identifier, p.value];
		if (i < properties.count - 1) {
			[identifier appendString:@";"];
		}
	}
	return identifier;
}

- (NSMutableDictionary *)selectedProperties
{
	if (!_selectedProperties) {
		_selectedProperties = [NSMutableDictionary dictionary];
	}
	return _selectedProperties;
}

//TODO: 这里的逻辑不对，假设只有两种情况才正确
- (NSString *)amountOfSelectedProperties
{
//	NSLog(@"selecedProperies: %@", _selectedProperties);
	NSArray *keys = _selectedProperties.allKeys;
	NSMutableString *string = [NSMutableString stringWithString:@""];
	NSMutableString *revertString = [NSMutableString stringWithString:@""];
	for (int i = 0; i < keys.count; i++) {
		NSString *key = keys[i];
		GoodsProperty *property = _selectedProperties[key];
		NSString *tmp = [NSString stringWithFormat:@"%@:%@", property.identifier, property.value];
		[string appendString:tmp];
		[revertString insertString:tmp atIndex:0];
		if (i != keys.count - 1) {
			[string appendString:@";"];
			[revertString insertString:@";" atIndex:0];
		}
	}
//	NSLog(@"string: %@", string);
//	NSLog(@"revertString: %@", revertString);
	for (int i = 0; i < _amounts.count; i++) {
		GoodsAmount *amount = _amounts[i];
		if ([amount.propertiesString isEqualToString:string]) {
			return amount.amount;
		}
		if ([amount.propertiesString isEqualToString:revertString]) {
			return amount.amount;
		}
	}
	return @"0";
}

- (BOOL)isEqualToGoods:(DSHGoods *)goods
{
	if (![_goodsID isEqualToString:goods.goodsID]) {
		return NO;
	}
	NSArray *selfSelectedProperties = _selectedProperties.allValues;
	NSArray *properties = goods.selectedProperties.allValues;
	for (int i = 0; i < properties.count; i++) {
		GoodsProperty *p = properties[i];
		NSString *v = p.value;
		for (int j = 0; j < selfSelectedProperties.count; j++) {
			GoodsProperty *sp = selfSelectedProperties[j];
			NSString *sv = sp.value;
			if (![v isEqualToString:sv]) {
				return NO;
			}
		}
	}
	return YES;
}

- (NSString *)identifier
{
	return [NSString stringWithFormat:@"[%@]%@", _goodsID, [self propertiesString]];
}

- (NSString *)propertyValues
{
	NSArray *properties = _selectedProperties.allValues;
	NSMutableString *string = [NSMutableString string];
	for (int i = 0; i < properties.count; i++) {
		GoodsProperty *p = properties[i];
		[string appendFormat:@"%@ ", p.value];
	}
	return string;
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

- (instancetype)copy
{
	DSHGoods *g = [[DSHGoods alloc] init];
	if (_goodsID) {
		g.goodsID = [NSString stringWithString:_goodsID];
	}
	if (_categoryID) {
		g.categoryID = [NSString stringWithString:_categoryID];
	}
	if (_name) {
		g.name = [NSString stringWithString:_name];
	}
	if (_shopPrice) {
		g.shopPrice = [NSString stringWithString:_shopPrice];
	}
	if (_marketPrice) {
		g.marketPrice = [NSString stringWithString:_marketPrice];
	}
	if (_imagePath) {
		g.imagePath = [NSString stringWithString:_imagePath];
	}
	if (_imageThumbPath) {
		g.imageThumbPath = [NSString stringWithString:_imagePath];
	}
	if (_describe) {
		g.describe = [NSString stringWithString:_imagePath];
	}
	if (_pictures) {
		g.pictures = [NSArray arrayWithArray:_pictures];
	}
	if (_amounts) {
		g.amounts = [NSArray arrayWithArray:_amounts];
	}
	if (_selectedProperties) {
		g.selectedProperties = [NSMutableDictionary dictionaryWithDictionary:_selectedProperties];
	}
	return g;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<goodsID: %@, name: %@, imageThumbPath: %@, boughtCount: %@, _credits: %@, selectedPropertyValues: %@ >", _goodsID, _name, _imageThumbPath, _boughtCount, _credits, _selectedProperties.allValues];
}


@end
