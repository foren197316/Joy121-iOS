//
//  MeDetailViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "MeDetailViewController.h"
#import "AppDelegate.h"

@interface MeDetailViewController ()

@end

@implementation MeDetailViewController {
    NSArray *keysArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"个人信息";
        keysArray = @[@"登录名:", @"姓名:", @"身份证:", @"性别:", @"出生年月:", @"邮箱:", @"手机:", @"注册日期:"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_scrollView setContentSize:CGSizeMake(320, 568)];
    _realNameLabel.text = [NSString stringWithFormat:@"%@", _user.realName];
    _companyLabel.text = [NSString stringWithFormat:@"%@", _user.companyName];
    _scoreLabel.text = [NSString stringWithFormat:@"%@", _user.score];
    [_tableView reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)signOut:(id)sender
{
    [JAFHTTPClient signOut];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate addSignIn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
        [keyLabel setTextColor:[UIColor darkGrayColor]];
        [keyLabel setTextAlignment:NSTextAlignmentRight];
        keyLabel.text = keysArray[indexPath.row];
        keyLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:keyLabel];
        
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 180, 35)];
        [valueLabel setTextColor:[UIColor colorWithRed:253.0/255.0 green:121.0/255.0 blue:82.0/255.0 alpha:1.0]];
        valueLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:valueLabel];
        if (_user) {
            if (indexPath.row == 0) {
                valueLabel.text = _user.userName;
            } else if (indexPath.row == 1) {
                valueLabel.text = _user.realName;
            } else if (indexPath.row == 2) {
                valueLabel.text = _user.cardNo;
            } else if (indexPath.row == 3) {
                valueLabel.text = _user.gender;
            } else if (indexPath.row == 4) {
                valueLabel.text = _user.birthDay;
            } else if (indexPath.row == 5) {
                valueLabel.text = _user.email;
            } else if (indexPath.row == 6) {
                valueLabel.text = _user.telephone;
            } else if (indexPath.row == 7) {
                valueLabel.text = _user.reDate;
            }
        }
    }
    return cell;
}

@end
