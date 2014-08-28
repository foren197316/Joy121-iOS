//
//  UIColor+Joy.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "UIColor+Joy.h"
#import "JAFHTTPClient.h"

NSString * const themeColorIdentifier = @"themeColorIdentifier";
NSString * const secondaryColorIdentifier = @"secondaryColorIdentifier";

@implementation UIColor (Joy)

+ (void)saveThemeColorWithHexString:(NSString *)hexString
{
	[[NSUserDefaults standardUserDefaults] setObject:hexString forKey:themeColorIdentifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveSecondaryColorWithHexString:(NSString *)hexString
{
	[[NSUserDefaults standardUserDefaults] setObject:hexString forKey:secondaryColorIdentifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (instancetype)themeColor;
{
	NSString *hexString =[[NSUserDefaults standardUserDefaults] objectForKey:themeColorIdentifier];
	if (hexString) {
		return [UIColor hexRGB:[hexString hexUInteger]];
	}
	return [UIColor colorWithRed:244.0/255.0 green:123.0/255.0 blue:41.0/255.0 alpha:1.0];
}

+ (instancetype)secondaryColor
{
	NSString *hexString =[[NSUserDefaults standardUserDefaults] objectForKey:secondaryColorIdentifier];
	if (hexString) {
		return [UIColor hexRGB:[hexString hexUInteger]];
	}
	return [UIColor blackColor];
}

@end
