//
//  HomeViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImageView+AFNetworking.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"首页";
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Home_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"Home_icon"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAdInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadAdInfo
{
    [[JAFHTTPClient shared] frontPicWithBlock:^(NSDictionary *result, NSError *error) {
        NSArray *returnObj = result[@"retobj"];
        if ([returnObj count] > 0) {
            [_recommandScroll setContentSize:CGSizeMake(_recommandScroll.frame.size.width * [returnObj count], 150)];
            _pageControl.numberOfPages = [returnObj count];
            [_loadingView stopAnimating];
            for (int i = 0; i < [returnObj count]; i++) {
                NSString *url = returnObj[i];
                url = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, 150)];
                [imageView setImageWithURL:[NSURL URLWithString:url]];
                [_recommandScroll addSubview:imageView];
            }
        }
    }];
}

- (IBAction)pageAction:(id)sender
{
    _recommandScroll.contentOffset = CGPointMake(self.view.frame.size.width * [sender currentPage],0);
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = _recommandScroll.frame.size.width;
    int page = floor((_recommandScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [_pageControl setCurrentPage:page];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
