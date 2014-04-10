//
//  MyOrderListViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "WelDetailViewController.h"
#import "OrderInfo.h"
#import "OrderCell.h"

@interface MyOrderListViewController ()

@end

@implementation MyOrderListViewController {
    NSArray *infoArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的订单";
        infoArray = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadMyOrderList];
}

- (void)loadMyOrderList
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userOrderList:^(NSDictionary *result, NSError *error) {
        NSLog(@"%@", result);
        [self hideHUD:YES];
        if (result[@"retobj"]) {
            infoArray = [OrderInfo createOrderInfosWithArray:result[@"retobj"]];
            [_tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderInfo *info = infoArray[indexPath.row];
    if ([info.welArrays count] > 0) {
        WelDetailViewController *viewController = [[WelDetailViewController alloc] initWithNibName:@"WelDetailViewController" bundle:nil];
        viewController.welInfo = info.welArrays[0];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = nil;
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:self options: nil];
        cell = [nib objectAtIndex: 0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setInfo:infoArray[indexPath.row]];
    }
    return cell;
}

@end
