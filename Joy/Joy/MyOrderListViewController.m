//
//  MyOrderListViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "MyOrderListViewController.h"

@interface MyOrderListViewController ()

@end

@implementation MyOrderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMyOrderList];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadMyOrderList
{
    [[JAFHTTPClient shared] userOrderList:^(NSDictionary *result, NSError *error) {
//        NSLog(@"%@", result);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
