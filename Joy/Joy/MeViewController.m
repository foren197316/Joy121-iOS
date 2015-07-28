//
//  MeViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "MeViewController.h"
#import "MeDetailViewController.h"
#import "ChangePwdViewController.h"
#import "UserScoreViewController.h"
#import "AppDelegate.h"
#import "MyOrderListViewController.h"
#import "UIImageView+AFNetWorking.h"
#import "DSHCart.h"
#import "JUser.h"

#define APP_ID @"865941543"

@interface MeViewController ()

@property (readwrite) JUser *user;

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"个人空间", nil);
		
		UIImage *normalImage = [UIImage imageNamed:@"Me"];
		UIImage *selectedImage = [UIImage imageNamed:@"MeHighlighted"];
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	_tableView.backgroundColor = [UIColor whiteColor];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_scrollView setContentSize:self.view.frame.size];
	
	if ([[JAFHTTPClient shared] companyLogoURLString]) {
		self.navigationItem.titleView = [UIView companyTitleViewWithURLString:[[JAFHTTPClient shared] companyLogoURLString]];
	} else {
		self.title = [[JAFHTTPClient shared] companyTitle];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadUserInfo];
}

- (void)loadUserInfo
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userInfoWithBlock:^(NSDictionary *attributes, NSError *error) {
        [self hideHUD:YES];
		if (!error) {
			_user = [[JUser alloc] initWithAttributes:attributes];
            _realNameLabel.text = [NSString stringWithFormat:@"%@", _user.realName];
            _companyLabel.text = [NSString stringWithFormat:@"%@", _user.companyName];
            _scoreLabel.text = [NSString stringWithFormat:@"%@", _user.score];
            [_headImageView setImageWithURL:[NSURL URLWithString:_user.icon]];
            [_tableView reloadData];
		} else {
			[self displayHUDTitle:nil message:NETWORK_ERROR];
		}
    }];
}

- (void)signout
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意"
                                                        message:@"是否注销?"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)details
{
	MeDetailViewController *controller = [[MeDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    controller.user = _user;
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
			[self details];
        } else if (indexPath.row == 1) {
            ChangePwdViewController *viewController = [[ChangePwdViewController alloc] initWithNibName:@"ChangePwdViewController" bundle:nil];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:viewController animated:YES];
        } else if (indexPath.row == 2) {
            MyOrderListViewController *viewController = [[MyOrderListViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:viewController animated:YES];
        } else if (indexPath.row == 3) {
            UserScoreViewController *viewController = [[UserScoreViewController alloc] initWithNibName:@"UserScoreViewController" bundle:nil];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:viewController animated:YES];
        } else if (indexPath.row == 4){
            
        }
    } else if (indexPath.section == 1) {
		[self signout];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"个人档案";
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"修改密码";
            } else if (indexPath.row == 2) {
                cell.textLabel.text = @"我的订单";
            } else if (indexPath.row == 3){
                cell.textLabel.text = @"积分历史";
            } else if (indexPath.row == 4){
                cell.textLabel.text = @"绑定手机";
            }
        } else if (indexPath.section == 1) {
			cell.textLabel.text = @"退出登录";
			cell.backgroundColor = [UIColor secondaryColor];
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.textLabel.textColor = [UIColor whiteColor];
			cell.textLabel.textAlignment = NSTextAlignmentCenter;
		}
    }
    return cell;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.cancelButtonIndex != buttonIndex) {
		[[DSHCart shared] reset];
		[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
		[JAFHTTPClient signOut];
		AppDelegate *delegate = [UIApplication sharedApplication].delegate;
		[delegate addSignIn];
	}
}


@end
