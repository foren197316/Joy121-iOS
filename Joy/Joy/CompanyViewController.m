//
//  CompanyViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-16.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "CompanyViewController.h"
#import "JoyViewController.h"
#import "NoticeViewController.h"
#import "EventViewController.h"
#import "SurveryViewController.h"
#import "Module.h"
#import "ModelCollectionViewCell.h"
#import "UIColor+Hex.h"

#define kReuseIdentifier @"Cell"


@interface CompanyViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (readwrite) NSMutableArray *colors;
@property (readwrite) NSMutableArray *icons;
@property (readwrite) NSArray *modules;

@end

@implementation CompanyViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
	self = [super initWithCollectionViewLayout:layout];
	if (self) {
		UIImage *normalImage = [UIImage imageNamed:@"Home_icon_press"];
		UIImage *selectedImage = [UIImage imageNamed:@"Home_icon"];//TODO: 图片要换
		if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
			self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
		} else {
			[self.tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
		}
		self.title = NSLocalizedString(@"公司门户", nil);
	}
	return self;
}

//- (IBAction)joyClick:(id)sender
//{
//    JoyViewController *viewController = [[JoyViewController alloc] initWithNibName:@"JoyViewController" bundle:nil];
//    [viewController addBackBtn];
//    viewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewController animated:YES];
//}
//
//- (IBAction)noticeClick:(id)sender
//{
//    NoticeViewController *viewController = [[NoticeViewController alloc] initWithNibName:@"NoticeViewController" bundle:nil];
//    [viewController addBackBtn];
//    viewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewController animated:YES];
//}
//
//- (IBAction)eventClick:(id)sender
//{
//    EventViewController *viewController = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
//    [viewController addBackBtn];
//    viewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewController animated:YES];
//}
//
//- (IBAction)surveyClick:(id)sender
//{
//    SurveryViewController *viewController = [[SurveryViewController alloc] initWithNibName:@"SurveryViewController" bundle:nil];
//    [viewController addBackBtn];
//    viewController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:viewController animated:YES];
//}

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
	
	_icons = [NSMutableArray array];
	[_icons addObject:[UIImage imageNamed:@"company_1"]];
	[_icons addObject:[UIImage imageNamed:@"company_2"]];
	[_icons addObject:[UIImage imageNamed:@"company_3"]];
	[_icons addObject:[UIImage imageNamed:@"company_4"]];
	[_icons addObject:[UIImage imageNamed:@"company_5"]];
	[_icons addObject:[UIImage imageNamed:@"company_6"]];
	[_icons addObject:[UIImage imageNamed:@"company_7"]];
	[_icons addObject:[UIImage imageNamed:@"company_1"]];
	[_icons addObject:[UIImage imageNamed:@"company_2"]];
			  
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
	cell.module = _modules[indexPath.row];
	cell.icon = indexPath.row < _icons.count ? _icons[indexPath.row] : _icons[indexPath.row % _icons.count];
	cell.backgroundColor = indexPath.row < _colors.count ? _colors[indexPath.row] : _colors[indexPath.row % _colors.count];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return [ModelCollectionViewCell size];
}

@end
