//
//  ContactDetailsTableViewController.m
//  Joy
//
//  Created by zhangbin on 11/11/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ContactDetailsTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface ContactDetailsTableViewController () <UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>

@end

@implementation ContactDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = NSLocalizedString(@"联系人详情", nil);
	
	UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
	
	UIEdgeInsets edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
	
	UIImage *image = [UIImage imageNamed:@"user_head"];
	
	CGRect frame = CGRectMake(0, 0, 0, 0);
	frame.origin.x = edgeInsets.left;
	frame.origin.y = edgeInsets.top;
	frame.size.width = image.size.width;
	frame.size.height = image.size.height;
	
	UIImageView *avatarView = [[UIImageView alloc] initWithFrame:frame];
	avatarView.image = image;
	[headerView addSubview:avatarView];
	

	frame.origin.x = CGRectGetMaxX(avatarView.frame) + 20;
	frame.size.width = self.view.frame.size.width - frame.origin.x;
	frame.size.height = 30;
	
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:frame];
	nameLabel.text = [NSString stringWithFormat:@"%@ %@", _contact.personName ?: @"", _contact.englishName ?: @""];
	nameLabel.font = [UIFont boldSystemFontOfSize:17];
	[headerView addSubview:nameLabel];
	

	frame.origin.y = CGRectGetMaxY(nameLabel.frame);
	frame.size.height = 20;
	UILabel *departmentLabel = [[UILabel alloc] initWithFrame:frame];
	departmentLabel.text = [NSString stringWithFormat:@"%@ %@", _contact.companyPosition ?: @"", _contact.companyDepartment ?: @""];
	departmentLabel.font = [UIFont systemFontOfSize:13];
	[headerView addSubview:departmentLabel];
	
	
	frame.origin.y = CGRectGetMaxY(departmentLabel.frame);
	UILabel *companyNameLabel = [[UILabel alloc] initWithFrame:frame];
	companyNameLabel.text = _contact.companyName ?: @"";
	companyNameLabel.font = [UIFont systemFontOfSize:13];
	companyNameLabel.textColor = [UIColor grayColor];
	[headerView addSubview:companyNameLabel];
	
	self.tableView.tableHeaderView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 3;
	}
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
	}

	NSString *key = nil;
	NSString *value = nil;
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			key = @"    手机";
			value = _contact.mobile ?: @"";
		} else if (indexPath.row == 1) {
			key = @"    工作";
			value = _contact.phone ?: @"";
		} else {
			key = @"    传真";
			value = _contact.phone ?: @"";
		}
	} else {
		if (indexPath.row == 0) {
			key = @"    工作";
			value = _contact.email ?: @"";
		}
	}
	cell.textLabel.text = key;
	
	UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, tableView.frame.size.width - 90, cell.frame.size.height)];
	valueLabel.text = value;
	valueLabel.textColor = [UIColor secondaryColor];
	[cell addSubview:valueLabel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	NSString *title = nil;
	if (section == 0) {
		title = NSLocalizedString(@"电话", nil);
	}
	if (section == 1) {
		title = NSLocalizedString(@"邮箱", nil);
	}
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, 30)];
	label.text = title;
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
	[view addSubview:label];
	return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		if (indexPath.row == 0) {
			if (_contact.mobile.length) {
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _contact.mobile]]];
			}
		} else if (indexPath.row == 1) {
			if (_contact.phone.length) {
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _contact.phone]]];
			}
		}
	} else {
		if (_contact.email.length) {
			if ([MFMailComposeViewController canSendMail]) {
				MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
				[picker setToRecipients:@[_contact.email]];
				picker.mailComposeDelegate = self;
				[self.navigationController presentViewController:picker animated:YES completion:nil];
			}
		}
	}
}

#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
