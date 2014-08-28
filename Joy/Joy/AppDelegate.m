//
//  AppDelegate.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "AppDelegate.h"
#import "JAFHTTPClient.h"
#import "JoyViewController.h"
#import "ServiceViewController.h"
#import "StoreViewController.h"
#import "MeViewController.h"
#import "SignInViewController.h"
#import "AppDelegate+Appearance.h"
#import "JAFHTTPClient.h"
#import "CompanyViewController.h"
#import "APService.h"
#import "CartViewController.h"
#import "LogoStoreViewController.h"
#import "SurveryViewController.h"
#import "ModuleViewController.h"

@implementation AppDelegate

- (void)test
{
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self test];
	[self customizeAppearance];
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
	[self apserviceSetTags];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
	
    if ([JAFHTTPClient bLogin]) {
        [self addTabBar];
    } else {
        [self addSignIn];
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *deviceTokenString = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:deviceTokenString forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [APService registerDeviceToken:deviceToken];
	[self apserviceSetTags];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
	NSLog(@"remote userinfo: %@", userInfo);
    [APService handleRemoteNotification:userInfo];
	[self handleRemoteNotification:userInfo];
}

- (void)apserviceSetTags
{
	NSArray *tags = [[JAFHTTPClient shared] pushTags];
	if (tags.count) {
		NSSet *set = [[NSSet alloc] initWithArray:tags];
		[APService setTags:set alias:nil callbackSelector:nil object:nil];
	}
}

- (void)addSignIn
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    UINavigationController *signInNavigation = [[UINavigationController alloc] initWithRootViewController:[SignInViewController new]];
    signInNavigation.navigationBarHidden = YES;
    [self.window setRootViewController:signInNavigation];
    [self.window makeKeyAndVisible];
}

- (void)addTabBar
{
	[self customizeAppearance];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
	NSMutableArray *viewControllers = [NSMutableArray array];
		
	UINavigationController *navigationJoy = [[UINavigationController alloc] initWithRootViewController:[[CompanyViewController alloc] initWithCollectionViewLayout:[CompanyViewController flowLayout]]];
	[viewControllers addObject:navigationJoy];
		
//	UINavigationController *navigationService = [[UINavigationController alloc] initWithRootViewController:[ServiceViewController new]];
//	[viewControllers addObject:navigationService];
	
	UINavigationController *navigationStore = [[UINavigationController alloc] initWithRootViewController:[[StoreViewController alloc] initWithNibName:nil bundle:nil]];
	[viewControllers addObject:navigationStore];
	
	UINavigationController *navigationCart = [[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] initWithStyle:UITableViewStyleGrouped]];
	[viewControllers addObject:navigationCart];
	
	UINavigationController *navigationMe = [[UINavigationController alloc] initWithRootViewController:[MeViewController new]];
	[viewControllers addObject:navigationMe];

	_tabBarController = [[UITabBarController alloc] init];
	_tabBarController.viewControllers = viewControllers;
	[self.window setRootViewController:_tabBarController];
	[self.window makeKeyAndVisible];
}

- (void)handleRemoteNotification:(NSDictionary *)userInfo
{
	
//	aps =     {
//        alert = "\U6709\U4e09\U4e2a\U798f\U5229\U4f9b\U60a8\U9009\U62e9";
//    };
//    msgtype = benefit;
//    objid = "-1";
	
	BOOL hideBottomBar = NO;
    NSString *type = [NSString stringWithFormat:@"%@", userInfo[@"msgtype"]];
    UIViewController *controller = nil;
		
	if ([type.lowercaseString isEqualToString:@"benefit"]) {
		JoyViewController *joyViewController = [[JoyViewController alloc] initWithStyle:UITableViewStyleGrouped];
		controller = joyViewController;
		hideBottomBar = YES;
	} else if ([type.lowercaseString isEqualToString:@"logostore"]) {
		LogoStoreViewController *logoStoreViewController = [[LogoStoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
		controller = logoStoreViewController;
		hideBottomBar = YES;
	} else if ([type.lowercaseString isEqualToString:@"activity"]) {
		ModuleViewController *moduleViewController = [[ModuleViewController alloc] initWithStyle:UITableViewStyleGrouped];
		moduleViewController.module = [[Module alloc] initWithAttributes:@{@"ModuleName" : @"活动"}];
		controller = moduleViewController;
	} else if ([type.lowercaseString isEqualToString:@"post"]) {
		ModuleViewController *moduleViewController = [[ModuleViewController alloc] initWithStyle:UITableViewStyleGrouped];
		moduleViewController.module = [[Module alloc] initWithAttributes:@{@"ModuleName" : @"公告"}];
		controller = moduleViewController;
	} else if ([type.lowercaseString isEqualToString:@"training"]) {
		ModuleViewController *moduleViewController = [[ModuleViewController alloc] initWithStyle:UITableViewStyleGrouped];
		moduleViewController.module = [[Module alloc] initWithAttributes:@{@"ModuleName" : @"培训"}];
		controller = moduleViewController;
	} else {
		SurveryViewController *surveryViewController = [[SurveryViewController alloc] initWithStyle:UITableViewStylePlain];
		controller = surveryViewController;
	}

    if (controller) {
		controller.hidesBottomBarWhenPushed = hideBottomBar;
		self.tabBarController.selectedIndex = 0;
		UINavigationController *navigationController = self.tabBarController.viewControllers[self.tabBarController.selectedIndex];
		[navigationController popToRootViewControllerAnimated:NO];
		[navigationController pushViewController:controller animated:YES];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
	[self apserviceSetTags];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
	[self apserviceSetTags];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
	[self apserviceSetTags];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
