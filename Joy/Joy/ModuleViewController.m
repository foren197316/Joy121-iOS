//
//  EventViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "ModuleViewController.h"
#import "EventDetailViewController.h"
#import "EventCell.h"
#import "Event.h"

@interface ModuleViewController () <UITableViewDataSource, UITableViewDelegate, EventCellDelegate>

@property (readwrite) UISegmentedControl *segmentedControl;
@property (readwrite) BOOL bTraining;
@property (readwrite) NSArray *data;
@property (readwrite) NSArray *expiredData;

@end

@implementation ModuleViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.title = _module.name;
	
	_segmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"最新发布", nil), NSLocalizedString(@"已过期", nil)]];
	_segmentedControl.selectedSegmentIndex = 0;
	[_segmentedControl addTarget:self action:@selector(segmentedControlChanged) forControlEvents:UIControlEventValueChanged];
	_segmentedControl.tintColor = [UIColor themeColor];
	
	_bTraining = [_module.name rangeOfString:@"培训"].location != NSNotFound;
	
	[self loadData];
}

- (void)segmentedControlChanged
{
	[self loadData];
}

- (void)loadData
{
	BOOL bExpired = NO;
	if (_segmentedControl.selectedSegmentIndex == 1) {
		bExpired = YES;
	}
	[self displayHUD:NSLocalizedString(@"加载中...", nil)];
    [[JAFHTTPClient shared] eventsIsExpired:bExpired isTraining:_bTraining withBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			if (bExpired) {
				_expiredData = [Event multiWithAttributesArray:multiAttributes];
			} else {
				_data = [Event multiWithAttributesArray:multiAttributes];
			}
			[self.tableView reloadData];
		}
        [self hideHUD:YES];
    }];
	[self.tableView reloadData];
}

- (void)joinButtonClicked:(Event *)event
{
    [[JAFHTTPClient shared] joinEvent:event.eventId fee:event.eventFee withBlock:^(NSDictionary *result, NSError *error) {
        if (result) {
            if ([result[@"retobj"] integerValue] == 1) {
                [self displayHUDTitle:nil message:@"报名成功!"];
            } else {
                [self displayHUDTitle:nil message:@"报名失败!"];
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_segmentedControl.selectedSegmentIndex == 0) {
		return _data.count;
	}
    return _expiredData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = (EventCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *event = _data[indexPath.row];
    EventDetailViewController *controller = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:nil];
	controller.event = event;
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
		cell.delegate = self;
    }
	if (_segmentedControl.selectedSegmentIndex == 0) {
		cell.event = _data[indexPath.row];
	} else {
		cell.event = _expiredData[indexPath.row];
	}
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	return _segmentedControl;
}

@end
