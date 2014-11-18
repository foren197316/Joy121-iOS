//
//  DepotTableViewController.m
//  Joy
//
//  Created by zhangbin on 11/17/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "DepotTableViewController.h"
#import "Depot.h"

@interface DepotTableViewController ()

@property (readwrite) NSArray *depots;

@end

@implementation DepotTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	[self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] officeDepotWithBlock:^(NSArray *multiAttributes, NSError *error) {
		[self hideHUD:YES];
		if (!error) {
            
			Depot *depot = [[Depot alloc] init];
			depot.ID = @"1";
			depot.name = @"铅笔";
			depot.number = @(100);
			depot.imagePath = @"http://d.hiphotos.baidu.com/image/pic/item/7a899e510fb30f2499edd032cb95d143ad4b038f.jpg";
			
			Depot *depot2 = [[Depot alloc] init];
			depot2.ID = @"2";
			depot2.name = @"本子";
			depot2.number = @(10);
			depot2.imagePath = @"http://d.hiphotos.baidu.com/image/pic/item/7a899e510fb30f2499edd032cb95d143ad4b038f.jpg";
			
			_depots = @[depot, depot2];
			[self.tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rent:(UIButton *)sender {
	NSInteger tag = sender.tag;
	Depot *depot = _depots[tag];
	NSLog(@"depot: %@", depot);
	
	[self displayHUD:@"加载中..."];
	
	NSString *message = [NSString stringWithFormat:@"请问你要领用%@吗？", depot.name];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
	[alert show];
	
	[[JAFHTTPClient shared] submitDepotRent:depot.ID number:@(1) withBlock:^(NSError *error) {
		
	}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _depots.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	}
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(tableView.frame.size.width - 40, 10, 40, 30);
	[button setTitle:NSLocalizedString(@"领用", nil) forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	button.tag = indexPath.row;
	[button addTarget:self action:@selector(rent:) forControlEvents:UIControlEventTouchUpInside];
	[cell addSubview:button];
	
	Depot *depot = _depots[indexPath.row];
	cell.textLabel.text = depot.name;
	[cell.imageView setImageWithURL:[NSURL URLWithString:depot.imagePath] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
	return cell;
}

@end
