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
@property (readwrite) NSArray *infoArray;
@property (readwrite) NSMutableDictionary *dict;
@property (readwrite) NSMutableArray *keysArray;

@end

@implementation JoyViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.title = NSLocalizedString(@"公司福利", nil);
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_infoArray = [NSArray array];
	_keysArray = [[NSMutableArray alloc] init];
	_dict = [[NSMutableDictionary alloc] init];

	self.view.backgroundColor = [UIColor whiteColor];
    [self userWelList];
}

- (void)createDataWithArray:(NSArray *)welArray
{
    for (int i = 0; i < [welArray count]; i ++) {
        WelInfo *info = welArray[i];
        if ([[_dict allKeys] containsObject:info.typeName]) {
            NSMutableArray *arr = _dict[info.typeName];
            [_keysArray addObject:info.typeName];
            [arr addObject:info];
        } else {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [arr addObject:info];
            [_dict setObject:arr forKey:info.typeName];
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
    if (!_dict) {
        return nil;
    }
    WelInfo *info = _dict[_keysArray[section]][0];
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
    return [_dict[_keysArray[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_dict allKeys] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WelDetailViewController *viewController = [[WelDetailViewController alloc] initWithNibName:@"WelDetailViewController" bundle:nil];
    viewController.welInfo = _dict[_keysArray[indexPath.section]][indexPath.row];
	viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JoyCell *cell = nil;
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"JoyCell" owner:self options: nil];
        cell = [nib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setInfo:_dict[_keysArray[indexPath.section]][indexPath.row]];
        [cell setDelegate:self];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (!_dict) {
		return 1;
	}
	return heightOfHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 1;
}

@end
