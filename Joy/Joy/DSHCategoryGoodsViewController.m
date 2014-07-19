//
//  DSHCategoryGoodsViewController.m
//  dushuhu
//
//  Created by zhangbin on 4/15/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "DSHCategoryGoodsViewController.h"
#import "DSHGoodsTableViewCell.h"
#import "DSHCart.h"
#import "GoodsDetailsViewController.h"

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
		_multiGoods = _category.multiGoods;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
	GoodsDetailsViewController *controller = [[GoodsDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	controller.goods = _multiGoods[indexPath.row];
	[self.navigationController pushViewController:controller animated:YES];
}

@end
