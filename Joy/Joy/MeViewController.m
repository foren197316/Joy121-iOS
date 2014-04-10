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
#import "AppDelegate.h"

@interface MeViewController ()

@end

@implementation MeViewController {
    NSArray *keysArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"个人空间";
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"personal_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"personal_icon"]];
        keysArray = @[@"登录名:", @"姓名:", @"身份证:", @"性别:", @"出生年月:", @"邮箱:", @"手机:", @"注册日期:"];
        _bEdit = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUserInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadUserInfo
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userInfoWithBlock:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if (result) {
            _user = [JUser createJUserWithDict:result[@"retobj"]];
            _realNameLabel.text = [NSString stringWithFormat:@"%@", _user.realName];
            _companyLabel.text = [NSString stringWithFormat:@"%@", _user.companyName];
            _scoreLabel.text = [NSString stringWithFormat:@"%@", _user.score];
            [_tableView reloadData];
        }
    }];
}

- (IBAction)signOut:(id)sender
{
    [JAFHTTPClient signOut];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate addSignIn];
}

- (IBAction)editButtonClicked:(id)sender
{
    MeDetailViewController *viewController = [[MeDetailViewController alloc] initWithNibName:@"MeDetailViewController" bundle:nil];
    viewController.user = _user;
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
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
            ChangePwdViewController *viewController = [[ChangePwdViewController alloc] initWithNibName:@"ChangePwdViewController" bundle:nil];
            [viewController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:viewController animated:YES];
        } else if (indexPath.row == 1) {
            
        } else {
            
        }
    } else {
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"修改密码";
            } else if (indexPath.row == 1) {
                cell.textLabel.text = @"我的订单";
            } else {
                cell.textLabel.text = @"积分历史";
            }
        } else {
            cell.textLabel.text = @"检查更新";
        }
    }
    return cell;
}


@end
