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

#define TXT_COLOR [UIColor colorWithRed:253.0/255.0 green:175.0/255.0 blue:103.0/255.0 alpha:1.0]

@interface JoyViewController ()

@end

@implementation JoyViewController {
    NSArray *infoArray;
    NSMutableDictionary *dict;
    NSMutableArray *keysArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        infoArray = [NSArray array];
        keysArray = [[NSMutableArray alloc] init];
        self.title = @"节日福利";
        dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self userWelList];
    //    [_tableView setTableHeaderView:_headView];
    // Do any additional setup after loading the view from its nib.
}

- (void)createDataWithArray:(NSArray *)welArray
{
    for (int i = 0; i < [welArray count]; i ++) {
        WelInfo *info = welArray[i];
        if ([[dict allKeys] containsObject:info.typeName]) {
            NSMutableArray *arr = dict[info.typeName];
            [keysArray addObject:info.typeName];
            [arr addObject:info];
        } else {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [arr addObject:info];
            [dict setObject:arr forKey:info.typeName];
        }
    }
    [_tableView reloadData];
}

- (void)userWelList
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userPackageList:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if ([result[@"retobj"] isKindOfClass:[NSArray class]] && result[@"retobj"]) {
            NSArray *resultArray = result[@"retobj"];
            if ([resultArray count] > 0) {
                NSArray  *tmpArray = [WelInfo createWelInfosWithArray:resultArray];
                [self createDataWithArray:tmpArray];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR];
        }
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!dict) {
        return nil;
    }
    WelInfo *info = dict[keysArray[section]][0];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UILabel *typeName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 68, 20)];
    [typeName setFont:[UIFont systemFontOfSize:15]];
    [typeName setBackgroundColor:[UIColor clearColor]];
    [typeName setTextColor:TXT_COLOR];
    typeName.text = info.typeName;
    [view addSubview:typeName];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 200, 20)];
    [dateLabel setFont:[UIFont systemFontOfSize:12]];
    [dateLabel setTextColor:TXT_COLOR];
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    dateLabel.text = [NSString stringWithFormat:@"选购日期:%@~%@",info.startTime,info.endTime];
    [view addSubview:dateLabel];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dict[keysArray[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[dict allKeys] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WelDetailViewController *viewController = [[WelDetailViewController alloc] initWithNibName:@"WelDetailViewController" bundle:nil];
    viewController.welInfo = dict[keysArray[indexPath.section]][indexPath.row];
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
        [cell setInfo:dict[keysArray[indexPath.section]][indexPath.row]];
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
