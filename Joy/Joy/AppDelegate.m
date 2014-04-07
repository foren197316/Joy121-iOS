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

@implementation AppDelegate

- (void)test
{
//    [[JAFHTTPClient shared] signIn:@"steven" password:@"123" withBlock:nil];
    [[JAFHTTPClient shared] userInfoWithBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"%@", result);
    }];
//    [[JAFHTTPClient shared] frontPicWithBlock:nil];
//    [[JAFHTTPClient shared] userOrderList:nil];
//    [[JAFHTTPClient shared] orderDetail:@"22" withBlock:nil];
//    [[JAFHTTPClient shared] userBuyHistory:nil];
//    [[JAFHTTPClient shared] userScore:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self test];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self addTabBar];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)addTabBar
{
    UINavigationController *navigationHome = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
    UINavigationController *navigationJoy = [[UINavigationController alloc] initWithRootViewController:[JoyViewController new]];
    UINavigationController *navigationService = [[UINavigationController alloc] initWithRootViewController:[ServiceViewController new]];
    UINavigationController *navigationStore = [[UINavigationController alloc] initWithRootViewController:[StoreViewController new]];
    UINavigationController *navigationMe = [[UINavigationController alloc] initWithRootViewController:[MeViewController new]];
    
    NSArray *viewControllers = @[navigationHome, navigationJoy, navigationService, navigationStore, navigationMe];
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = viewControllers;
    [self.window setRootViewController:_tabBarController];
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