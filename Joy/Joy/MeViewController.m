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

#define APP_ID @"865941543"
#define ALERT_TAG_SIGNOUT 1
#define ALERT_TAG_CHECKUPDATE 2

@interface MeViewController ()

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"MeHighlighted"] withFinishedUnselectedImage:[UIImage imageNamed:@"Me"]];
		self.title = NSLocalizedString(@"个人空间", nil);
        _bEdit = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_scrollView setContentSize:CGSizeMake(320, 568)];
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

- (IBAction)signOut:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意"
                                                        message:@"是否注销?"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (IBAction)editButtonClicked:(id)sender
{
	MeDetailViewController *controller = [[MeDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
    controller.user = _user;
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    [view setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:243.0/255.0 blue:244.0/255.0 alpha:1.0]];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self editButtonClicked:nil];
        } else if (indexPath.row == 1) {
            ChangePwdViewController *viewController = [[ChangePwdViewController alloc] initWithNibName:@"ChangePwdViewController" bundle:nil];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:viewController animated:YES];
        } else if (indexPath.row == 2) {
            MyOrderListViewController *viewController = [[MyOrderListViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:viewController animated:YES];
        } else {
            UserScoreViewController *viewController = [[UserScoreViewController alloc] initWithNibName:@"UserScoreViewController" bundle:nil];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    } else {
        [self checkUpdate];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
		
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 34, 320, .5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [cell.contentView addSubview:line];
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"个人档案";
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"修改密码";
            } else if (indexPath.row == 2) {
                cell.textLabel.text = @"我的订单";
            } else if (indexPath.row == 3){
                cell.textLabel.text = @"积分历史";
            }
        } else {
            cell.textLabel.text = @"检查更新";
        }
    }
    return cell;
}

- (void)checkUpdate
{
    [self displayHUD:@"检查更新中..."];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://itunes.apple.com"]];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"id"] = APP_ID;
    [client getPath:@"/lookup" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self hideHUD:YES];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [self checkUpdateWithResult:result];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self displayHUDTitle:nil message:@"服务器连接超时, 请检查网络"];
    }];
}

- (void)checkUpdateWithResult:(NSDictionary *)dict
{
    NSArray *resultDataArray = dict[@"results"];
    NSLog(@"%@", resultDataArray);
    if ([resultDataArray count] > 0) {
        NSDictionary *infoDict = resultDataArray[0];
        NSString* version = infoDict[@"version"];
        NSString* cversion = [self getVersion];
        if(version && [version compare:cversion]==NSOrderedDescending) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有新版本, 现在前往App Store更新吗?"
                                                                message:infoDict[@"releaseNotes"]
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
            [alertView setTag:ALERT_TAG_CHECKUPDATE];
            [alertView show];
        } else {
            [self displayHUDTitle:nil message:@"您当前使用的是最新版本!"];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        if (alertView.tag == ALERT_TAG_CHECKUPDATE) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString appStoreLinkWithAppID:APP_ID]]];
        } else {
            [JAFHTTPClient signOut];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate addSignIn];
        }
    }
}

- (NSString*)getVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    return version;
}



@end
