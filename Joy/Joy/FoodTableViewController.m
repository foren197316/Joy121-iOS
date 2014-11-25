//
//  FoodTableViewController.m
//  Joy
//
//  Created by zhangbin on 7/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "FoodTableViewController.h"
#import "DSHGoods.h"

@interface FoodTableViewController ()

@property (readwrite) NSArray *multiGoods;

@end

@implementation FoodTableViewController

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
	//category type 2 是logo store 1是在线商城
	[[JAFHTTPClient shared] storeGoodsOfCategoryID:[NSString stringWithFormat:@"%ld", _index] categoryType:@"1" withBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_multiGoods = [DSHGoods multiWithAttributesArray:multiAttributes];
			[self.tableView reloadData];
		}
	}];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	}
	DSHGoods *goods = _multiGoods[indexPath.row];
	[cell.imageView setImageWithURL:[NSURL URLWithString:goods.imageThumbPath] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
	cell.textLabel.text = goods.name;
	cell.textLabel.adjustsFontSizeToFitWidth = YES;
	cell.textLabel.textColor = [UIColor blackColor];
	cell.detailTextLabel.numberOfLines = 0;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"价格:%@", goods.marketPrice];
    return cell;
}

@end
