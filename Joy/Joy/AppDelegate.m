//
//  AppDelegate.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "AppDelegate.h"
#import "JAFHTTPClient.h"
#import "HomeViewController.h"
#import "JoyViewController.h"
#import "ServiceViewController.h"
#import "StoreViewController.h"
#import "MeViewController.h"
#import "SignInViewController.h"
#import "AppDelegate+Appearance.h"
#import "JAFHTTPClient.h"
#import "CompanyViewController.h"
#import "DesEncrypt.h"
#import "APService.h"

@implementation AppDelegate

- (void)test
{
//    [[JAFHTTPClient shared] surList:nil withBlock:nil];
//    [[JAFHTTPClient shared] eventList:nil];
//    [[JAFHTTPClient shared] companyNotice:@"DELPHI_SZ" withBlock:nil];
//    [[JAFHTTPClient shared] signIn:@"steven" password:@"12" withBlock:nil];
//    [[JAFHTTPClient shared] userInfoWithBlock:nil];
//    [[JAFHTTPClient shared] frontPicWithBlock:nil];
//    [[JAFHTTPClient shared] userOrderList:nil];
//    [[JAFHTTPClient shared] orderDetail:@"22" withBlock:nil];
//    [[JAFHTTPClient shared] userBuyHistory:nil];
//    [[JAFHTTPClient shared] userScore:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self test];
//TODO:
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)];
//    [APService setupWithOption:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self customizeAppearance];
    self.window.backgroundColor = [UIColor whiteColor];
    if ([JAFHTTPClient bLogin]) {
        [self addTabBar];
    } else {
        [self addSignIn];
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    NSString *deviceTokenString = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
    [[NSUserDefaults standardUserDefaults] setObject:deviceTokenString forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"保存token到本地...");
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [APService handleRemoteNotification:userInfo];
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
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
	NSMutableArray *viewControllers = [NSMutableArray array];
	
	UINavigationController *navigationHome = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
	[viewControllers addObject:navigationHome];
	
	UINavigationController *navigationJoy = [[UINavigationController alloc] initWithRootViewController:[CompanyViewController new]];
	[viewControllers addObject:navigationJoy];
	
	UINavigationController *navigationService = [[UINavigationController alloc] initWithRootViewController:[ServiceViewController new]];
	[viewControllers addObject:navigationService];
	
	UINavigationController *navigationStore = [[UINavigationController alloc] initWithRootViewController:[StoreViewController new]];
	[viewControllers addObject:navigationStore];
	
	UINavigationController *navigationMe = [[UINavigationController alloc] initWithRootViewController:[MeViewController new]];
	[viewControllers addObject:navigationMe];

	_tabBarController = [[UITabBarController alloc] init];
	_tabBarController.viewControllers = viewControllers;
	[self.window setRootViewController:_tabBarController];
	[self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
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
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
