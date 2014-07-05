//
//  AppDelegate+Appear.m
//  Joy
//
//  Created by 颜超 on 14-4-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "AppDelegate+Appearance.h"
#import "UIDevice+ZBUtilites.h"

@implementation AppDelegate (Appearance)

- (void)customizeAppearance
{
	id appearance;
#pragma mark - UINavigationBar Appearance
	appearance = [UINavigationBar appearance];
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		[appearance setBarTintColor:[UIColor themeColor]];
	} else {
		[appearance setBackgroundImage:[self imageFromColor:[UIColor themeColor]] forBarMetrics:UIBarMetricsDefault];
	}
	[appearance setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]}];
	
#pragma mark - UITabBarItem Appearance
	appearance = [UITabBarItem appearance];
	[appearance setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:10], UITextAttributeTextColor : [UIColor lightGrayColor]} forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:10], UITextAttributeTextColor : [UIColor orangeColor]} forState:UIControlStateSelected];
	
	UIImage *image = [UIImage imageNamed:@"tabbar"];
	appearance = [UITabBar appearance];
	[appearance setBackgroundImage:image];
	[appearance setSelectionIndicatorImage:[[UIImage alloc] init]];
    
	
#pragma mark - UIBarButtonItem Appearance
	appearance = [UIBarButtonItem appearance];
	[appearance setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]} forState:UIControlStateNormal];
}

- (UIImage *)imageFromColor:(UIColor *)color
{
	return [self imageFromSize:CGSizeMake(1, 1) block:^(CGContextRef context) {
		CGRect rect = CGRectMake(0, 0, 1, 1);
		CGContextSetFillColorWithColor(context, [color CGColor]);
		CGContextFillRect(context, rect);
	}];
}

- (UIImage *)imageFromSize:(CGSize)size block:(void(^)(CGContextRef))block
{
	UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	block(context);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}
@end
