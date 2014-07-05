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
#import "JoyViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSArray *welArrays;
    NSInteger count;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        count = 0;
        welArrays = [[NSArray alloc] init];
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Home_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"Home_icon"]];
        self.tabBarItem.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTitleIconWithTitle:@"首页"];
    [_tableView setTableHeaderView:_headView];
    [self loadAdInfo];
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneButton setFrame:CGRectMake(0, 0, 20, 20)];
    [phoneButton setImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(showTelActionSheet) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *phoneItem = [[UIBarButtonItem alloc] initWithCustomView:phoneButton];
    self.navigationItem.rightBarButtonItem = phoneItem;
    // Do any additional setup after loading the view from its nib.
}

- (void)showTelActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"客服电话"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"400-8558-121", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.firstOtherButtonIndex == buttonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-8558-121"]];
    }
}

- (IBAction)holidayWel:(id)sender
{
    JoyViewController *viewController = [[JoyViewController alloc] initWithNibName:@"JoyViewController" bundle:nil];
    [viewController addBackBtn];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    //    self.tabBarController.selectedIndex = 1;
}

- (void)userWelList
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userPackageList:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if (result[@"retobj"] && [result[@"retobj"] isKindOfClass:[NSArray class]]) {
            NSArray *resultArray = result[@"retobj"];
            if ([resultArray count] > 0) {
				welArrays = [WelInfo multiWithAttributesArray:resultArray];
                [_tableView reloadData];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR];
        }
    }];
}

- (NSInteger)getCellCount
{
    NSInteger cellCount = 0;
    if ([welArrays count] %2 == 0) {
        cellCount = [welArrays count] / 2;
    } else {
        cellCount = [welArrays count] - 1;
    }
    return cellCount;
}

- (void)loadAdInfo
{
    [[JAFHTTPClient shared] frontPicWithBlock:^(NSDictionary *result, NSError *error) {
        NSArray *returnObj = result[@"retobj"];
        if ([returnObj count] > 0) {
            [_recommandScroll setContentSize:CGSizeMake(_recommandScroll.frame.size.width * [returnObj count], 150)];
            _pageControl.numberOfPages = [returnObj count];
            [_loadingView stopAnimating];
            count = [returnObj count];
            if (count > 0) {
                [self startAutoPaging];
            }
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
    CGFloat pageWidth = _recommandScroll.frame.size.width;
    NSInteger page = _pageControl.currentPage + 1;
    if (page >= count) {
        page = 0;
    }
    CGPoint offset = CGPointMake(pageWidth * page, 0);
    [_recommandScroll setContentOffset:offset animated:true];
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
    [viewController addBackBtn];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 22)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, 120, 20)];
    [titleLabel setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:119.0/255.0 blue:48.0/255.0 alpha:1.0]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setText:@"我的福利"];
    [titleView addSubview:titleLabel];
    return titleView;
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
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(start_X, 1, 155, 68)];
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
    nameLabel.text = info.typeName;
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
    [viewController addBackBtn];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
