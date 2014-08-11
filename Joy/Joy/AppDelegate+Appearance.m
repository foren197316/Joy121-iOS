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
	
	//UITabBarItem
	appearance = [UITabBarItem appearance];
	[appearance setTitleTextAttributes:@{UITextAttributeFont : [UIFont boldSystemFontOfSize:13], UITextAttributeTextColor : [UIColor lightGrayColor]} forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:@{UITextAttributeFont : [UIFont boldSystemFontOfSize:13], UITextAttributeTextColor : [UIColor whiteColor]} forState:UIControlStateSelected];
		
	//TabBar
	appearance = [UITabBar appearance];
	if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
		;
	} else {
		[appearance setSelectionIndicatorImage:[UIImage new]];
	}
	[appearance setBackgroundImage:[UIImage imageFromColor:[UIColor themeColor]]];
	
	//NavigationBar
	appearance = [UINavigationBar appearance];
	if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
		[appearance setBarTintColor:[UIColor themeColor]];
		[appearance setTintColor:[UIColor whiteColor]];
	} else {
		[appearance setBackgroundImage:[UIImage imageFromColor:[UIColor themeColor]] forBarMetrics:UIBarMetricsDefault];
	}
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
	
	//BarButtonItem
	appearance = [UIBarButtonItem appearance];
	if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
		[appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
	} else {
		[appearance setBackButtonBackgroundImage:[[UIImage imageNamed:@"BackArrow"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
		[appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(5, -2) forBarMetrics:UIBarMetricsDefault];
		[appearance setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:17], UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]} forState:UIControlStateNormal];
	}
}

@end
