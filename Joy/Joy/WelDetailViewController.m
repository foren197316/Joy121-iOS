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

@interface WelDetailViewController ()

@property (readwrite) UILabel *quantityLabel;
@property (readwrite) NSInteger quantity;

@end

@implementation WelDetailViewController {
    NSInteger count;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"我的福利", nil);
        count = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_countLabel.layer setBorderColor:[UIColor blackColor].CGColor];
    [_countLabel.layer setBorderWidth:.5];
    
    _titleLabel.text = _welInfo.typeName;
    _scoreLabel.text = [NSString stringWithFormat:@"所需积分:%@ 分", _welInfo.score];
    _longDescribeTextView.text = _welInfo.longDescribe;
    [self loadImage];
	
	CGRect frame = CGRectMake(85, 210, 35, 35);
	UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[minusButton setImage:[UIImage imageNamed:@"Minus"] forState:UIControlStateNormal];
	minusButton.frame = frame;
	[minusButton addTarget:self action:@selector(decrease) forControlEvents:UIControlEventTouchUpInside];
	[_backgroundView addSubview:minusButton];
	
	frame.origin.x = CGRectGetMaxX(minusButton.frame) + 5;
	_quantityLabel = [[UILabel alloc] initWithFrame:frame];
	_quantityLabel.text = @"1";
	_quantityLabel.layer.borderColor = [[UIColor grayColor] CGColor];
	_quantityLabel.layer.borderWidth = 2;
	_quantityLabel.textAlignment = NSTextAlignmentCenter;
	[_backgroundView addSubview:_quantityLabel];
	
	frame.origin.x = CGRectGetMaxX(_quantityLabel.frame) + 5;
	UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[plusButton setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
	plusButton.frame = frame;
	[plusButton addTarget:self action:@selector(increase) forControlEvents:UIControlEventTouchUpInside];
	[_backgroundView addSubview:plusButton];

	_quantity = 1;
}

- (void)increase
{
	_quantity++;
	_quantityLabel.text = [NSString stringWithFormat:@"%ld", _quantity];
}

- (void)decrease
{
	_quantity--;
	if (_quantity == 0) {
		_quantity = 1;
	}
	_quantityLabel.text = [NSString stringWithFormat:@"%ld", _quantity];
}

- (void)loadImage
{
    if ([_welInfo.picturesArray count] > 0) {
        [_imageScrollView setContentSize:CGSizeMake(_imageScrollView.frame.size.width * [_welInfo.picturesArray count], 150)];
        _pageControl.numberOfPages = [_welInfo.picturesArray count];
        [self startAutoPaging];
        for (int i = 0; i < [_welInfo.picturesArray count]; i++) {
            NSString *url = [NSString stringWithFormat:@"%@%@", [JAFHTTPClient imageURLString], _welInfo.picturesArray[i]];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_imageScrollView.frame.size.width * i, 0, _imageScrollView.frame.size.width, 150)];
            [imageView setImageWithURL:[NSURL URLWithString:url]];
            [_imageScrollView addSubview:imageView];
        }
    }
}

- (IBAction)addToShopBox:(id)sender
{
	[[DSHCart shared] setWel:_welInfo quanlity:@(_quantity)];
	[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
	[self displayHUDTitle:NSLocalizedString(@"已经加入购物车", nil) message:nil duration:1];
//TODO:
//    if (count == 0) {
//        [self displayHUDTitle:nil message:@"份数不能为0!"];
//        return;
//    }
//    BuyWelViewController *viewController = [[BuyWelViewController alloc] initWithNibName:@"BuyWelViewController" bundle:nil];
//    viewController.info = _welInfo;
//    viewController.times = count;
//    [self.navigationController pushViewController:viewController animated:YES];
}

//定时器
-(void)startAutoPaging
{
    //时间间隔
    NSTimeInterval timeInterval = 5.0 ;
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(handleShowTimer:)
                                   userInfo:nil
                                    repeats:true];
}

//触发事件
-(void)handleShowTimer:(NSTimer *)theTimer
{
    CGFloat pageWidth = _imageScrollView.frame.size.width;
    NSInteger page = _pageControl.currentPage + 1;
    if (page >= [_welInfo.picturesArray count]) {
        page = 0;
    }
    CGPoint offset = CGPointMake(pageWidth * page, 0);
    [_imageScrollView setContentOffset:offset animated:true];
}

- (IBAction)addButtonClick:(id)sender
{
}

- (IBAction)reduceButtonClick:(id)sender
{
//    count --;
//    if (count < 0) {
//        count = 0;
//    }
//    _countLabel.text = [NSString stringWithFormat:@"%d", count];
}

- (IBAction)pageAction:(id)sender
{
    _imageScrollView.contentOffset = CGPointMake(self.view.frame.size.width * [sender currentPage],0);
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = _imageScrollView.frame.size.width;
    int page = floor((_imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [_pageControl setCurrentPage:page];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
