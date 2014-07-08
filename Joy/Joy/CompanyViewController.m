//
//  CompanyViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-16.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "CompanyViewController.h"
#import "JoyViewController.h"
#import "ModuleViewController.h"
#import "SurveryViewController.h"
#import "Module.h"
#import "ModelCollectionViewCell.h"
#import "LogoStoreViewController.h"
#import "UIColor+Hex.h"

#define kReuseIdentifier @"Cell"

@interface CompanyViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (readwrite) NSMutableArray *colors;
@property (readwrite) NSArray *modules;

@end

@implementation CompanyViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
	self = [super initWithCollectionViewLayout:layout];
	if (self) {
		UIImage *normalImage = [UIImage imageNamed:@"Home_icon"];
		UIImage *selectedImage = [UIImage imageNamed:@"Home_icon_press"];
		if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
			self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
		} else {
			[self.tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
		}
		self.title = NSLocalizedString(@"公司门户", nil);
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.collectionView.backgroundColor = [UIColor whiteColor];
	[self.collectionView registerClass:[ModelCollectionViewCell class] forCellWithReuseIdentifier:kReuseIdentifier];

	_colors = [NSMutableArray array];
	[_colors addObject:[UIColor hexRGB:0x2e8aef]];
	[_colors addObject:[UIColor hexRGB:0x474cfd]];
	[_colors addObject:[UIColor hexRGB:0x5e3cba]];
	[_colors addObject:[UIColor hexRGB:0x7ab102]];
	[_colors addObject:[UIColor hexRGB:0x01a31c]];
	[_colors addObject:[UIColor hexRGB:0x13771c]];
	[_colors addObject:[UIColor hexRGB:0xdfb700]];
	[_colors addObject:[UIColor hexRGB:0xf7a211]];
	[_colors addObject:[UIColor hexRGB:0xfe8649]];

	//TODO: hardcord for test
//	_modules = @[
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"101", @"ModuleName": @"公司福利"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"102", @"ModuleName": @"LOOG商店"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"103", @"ModuleName": @"特约商户"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"104", @"ModuleName": @"限时团购"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"105", @"ModuleName": @"通讯录"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"106", @"ModuleName": @"公告"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"107", @"ModuleName": @"活动"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"108", @"ModuleName": @"培训"}],
//				 [[Module alloc] initWithAttributes:@{@"ModuleId": @"109", @"ModuleName": @"调查"}]
//				 ];
	[[JAFHTTPClient shared] companyModulesWithBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_modules = [Module multiWithAttributesArray:multiAttributes];
			[self.collectionView reloadData];
		} else {
			[self displayHUDTitle:NSLocalizedString(@"错误", nil) message:error.description];
		}
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

+ (UICollectionViewFlowLayout *)flowLayout;
{
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
	return flowLayout;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _modules.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	ModelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
	Module *module = _modules[indexPath.row];
	cell.module = module;
	cell.icon = module.icon;
	cell.backgroundColor = _colors[indexPath.row % _colors.count];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [ModelCollectionViewCell size];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	Module *module = _modules[indexPath.row];
	Class class = module.childViewControllerClass;
	BOOL hideBottomBar = YES;
	UIViewController *controller;
	if (class == [ModuleViewController class]) {
		ModuleViewController *moduleViewController = [[ModuleViewController alloc] initWithStyle:UITableViewStyleGrouped];
		moduleViewController.module = _modules[indexPath.row];
		controller = moduleViewController;
	} else if (class == [LogoStoreViewController class]) {
		LogoStoreViewController *logoStore = [[LogoStoreViewController alloc] initWithStyle:UITableViewStyleGrouped];
		controller = logoStore;
		hideBottomBar = NO;
	} else {
		controller = [[class alloc] initWithNibName:nil bundle:nil];
	}
	
	controller.hidesBottomBarWhenPushed = hideBottomBar;
	[self.navigationController pushViewController:controller animated:YES];
}

@end
