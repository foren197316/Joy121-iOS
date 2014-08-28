//
//  WelDetailViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "WelDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "BuyWelViewController.h"
#import "DSHCart.h"
#import "DSHGoodsQuantityView.h"

@interface WelDetailViewController ()

@property (readwrite) DSHGoodsQuantityView *quantityView;

@end

@implementation WelDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"我的福利", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _titleLabel.text = _welInfo.typeName;
	_titleLabel.textColor = [UIColor blackColor];
	
    _scoreLabel.text = [NSString stringWithFormat:@"所需积分:%@ 分", _welInfo.score];
	_scoreLabel.textColor = [UIColor blackColor];
	
    _longDescribeTextView.text = _welInfo.longDescribe;
	_longDescribeTextView.textColor = [UIColor blackColor];
	
	_describeTitleLabel.textColor = [UIColor blackColor];
	
	CGSize size = [DSHGoodsQuantityView size];
	_quantityView = [[DSHGoodsQuantityView alloc] initWithFrame:CGRectMake(100, 210, size.width, size.height)];
	[_backgroundView addSubview:_quantityView];
	
	[_addToCartButton addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
	
	if ([_welInfo.picturesArray count] > 0) {
		[_imageScrollView setContentSize:CGSizeMake(_imageScrollView.frame.size.width * [_welInfo.picturesArray count], 150)];
		_pageControl.numberOfPages = [_welInfo.picturesArray count];
		[self autoScroll];
		for (int i = 0; i < [_welInfo.picturesArray count]; i++) {
			NSString *url = [NSString stringWithFormat:@"%@%@", [JAFHTTPClient imageURLString], _welInfo.picturesArray[i]];
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_imageScrollView.frame.size.width * i, 0, _imageScrollView.frame.size.width, 150)];
			[imageView setImageWithURL:[NSURL URLWithString:url]];
			[_imageScrollView addSubview:imageView];
		}
	}
}

- (void)addToCart
{
	[[DSHCart shared] setWel:_welInfo quanlity:@(_quantityView.quantity)];
	[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
	[self displayHUDTitle:NSLocalizedString(@"已经加入购物车", nil) message:nil duration:1];
}

- (void)autoScroll
{
	CGFloat pageWidth = _imageScrollView.frame.size.width;
	NSInteger page = _pageControl.currentPage + 1;
	if (page >= [_welInfo.picturesArray count]) {
		page = 0;
	}
	CGPoint offset = CGPointMake(pageWidth * page, 0);
	[_imageScrollView setContentOffset:offset animated:true];
	[self performSelector:@selector(autoScroll) withObject:nil afterDelay:5];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = _imageScrollView.frame.size.width;
    int page = floor((_imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [_pageControl setCurrentPage:page];
}

@end
