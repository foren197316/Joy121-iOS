//
//  DepotTableViewController.m
//  Joy
//
//  Created by zhangbin on 11/17/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "DepotTableViewController.h"
#import "Depot.h"

@interface DepotTableViewController () <UIAlertViewDelegate>

@property (readwrite) NSArray *depots;
@property (readwrite) Depot *depotWillRent;

@end

@implementation DepotTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	[self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] officeDepotWithBlock:^(NSArray *multiAttributes, NSError *error) {
		[self hideHUD:YES];
		if (!error) {
			_depots = [Depot multiWithAttributesArray:multiAttributes];
			[self.tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)rent:(UIButton *)sender {
	NSInteger tag = sender.tag;
	Depot *depot = _depots[tag];
	_depotWillRent = depot;
	
	NSString *title = [NSString stringWithFormat:@"请问你要领用%@吗？", depot.name];
	NSString *message = @"请填写需要零用的数量";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
	alert.delegate = self;
	UITextField *textField = [alert textFieldAtIndex:0];
	textField.keyboardType = UIKeyboardTypeNumberPad;
	textField.text = @"1";
	[alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _depots.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(tableView.frame.size.width - 50, 10, 40, 30);
	[button setTitle:NSLocalizedString(@"领用", nil) forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.layer.borderColor = [[UIColor blackColor] CGColor];
	button.layer.borderWidth = 1;
	button.layer.cornerRadius = 6;
	button.tag = indexPath.row;
	[button addTarget:self action:@selector(rent:) forControlEvents:UIControlEventTouchUpInside];
	[cell addSubview:button];
	
	Depot *depot = _depots[indexPath.row];
	cell.textLabel.text = depot.name;
	NSString *details = [NSString stringWithFormat:@"%@  当前库存数量:%@", depot.model ?: @"", depot.currentNumber];
	cell.detailTextLabel.text = details;
	[cell.imageView setImageWithURL:[NSURL URLWithString:depot.imagePath] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
	return cell;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex != alertView.cancelButtonIndex) {
		UITextField *textField = [alertView textFieldAtIndex:0];
		
		if (!textField.text.length) {
			[self displayHUDTitle:@"请填写领用数量" message:nil duration:1];
			return;
		}
		
		NSInteger numberWillRent = [textField.text integerValue];
		
		if (numberWillRent > _depotWillRent.currentNumber.integerValue) {
			[self displayHUDTitle:@"抱歉库存不足，请减少数量" message:nil duration:1];
			return;
		}
		
		[[JAFHTTPClient shared] submitDepotRent:_depotWillRent.ID number:@(numberWillRent) withBlock:^(NSError *error) {
			if (!error) {
				[self displayHUDTitle:@"领用成功" message:nil duration:1];
			}
		}];
	}
}

@end
