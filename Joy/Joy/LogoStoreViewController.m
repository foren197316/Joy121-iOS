//
//  LogoStoreViewController.m
//  Joy
//
//  Created by zhangbin on 7/8/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "LogoStoreViewController.h"
#import "ZBHorizontalScrollTableViewCell.h"
#import "DSHCategory.h"
#import "DSHGoodsView.h"
#import "DSHCategoryGoodsViewController.h"
#import "GoodsDetailsViewController.h"

@interface LogoStoreViewController () <
ZBHorizontalScrollTableViewCellDelegate,
DSHGoodsViewDelegate
>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *multiGoods;

@end

@implementation LogoStoreViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
		self.title = NSLocalizedString(@"Logo商店", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[[JAFHTTPClient shared] storeCategoriesWithBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_categories = [DSHCategory multiWithAttributesArray:multiAttributes];
			[self.tableView reloadData];
			
			dispatch_queue_t networkQueue = dispatch_queue_create("goods", DISPATCH_QUEUE_SERIAL);
			dispatch_async(networkQueue, ^{
				for (int i = 0; i < _categories.count; i++) {
					DSHCategory *category = _categories[i];
					//category type 2 是logo store 1是在线商城
					[[JAFHTTPClient shared] storeGoodsOfCategoryID:category.categoryID categoryType:@"2" withBlock:^(NSArray *multiAttributes, NSError *error) {
						if (!error) {
							NSArray *multiGoods = [DSHGoods multiWithAttributesArray:multiAttributes];
							category.multiGoods = multiGoods;
							dispatch_async(dispatch_get_main_queue(), ^{
								[self.tableView reloadData];
							});
						}
					}];
				}
			});
			
		}
	}];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)seeAll:(UIButton *)sender
{
	NSInteger tag = sender.tag;
	DSHCategory *category = _categories[tag];
	DSHCategoryGoodsViewController *controller = [[DSHCategoryGoodsViewController alloc] initWithStyle:UITableViewStylePlain];
	controller.category = category;
	[self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld", (long)indexPath.section];//do not reuse
    
    ZBHorizontalScrollTableViewCell	*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
		cell = [[ZBHorizontalScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
		cell.delegate = self;
    }
	cell.section = indexPath.section;
	[cell reloadData];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [DSHGoodsView size].height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 16;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] init];
	view.backgroundColor = [UIColor whiteColor];
	return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
	
	DSHCategory *category = _categories[section];
	
	UIButton *categoryNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
	categoryNameButton.frame = CGRectMake(10, 0, CGRectGetWidth(view.frame) / 3, CGRectGetHeight(view.frame));
	[categoryNameButton setTitle:category.name forState:UIControlStateNormal];
	[categoryNameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	categoryNameButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
	categoryNameButton.tag = section;
	categoryNameButton.showsTouchWhenHighlighted = YES;
	[categoryNameButton addTarget:self action:@selector(seeAll:) forControlEvents:UIControlEventTouchUpInside];
	categoryNameButton.layer.cornerRadius = 4;
	[view addSubview:categoryNameButton];
	
	UIButton *seeAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
	seeAllButton.frame = CGRectMake(CGRectGetWidth(view.frame) - 100, 0, 100, CGRectGetHeight(view.frame));
	[seeAllButton setTitle:NSLocalizedString(@"显示全部 >", nil) forState:UIControlStateNormal];
	[seeAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	seeAllButton.titleLabel.font = [UIFont systemFontOfSize:14];
	seeAllButton.backgroundColor = [UIColor clearColor];
	seeAllButton.tag = section;
	seeAllButton.showsTouchWhenHighlighted = YES;
	[seeAllButton addTarget:self action:@selector(seeAll:) forControlEvents:UIControlEventTouchUpInside];
	[view addSubview:seeAllButton];
	
	return view;
}


#pragma mark - ZBHorizontalScrollTableViewCellDelegate

- (NSInteger)numberOfColumnsForCell:(ZBHorizontalScrollTableViewCell *)cell inSection:(NSInteger)section
{
	DSHCategory *category = _categories[section];
	return category.multiGoods.count;
}

- (CGFloat)heightForCell:(ZBHorizontalScrollTableViewCell *)cell inSection:(NSInteger)section
{
	return [DSHGoodsView size].height;
}

- (UIView *)horizontalScrollTableViewCell:(ZBHorizontalScrollTableViewCell *)cell contentViewForColumnAtIndex:(NSInteger)index inSection:(NSInteger)section
{
	CGSize size = [DSHGoodsView size];
	CGRect frame = CGRectMake(size.width * index, 0, size.width, size.height);
	
	DSHGoodsView *goodsView = [[DSHGoodsView alloc] initWithFrame:frame];
	goodsView.delegate = self;
	DSHCategory *category = _categories[section];
	DSHGoods *goods = category.multiGoods[index];
	goodsView.goods = goods;
	return goodsView;
}

#pragma mark - DSHGoodsViewDelegate

- (void)goodsView:(DSHGoodsView *)goodsView didSelectGoods:(DSHGoods *)goods
{
	GoodsDetailsViewController *controller = [[GoodsDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
	controller.goods = goods;
	[self.navigationController pushViewController:controller animated:YES];
}



@end
