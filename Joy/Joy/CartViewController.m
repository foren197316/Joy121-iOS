//
//  CartViewController.m
//  Joy
//
//  Created by zhangbin on 6/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "CartViewController.h"
#import "DSHCart.h"
#import "DSHGoodsTableViewCell.h"
#import "DSHGoodsForCart.h"

static NSString *cartSectionIdentifier = @"cartSectionIdentifier";
static NSString *submitSectionIdentifier = @"submitSectionIdentifier";

@interface CartViewController () <UIAlertViewDelegate, DSHGoodsTableViewCellDelegate>

@property (readwrite) NSMutableArray *identifiers;
@property (readwrite) NSArray *multiGoods;
@property (readwrite) NSArray *multiGoodsForCart;
@property (readwrite) NSArray *multiWel;

@end

@implementation CartViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		self.title = NSLocalizedString(@"购物车", nil);
		[self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"mall_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"mall_icon"]];
		self.tabBarItem.title = NSLocalizedString(@"购物车", nil);
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCart:) name:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
}

- (void)reload
{
	_identifiers = [NSMutableArray array];
	[_identifiers addObject:cartSectionIdentifier];
	if (![[DSHCart shared] isEmpty]) {
		[_identifiers addObject:submitSectionIdentifier];
	}
	
	_multiGoods = [[DSHCart shared] allGoods];
	_multiGoodsForCart = [[DSHCart shared] allGoodsForCart];
	_multiWel = [[DSHCart shared] allWels];
	[self.tableView reloadData];
}

- (void)updateCart:(NSNotification *)notification
{
	NSInteger goodsCount = [[DSHCart shared] allGoods].count;
	NSInteger welCount = [[DSHCart shared] allWels].count;
	self.tabBarItem.badgeValue = goodsCount + welCount == 0 ? nil : [NSString stringWithFormat:@"%ld", (long)goodsCount + (long)welCount];
}

#pragma mark - UITableViewDataSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return _identifiers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSString *sectionIdentifier = _identifiers[section];
	if ([sectionIdentifier isEqualToString:cartSectionIdentifier]) {
		return _multiGoods.count + _multiWel.count;
	}
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *sectionIdentifier = _identifiers[indexPath.section];
	if ([sectionIdentifier isEqualToString:cartSectionIdentifier]) {
//		if (indexPath.row == _multiGoods.count) {
//			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sumCell"];
//			if (!cell) {
//				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sumCell"];
//			}
//			if ([[DSHCart shared] isEmpty]) {
//				cell.textLabel.textAlignment = NSTextAlignmentCenter;
//				cell.textLabel.numberOfLines = 0;
//				cell.textLabel.font = [UIFont systemFontOfSize:13];
//				cell.imageView.image = [UIImage imageNamed:@"CartGreen"];
//				cell.textLabel.text = NSLocalizedString(@"亲,暂时没有商品,选好商品后再回来结算哦!", nil);
//			} else {
//				cell.textLabel.font = [UIFont boldSystemFontOfSize:19];
//				CGFloat sumPrice = [[DSHCart shared] sumPrice].floatValue;
//				CGFloat sumCredits = [[DSHCart shared] sumCredits].floatValue;
//				NSString *sumPriceString = sumPrice > 0 ? [NSString stringWithFormat:@"%@%.1f元  ", @"￥", [[DSHCart shared] sumPrice].floatValue] : @"";
//				NSString *sumCreditsString = sumCredits > 0 ? [NSString stringWithFormat:@"%@积分", [[DSHCart shared] sumCredits]] : @"";
//				NSString *cost = [NSString stringWithFormat:@"总计:%@%@", sumPriceString, sumCreditsString];
//				cell.textLabel.text = cost;
//				cell.textLabel.textAlignment = NSTextAlignmentCenter;
//				cell.imageView.image = [UIImage imageNamed:@"CartGreen"];
//			}
//			return cell;
//		}
		DSHGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cartSectionIdentifier];
		if (!cell) {
			cell = [[DSHGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cartSectionIdentifier];
			cell.delegate = self;
		}
		if (indexPath.row < _multiGoods.count) {
			DSHGoods *goods = _multiGoods[indexPath.row];
			cell.goodsForCart = _multiGoodsForCart[indexPath.row];
			cell.goods = goods;
			cell.quanlity = [[DSHCart shared] quanlityOfGoods:goods];
		} else {
			WelInfo *wel = _multiWel[indexPath.row - _multiGoods.count];
			cell.wel = wel;
			cell.quanlity = [[DSHCart shared] quanlityOfWel:wel];
		}
		cell.isCartSytle = YES;
		return cell;
	} else {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:submitSectionIdentifier];
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:submitSectionIdentifier];
		}
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont systemFontOfSize:22];
		cell.textLabel.textColor = [UIColor whiteColor];
		cell.backgroundColor = [UIColor themeColor];
		cell.textLabel.text = NSLocalizedString(@"提交订单", nil);
		return cell;
	}
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	NSString *identifier = _identifiers[section];
	if ([identifier isEqualToString:submitSectionIdentifier]) {
		return 50;
	}
	return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier = _identifiers[indexPath.section];
	if ([identifier isEqualToString:submitSectionIdentifier]) {
		return 40;
	}
	return [DSHGoodsTableViewCell height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] init];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 10 * 2, 20)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont systemFontOfSize:13];
	NSString *sectionIdentifier = _identifiers[section];
	if ([sectionIdentifier isEqualToString:cartSectionIdentifier]) {
		label.text = NSLocalizedString(@"即将购买的商品", nil);
	}
	[view addSubview:label];
	return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier = _identifiers[indexPath.section];
	if ([identifier isEqualToString:cartSectionIdentifier]) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		if (indexPath.row != _multiGoods.count) {
		}
	} else if ([identifier isEqualToString:submitSectionIdentifier]) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		NSString *messageTitle, *message;
		if (messageTitle) {
			[self displayHUDTitle:messageTitle message:message];
			[self.tableView reloadData];
			return;
		}
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"确认订单", nil) message:NSLocalizedString(@"您确认提交该订单吗?", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"提交", nil), nil];
		[alert show];
	}
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != alertView.cancelButtonIndex) {
		NSString *describe = [[DSHCart shared] describe];
		NSLog(@"describe: %@", describe);
		[[JAFHTTPClient shared] submitOrder:describe withBlock:^(NSError *error) {
			if (!error) {
				[[DSHCart shared] reset];
				[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
				[self reload];
				[self displayHUDTitle:NSLocalizedString(@"提交订单成功", nil) message:nil];
			}
		}];
	}
}

#pragma mark - DSHGoodsCellDelegate

- (void)willIncreaseGoods:(DSHGoods *)goods
{
	[[DSHCart shared] increaseGoods:goods];
	[self reload];
}

- (void)willDecreaseGoods:(DSHGoods *)goods
{
	[[DSHCart shared] decreaseGoods:goods];
	[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
	[self reload];
}

- (void)willIncreaseWel:(WelInfo *)wel
{
	[[DSHCart shared] increaseWel:wel];
	[self reload];
}

- (void)willDecreaseWel:(WelInfo *)wel
{
	[[DSHCart shared] decreaseWel:wel];
	[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
	[self reload];
}


@end
