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
#import "DSHCart.h"

CGFloat const heightOfHeader = 30;

@interface JoyViewController () <JoyCellDelegate>

@property (readwrite) UITableView *tableView;

@end

@implementation JoyViewController {
    NSArray *infoArray;
    NSMutableDictionary *dict;
    NSMutableArray *keysArray;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.title = NSLocalizedString(@"公司福利", nil);
		infoArray = [NSArray array];
		keysArray = [[NSMutableArray alloc] init];
		dict = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    [self userWelList];
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
    [self.tableView reloadData];
}

- (void)userWelList
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userPackageList:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if ([result[@"retobj"] isKindOfClass:[NSArray class]] && result[@"retobj"]) {
            NSArray *resultArray = result[@"retobj"];
            if ([resultArray count] > 0) {
                NSArray  *tmpArray = [WelInfo multiWithAttributesArray:resultArray];
                [self createDataWithArray:tmpArray];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR];
        }
    }];
}

- (void)buyButtonClicked:(WelInfo *)info
{
	[[DSHCart shared] increaseWel:info];
	[[NSNotificationCenter defaultCenter] postNotificationName:DSH_NOTIFICATION_UPDATE_CART_IDENTIFIER object:nil];
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!dict) {
        return nil;
    }
    WelInfo *info = dict[keysArray[section]][0];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, heightOfHeader)];
    [view setBackgroundColor:[UIColor whiteColor]];
    UILabel *typeName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 68, 20)];
    [typeName setFont:[UIFont systemFontOfSize:15]];
    [typeName setBackgroundColor:[UIColor clearColor]];
	typeName.textColor = [UIColor blackColor];
    typeName.text = info.typeName;
    [view addSubview:typeName];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 200, 20)];
    [dateLabel setFont:[UIFont systemFontOfSize:12]];
	dateLabel.textColor = [UIColor blackColor];
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
	viewController.hidesBottomBarWhenPushed = YES;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (!dict) {
		return 1;
	}
	return heightOfHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 1;
}

@end
