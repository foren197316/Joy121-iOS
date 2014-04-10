//
//  JoyViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "JoyViewController.h"
#import "JoyCell.h"
#import "WelInfo.h"
#import "WelDetailViewController.h"
#import "BuyWelViewController.h"

@interface JoyViewController ()

@end

@implementation JoyViewController {
    NSArray *infoArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        infoArray = [NSArray array];
        self.title = @"福利";
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"welfare_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"welfare_icon"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self userWelList];
    [_tableView setTableHeaderView:_headView];
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
                    infoArray = [WelInfo createWelInfosWithArray:resultArray];
                    if ([infoArray count] > 0) {
                        WelInfo *info = infoArray[0];
                        _nameLabel.text = info.welName;
                        _dateLabel.text = [NSString stringWithFormat:@"选购日期:%@~%@",info.startTime,info.endTime];
                    }
                    [_tableView reloadData];
                }
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WelDetailViewController *viewController = [[WelDetailViewController alloc] initWithNibName:@"WelDetailViewController" bundle:nil];
    viewController.welInfo = infoArray[indexPath.row];
    [viewController setHidesBottomBarWhenPushed:YES];
    [viewController addBackBtn];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JoyCell *cell = nil;
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"JoyCell" owner:self options: nil];
        cell = [nib objectAtIndex: 0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setInfo:infoArray[indexPath.row]];
        [cell setDelegate:self];
    }
    return cell;
}

- (void)buyButtonClicked:(WelInfo *)info
{
    BuyWelViewController *viewController = [[BuyWelViewController alloc] initWithNibName:@"BuyWelViewController" bundle:nil];
    [viewController setHidesBottomBarWhenPushed:YES];
    viewController.times = 1;
    viewController.info = info;
    [viewController addBackBtn];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
