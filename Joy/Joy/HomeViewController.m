//
//  HomeViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "HomeViewController.h"
#import "WelInfo.h"
#import "UIImageView+AFNetworking.h"
#import "WelDetailViewController.h"
#import "MyOrderListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSArray *welArrays;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"首页";
        welArrays = [[NSArray alloc] init];
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

- (void)userWelList
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userPackageList:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if (result) {
            if ([result[@"retobj"] isKindOfClass:[NSArray class]]) {
                NSArray *resultArray = result[@"retobj"];
                if ([resultArray count] > 0) {
                    welArrays = [WelInfo createWelInfosWithArray:resultArray];
                    [_tableView reloadData];
                }
            }
        }
    }];
}

- (NSInteger)getCellCount
{
    NSInteger count = 0;
    if ([welArrays count]%2 == 0) {
        count = [welArrays count] / 2;
    } else {
        count = [welArrays count] - 1;
    }
    return count;
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
        [self userWelList];
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

- (IBAction)myOrderList:(id)sender
{
    MyOrderListViewController *viewController = [[MyOrderListViewController alloc] initWithNibName:@"MyOrderListViewController" bundle:nil];
    [viewController setHidesBottomBarWhenPushed:YES];
    [viewController setTitle:@"我的订单"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getCellCount];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
        [self createViewWithCell:cell andRight:NO andIndex:indexPath.row];
        [self createViewWithCell:cell andRight:YES andIndex:indexPath.row];
    }
    return cell;
}

- (void)createViewWithCell:(UITableViewCell *)cell
              andRight:(BOOL)right
              andIndex:(NSInteger)index
{
    NSInteger _index = index;
    CGFloat start_X = 0;
    if (right) {
        _index = _index + 1;
        start_X = 165;
    }
    if (index + 1 > [welArrays count]) {
        return;
    }
    WelInfo *info = welArrays[_index];
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(start_X, 0, 155, 70)];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [cell.contentView addSubview:backgroundView];
    
    UIButton *backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backgroundButton addTarget:self action:@selector(welButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundButton setTag:_index];
    [backgroundButton setFrame:CGRectMake(0, 0, 155, 70)];
    [backgroundView addSubview:backgroundButton];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    [iconImageView setImageWithURL:[NSURL URLWithString:info.headPic]];
    [backgroundView addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 90, 12)];
    [nameLabel setFont:[UIFont systemFontOfSize:12]];
    nameLabel.text = info.welName;
    [backgroundView addSubview:nameLabel];
    
    UILabel *shortDescribeLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 25, 90, 45)];
    [shortDescribeLabel setLineBreakMode:NSLineBreakByCharWrapping];
    [shortDescribeLabel setNumberOfLines:0];
    [shortDescribeLabel setFont:[UIFont systemFontOfSize:12]];
    shortDescribeLabel.text = info.shortDescribe;
    [backgroundView addSubview:shortDescribeLabel];
}

- (void)welButtonClick:(id)sender
{
    WelInfo *info = welArrays[[sender tag]];
    WelDetailViewController *viewController = [[WelDetailViewController alloc] initWithNibName:@"WelDetailViewController" bundle:nil];
    [viewController setWelInfo:info];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
