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
#import "DSHFlashImage.h"
#import "DSHCart.h"
#import "DSHGoodsQuantityView.h"

#define kSelectPropertyFirst @"选择属性"

@interface GoodsDetailsViewController () <ZBHorizontalScrollTableViewCellDelegate, GoodsPropertyViewDelegate>

@property (readwrite) NSMutableDictionary *selectedGoodsPropertyViews;
@property (readwrite) NSMutableArray *allGoodsPropertyViews;
@property (readwrite) NSInteger propertyTypes;
@property (readwrite) NSInteger sectionOfImages;
@property (readwrite) NSInteger sectionOfAmounts;
@property (readwrite) NSString *amount;
@property (readwrite) UILabel *amountLabel;
@property (readwrite) DSHGoodsQuantityView *quantityView;
@property (readwrite) UIWebView *webView;

@end

@implementation GoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = _goods.name;
	self.tableView.backgroundColor = [UIColor whiteColor];
	
	_sectionOfImages = 0;
	_amount = kSelectPropertyFirst;
	
	_selectedGoodsPropertyViews = [NSMutableDictionary dictionary];
	_allGoodsPropertyViews = [NSMutableArray array];
	
	_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
	[_webView loadHTMLString:_goods.describe baseURL:nil];
	self.tableView.tableFooterView = _webView;
    
	
	[[JAFHTTPClient shared] amountsOfGoods:_goods.goodsID withBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_goods.amounts = [GoodsAmount multiWithAttributesArray:multiAttributes];
			_propertyTypes = [_goods propertyTypes];
			_sectionOfAmounts = 1 + _propertyTypes;
			[self.tableView reloadData];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refreshAmountLabel {
	_amountLabel.text = [NSString stringWithFormat:@" %@:%@", NSLocalizedString(@"库存", nil), _amount];
}

- (void)addToCart {
	if ([_amount isEqualToString:kSelectPropertyFirst]) {
		[self displayHUDTitle:NSLocalizedString(kSelectPropertyFirst, nil) message:nil];
		return;
	}
	NSInteger quantity = [_amount integerValue];
	if (quantity <= 0 || quantity < _quantityView.quantity) {
		[self displayHUDTitle:NSLocalizedString(@"库存不足", nil) message:nil];
		return;
	}
	
	[[DSHCart shared] setGoods:_goods quanlity:@(_quantityView.quantity)];
	[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1 + _propertyTypes + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == _sectionOfImages) {
		return [DSHFlashImage scaledHeightFitWith:tableView.frame.size.width];
	}
	return [GoodsPropertyView size].height;
}

static CGFloat heightOfHeader = 15;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == _sectionOfImages)
		return 1;
	return heightOfHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == _sectionOfImages) {
		return nil;
	} else if (section == _sectionOfAmounts) {
		return nil;
	}
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, heightOfHeader)];
	label.font = [UIFont systemFontOfSize:13];
	label.backgroundColor = [UIColor clearColor];
	[[GoodsPropertyManager shared] displayNameOfIdentifier:[_goods propertyIdentifierAtIndex:section - 1] withBlock:^(NSString *displayName) {
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
	if (indexPath.section == _sectionOfImages) {
		cell.autoScrollEnabled = YES;
		//cell.pageControl.hidden = NO;
		//cell.pageControl.currentPageIndicatorTintColor = [UIColor secondaryColor];
		//cell.pageControl.pageIndicatorTintColor = [UIColor grayColor];
		//cell.pageControl.tintColor = [UIColor secondaryColor];
	}
	cell.section = indexPath.section;
	[cell reloadData];
	return cell;
}

#pragma mark - ZBHorizontalScrollTableViewCellDelegate

- (NSInteger)numberOfColumnsForCell:(ZBHorizontalScrollTableViewCell *)cell inSection:(NSInteger)section
{
	if (section == _sectionOfImages) {
		return _goods.pictures.count;
	}
	if (section == _sectionOfAmounts) {
		return 1;
	}
	NSString *identifer = [_goods propertyIdentifierAtIndex:section - 1];
	NSInteger count = [_goods numberOfPropertyValuesOfIdentifer:identifer];
	return count;
}

- (CGFloat)heightForCell:(ZBHorizontalScrollTableViewCell *)cell inSection:(NSInteger)section
{
	if (section == _sectionOfImages) {
		return [DSHFlashImage scaledHeightFitWith:self.tableView.frame.size.width];
	}
	return [GoodsPropertyView size].height;
}

- (UIView *)horizontalScrollTableViewCell:(ZBHorizontalScrollTableViewCell *)cell contentViewForColumnAtIndex:(NSInteger)index inSection:(NSInteger)section
{
	if (section == _sectionOfImages) {
		CGFloat heightOfImage = [DSHFlashImage scaledHeightFitWith:self.tableView.frame.size.width];
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * index, 0, self.view.frame.size.width, heightOfImage)];
		[imageView setImageWithURL:[NSURL URLWithString:_goods.pictures[index]]];
		return imageView;
	} else if (section == _sectionOfAmounts) {
		if (!_amountLabel) {
			_amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, [GoodsPropertyView size].height)];
			_amountLabel.font = [   UIFont systemFontOfSize:15];
			_amountLabel.userInteractionEnabled = YES;
			
			if (!_quantityView) {
				CGSize size = [DSHGoodsQuantityView size];
				_quantityView = [[DSHGoodsQuantityView alloc] initWithFrame:CGRectMake(100, 0, size.width, size.height)];
				[_amountLabel addSubview:_quantityView];
			}
			
			UIButton *addToCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
			addToCartButton.backgroundColor = [UIColor secondaryColor];
			addToCartButton.showsTouchWhenHighlighted = YES;
			addToCartButton.frame = CGRectMake(_amountLabel.frame.size.width - 80, 5, 70, _amountLabel.frame.size.height - 2 * 5);
			[addToCartButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
			addToCartButton.titleLabel.font = [UIFont systemFontOfSize:13];
			[addToCartButton setTitle:NSLocalizedString(@"加入购物车", nil) forState:UIControlStateNormal];
			[addToCartButton addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
			[_amountLabel addSubview:addToCartButton];
		}
		[self refreshAmountLabel];
		return _amountLabel;
	}
	CGSize size = [GoodsPropertyView size];
	CGRect frame = CGRectMake(size.width * index, 0, size.width, size.height);
	
	GoodsPropertyView *view = [[GoodsPropertyView alloc] initWithFrame:frame];
	view.delegate = self;
	NSArray *properties = [_goods propertiesOfIdentifier:[_goods propertyIdentifierAtIndex:section - 1]];
	view.property = properties[index];
	[_allGoodsPropertyViews addObject:view];
	return view;
}

#pragma mark - GoodsPropertyViewDelegate

- (void)goodsPropertyView:(GoodsPropertyView *)goodsPropertyView selected:(BOOL)selected
{
	for (int i = 0; i < _allGoodsPropertyViews.count; i++) {
		GoodsPropertyView *view = _allGoodsPropertyViews[i];
		if ([view.property.identifier isEqualToString:goodsPropertyView.property.identifier]) {
			view.selected = NO;
		}
	}
	GoodsProperty *property = goodsPropertyView.property;
	goodsPropertyView.selected = selected;
	if (selected) {
		_selectedGoodsPropertyViews[property.identifier] = goodsPropertyView;
		_goods.selectedProperties[property.identifier] = property;
	} else {
		[_goods.selectedProperties removeObjectForKey:property.identifier];
		[_selectedGoodsPropertyViews removeObjectForKey:property.identifier];
	}
	
	_amount = [_goods amountOfSelectedProperties];
	[self refreshAmountLabel];
}

@end
