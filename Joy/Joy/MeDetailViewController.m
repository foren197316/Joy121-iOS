//
//  MeDetailViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "MeDetailViewController.h"
#import "UIImageView+AFNetWorking.h"
#import "AppDelegate.h"

#define Key @"key"
#define Value @"value"
#define HeightOfHeaderView 100

@interface MeDetailViewController () <UIAlertViewDelegate>

@property (readwrite) NSMutableArray *details;

@end

@implementation MeDetailViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
    if (self) {
		self.title = NSLocalizedString(@"个人信息", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if (_user) {
		_details = [NSMutableArray array];
		[_details addObject:@{Key : @"登录名:", Value : _user.userName ?: @""}];
		[_details addObject:@{Key : @"姓名:", Value : _user.realName ?: @""}];
		[_details addObject:@{Key : @"身份证:", Value : _user.cardNo ?: @""}];
		[_details addObject:@{Key : @"性别:", Value : _user.gender ?: @""}];
		[_details addObject:@{Key : @"出生年月:", Value : _user.birthDay ?: @""}];
		[_details addObject:@{Key : @"公司名称:", Value : _user.company.name ?: @""}];
		[_details addObject:@{Key : @"公司地址:", Value : _user.company.address ?: @""}];
		[_details addObject:@{Key : @"公司电话:", Value : _user.company.phoneNumber ?: @""}];
		[_details addObject:@{Key : @"邮箱:", Value : _user.email ?: @""}];
		[_details addObject:@{Key : @"手机:", Value : _user.telephone ?: @""}];
		[_details addObject:@{Key : @"注册日期", Value : _user.reDate ?: @""}];
	}
	
//    _realNameLabel.text = [NSString stringWithFormat:@"%@", _user.realName];
 //   _companyLabel.text = [NSString stringWithFormat:@"%@", _user.companyName];
  //  _scoreLabel.text = [NSString stringWithFormat:@"%@", _user.score];
   // [_headImageView setImageWithURL:[NSURL URLWithString:_user.icon]];
   // [_tableView reloadData];
}

//- (IBAction)signOut:(id)sender
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注意"
//                                                        message:@"是否注销?"
//                                                       delegate:self
//                                              cancelButtonTitle:@"取消"
//                                              otherButtonTitles:@"确定", nil];
//    [alertView show];
//}

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
    return _details.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return HeightOfHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	CGRect frame = CGRectMake(0, 0, self.tableView.bounds.size.width, HeightOfHeaderView);
	UIView *view = [[UIView alloc] initWithFrame:frame];
	
	frame.origin.x = 10;
	frame.origin.y = 10;
	frame.size.width = 80;
	frame.size.height = 80;
	UIImageView *profileView = [[UIImageView alloc] initWithFrame:frame];
	[profileView setImageWithURL:[NSURL URLWithString:_user.icon]];
	[view addSubview:profileView];

	frame.origin.x = CGRectGetMaxX(profileView.frame) + 10;
	frame.origin.y += 10;
	frame.size.width = self.tableView.bounds.size.width - frame.origin.x;
	frame.size.height = 20;

	UILabel *realnameLabel = [[UILabel alloc] initWithFrame:frame];
	realnameLabel.text = _user.realName;
	[view addSubview:realnameLabel];

	frame.origin.y = CGRectGetMaxY(realnameLabel.frame) + 5;
	
	UILabel *companyLabel = [[UILabel alloc] initWithFrame:frame];
	companyLabel.text = _user.companyName;
	companyLabel.font = [UIFont systemFontOfSize:13];
	[view addSubview:companyLabel];

	frame.origin.y = CGRectGetMaxY(companyLabel.frame) + 5;
	
	UILabel *scoreLabel = [[UILabel alloc] initWithFrame:frame];
	scoreLabel.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"积分:", nil), _user.score];
	scoreLabel.font = [UIFont systemFontOfSize:10];
	[view addSubview:scoreLabel];
	
	return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
        [keyLabel setTextColor:[UIColor darkGrayColor]];
        [keyLabel setTextAlignment:NSTextAlignmentRight];
		keyLabel.text = _details[indexPath.row][Key];
        keyLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:keyLabel];

        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 180, 35)];
        [valueLabel setTextColor:[UIColor colorWithRed:253.0/255.0 green:121.0/255.0 blue:82.0/255.0 alpha:1.0]];
        valueLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:valueLabel];
		valueLabel.text = _details[indexPath.row][Value];
    }
    return cell;
}

@end
