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
    NSArray *valuesArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"个人信息", nil);
        keysArray = @[@"登录名:", @"姓名:", @"身份证:", @"性别:", @"出生年月:", @"邮箱:", @"手机:", @"注册日期:"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    valuesArray = @[_user.userName, _user.realName, _user.cardNo, _user.gender, _user.birthDay, _user.email, _user.telephone, _user.reDate];
    [_scrollView setContentSize:CGSizeMake(320, 568)];
    _realNameLabel.text = [NSString stringWithFormat:@"%@", _user.realName];
    _companyLabel.text = [NSString stringWithFormat:@"%@", _user.companyName];
    _scoreLabel.text = [NSString stringWithFormat:@"%@", _user.score];
    [_headImageView setImageWithURL:[NSURL URLWithString:_user.icon]];
    [_tableView reloadData];
    // Do any additional setup after loading the view from its nib.
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        [JAFHTTPClient signOut];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate addSignIn];
    }
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
            valueLabel.text = valuesArray[indexPath.row];
        }
    }
    return cell;
}

@end
