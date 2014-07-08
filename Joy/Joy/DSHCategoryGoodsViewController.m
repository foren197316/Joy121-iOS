//
//  DSHCategoryGoodsViewController.m
//  dushuhu
//
//  Created by zhangbin on 4/15/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHCategoryGoodsViewController.h"
#import "DSHGoodsTableViewCell.h"
//#import "DSHGoodsDetailsViewController.h"
#import "DSHCart.h"

@interface DSHCategoryGoodsViewController () <DSHGoodsTableViewCellDelegate>

@property (nonatomic, strong) NSArray *multiGoods;

@end

@implementation DSHCategoryGoodsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = _category.name;
	
	if (_category) {
		_multiGoods = _category.multiGoods;//TODO: need search
//		[[DSHAPIClient shared] goodsOfCategory:_category.categoryID withBlock:^(NSArray *multiAttributes, NSError *error) {
//			if (!error) {
//				_multiGoods = [DSHGoods multiWithAttributesArray:multiAttributes];
//				[self.tableView reloadData];
//			}
//		}];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - DSHGoodsCellDelegate

- (void)willAddToCart:(DSHGoods *)goods
{
//	if (![[DSHAPIClient shared] isSessionValid]) {
//		if ([goods needCredits]) {
//			[self displayHUDTitle:NSLocalizedString(@"无法加入购物车", nil) message:NSLocalizedString(@"购买此商品需要积分,请登录后兑换!", nil) duration:1];
//			return;
//		}
//	}
	[[DSHCart shared] increaseGoods:goods];
	[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _multiGoods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DSHGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	if (!cell) {
		cell = [[DSHGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
	cell.delegate = self;
	cell.goods = _multiGoods[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [DSHGoodsTableViewCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//	DSHGoodsDetailsViewController *controller = [[DSHGoodsDetailsViewController alloc] initWithNibName:nil bundle:nil];
//	controller.goods = _multiGoods[indexPath.row];
//	[self.navigationController pushViewController:controller animated:YES];
}

@end
