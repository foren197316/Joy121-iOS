//
//  GoodsDetailsViewController.m
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "GoodsAmount.h"
#import "ZBHorizontalScrollTableViewCell.h"
#import "GoodsPropertyView.h"
#import "GoodsProperty.h"
#import "GoodsPropertyManager.h"

@interface GoodsDetailsViewController () <ZBHorizontalScrollTableViewCellDelegate, GoodsPropertyViewDelegate>

@end

@implementation GoodsDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.backgroundColor = [UIColor whiteColor];
	[[JAFHTTPClient shared] amountsOfGoods:_goods.goodsID withBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_goods.amounts = [GoodsAmount multiWithAttributesArray:multiAttributes];
			[self.tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_goods propertyTypes];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

static CGFloat heightOfHeader = 30;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return heightOfHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 2 * 10, heightOfHeader)];
	label.backgroundColor = [UIColor clearColor];
	[[GoodsPropertyManager shared] displayNameOfIdentifier:[_goods propertyIdentifierAtIndex:section] withBlock:^(NSString *displayName) {
		label.text = displayName;
	}];
	return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld", (long)indexPath.section];//do not reuse
	
	ZBHorizontalScrollTableViewCell	*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		cell = [[ZBHorizontalScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
		cell.delegate = self;
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	cell.section = indexPath.section;
	[cell reloadData];
	return cell;
}

#pragma mark - ZBHorizontalScrollTableViewCellDelegate

- (NSInteger)numberOfColumnsForCell:(ZBHorizontalScrollTableViewCell *)cell inSection:(NSInteger)section
{
	NSString *identifer = [_goods propertyIdentifierAtIndex:section];
	NSInteger count = [_goods numberOfPropertyValuesOfIdentifer:identifer];
	return count;
}

- (CGFloat)heightForCell:(ZBHorizontalScrollTableViewCell *)cell inSection:(NSInteger)section
{
	return [GoodsPropertyView size].height;
}

- (UIView *)horizontalScrollTableViewCell:(ZBHorizontalScrollTableViewCell *)cell contentViewForColumnAtIndex:(NSInteger)index inSection:(NSInteger)section
{
	CGSize size = [GoodsPropertyView size];
	CGRect frame = CGRectMake(size.width * index, 0, size.width, size.height);
	
	GoodsPropertyView *view = [[GoodsPropertyView alloc] initWithFrame:frame];
	view.delegate = self;
	NSArray *properties = [_goods propertiesOfIdentifier:[_goods propertyIdentifierAtIndex:section]];
	view.property = properties[index];
	return view;
}

#pragma mark - GoodsPropertyViewDelegate

- (void)goodsPropertyView:(GoodsPropertyView *)goodsPropertyView selected:(BOOL)selected
{
	NSLog(@"property: %@ selected: %@", goodsPropertyView.property, selected ? @"YES" : @"NO");
}

@end
