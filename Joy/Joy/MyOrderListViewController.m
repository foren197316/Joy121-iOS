//
//  MyOrderListViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "MyOrderListViewController.h"
#import "Order.h"
#import "OrderItem.h"

#define kHeightOfHeader 40

@interface MyOrderListViewController ()

@property (readwrite) NSArray *orders;

@end

@implementation MyOrderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"我的订单", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self displayHUD:NSLocalizedString(@"加载中...", nil)];
	[[JAFHTTPClient shared] myOrders:^(NSArray *multiAttributes, NSError *error) {
		[self hideHUD:YES];
		if (!error) {
			_orders = [Order multiWithAttributesArray:multiAttributes];
			[self.tableView reloadData];
		}
	}];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _orders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	Order *order = _orders[section];
    return order.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return kHeightOfHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(edgeInsets.left, 0, tableView.frame.size.width - edgeInsets.left - edgeInsets.right, kHeightOfHeader)];
	view.backgroundColor = [UIColor themeColor];
	view.alpha = 0.6;
	
	UIFont *font = [UIFont systemFontOfSize:13];
	UIColor *textColor = [UIColor whiteColor];
	
	Order *order = _orders[section];
	UILabel *orderIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height / 2)];
	orderIDLabel.text = [NSString stringWithFormat:@"%@:%@", NSLocalizedString(@"订单", nil), order.ID];
	orderIDLabel.font = font;
	orderIDLabel.textColor = textColor;
	[view addSubview:orderIDLabel];
	
	UILabel *dateLabel = [[UILabel alloc] initWithFrame:orderIDLabel.frame];
	dateLabel.textAlignment = NSTextAlignmentRight;
	dateLabel.text = order.dateString;
	dateLabel.font = font;
	dateLabel.textColor = textColor;
	[view addSubview:dateLabel];
	
	UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height / 2, view.frame.size.width, view.frame.size.height / 2)];
	pointsLabel.text = [NSString stringWithFormat:@"%@:%@  %@:%ld", NSLocalizedString(@"积分", nil), order.points, NSLocalizedString(@"商品数量", nil), order.items.count];
	pointsLabel.font = font;
	pointsLabel.textColor = textColor;
	[view addSubview:pointsLabel];
	
	UILabel *statusLabel = [[UILabel alloc] initWithFrame:pointsLabel.frame];
	statusLabel.textAlignment = NSTextAlignmentRight;
	statusLabel.text = order.status;
	statusLabel.font = font;
	statusLabel.textColor = textColor;
	[view addSubview:statusLabel];
	
	return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
	Order *order = _orders[indexPath.section];
	OrderItem *item = order.items[indexPath.row];
	[cell.imageView setImageWithURL:[NSURL URLWithString:item.imageULRString] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
	cell.textLabel.text = item.name;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@  %@", NSLocalizedString(@"数量", nil), item.amount, [item displayProperty]];
	return cell;
}

@end
