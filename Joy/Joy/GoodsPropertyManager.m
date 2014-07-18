//
//  GoodsPropertyManager.m
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "GoodsPropertyManager.h"
#import "GoodsProperty.h"

static NSArray *properties;

@implementation GoodsPropertyManager

+ (instancetype)shared
{
	static GoodsPropertyManager *instance;
	if (!instance) {
		instance = [[GoodsPropertyManager alloc] init];
	}
	return instance;
}

- (void)updateWithBlock:(void (^)())block
{
	[[JAFHTTPClient shared] goodsPropertiesWithBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			properties = [GoodsProperty multiWithAttributesArray:multiAttributes];
			if (block) {
				block();
			}
		}
	}];
}

- (void)displayNameOfIdentifier:(NSString *)identifier withBlock:(void (^)(NSString *displayName))block
{
	if (!properties) {
		[self updateWithBlock:^{
			if (block) {
				block([self _displayNameOfIdentifier:identifier]);
			}
		}];
	}
	if (block) {
		block([self _displayNameOfIdentifier:identifier]);
	}
}

- (NSString *)_displayNameOfIdentifier:(NSString *)identifier
{
	NSString *displayName = identifier;
	for (int i = 0; i < properties.count; i++) {
		GoodsProperty *property = properties[i];
		if ([identifier isEqualToString:property.identifier]) {
			displayName = property.displayName;
			break;
		}
	}
	return displayName;
}

@end
