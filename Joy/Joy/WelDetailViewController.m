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

@interface WelDetailViewController ()

@end

@implementation WelDetailViewController {
    NSInteger count;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的福利";
        count = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_countLabel.layer setBorderColor:[UIColor blackColor].CGColor];
    [_countLabel.layer setBorderWidth:.5];
    
    _titleLabel.text = _welInfo.welName;
    _scoreLabel.text = [NSString stringWithFormat:@"所需积分:%@ 分", _welInfo.score];
    _longDescribeTextView.text = _welInfo.longDescribe;
    [self loadImage];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadImage
{
    if ([_welInfo.picturesArray count] > 0) {
        [_imageScrollView setContentSize:CGSizeMake(_imageScrollView.frame.size.width * [_welInfo.picturesArray count], 150)];
        _pageControl.numberOfPages = [_welInfo.picturesArray count];
        for (int i = 0; i < [_welInfo.picturesArray count]; i++) {
            NSString *url = [NSString stringWithFormat:@"%@%@", IMAGE_URL, _welInfo.picturesArray[i]];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_imageScrollView.frame.size.width * i, 0, _imageScrollView.frame.size.width, 150)];
            [imageView setImageWithURL:[NSURL URLWithString:url]];
            [_imageScrollView addSubview:imageView];
        }
    }
}

- (IBAction)addToShopBox:(id)sender
{
    if (count == 0) {
        [self displayHUDTitle:nil message:@"份数不能为0!"];
        return;
    }
    BuyWelViewController *viewController = [[BuyWelViewController alloc] initWithNibName:@"BuyWelViewController" bundle:nil];
    viewController.info = _welInfo;
    viewController.times = count;
    [viewController addBackBtn];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)addButtonClick:(id)sender
{
    count ++;
    _countLabel.text = [NSString stringWithFormat:@"%d", count];
}

- (IBAction)reduceButtonClick:(id)sender
{
    count --;
    if (count < 0) {
        count = 0;
    }
    _countLabel.text = [NSString stringWithFormat:@"%d", count];
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
