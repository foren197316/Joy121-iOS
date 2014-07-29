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
#import "NoticeCell.h"
#import "Event.h"
#import "Notice.h"

@interface ModuleViewController () <UITableViewDataSource, UITableViewDelegate, EventCellDelegate>

@property (readwrite) UISegmentedControl *segmentedControl;
@property (readwrite) CompanyModuleType moduleType;
@property (readwrite) NSArray *multiAttributes;
@property (readwrite) NSArray *expiredMultiAttributes;

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
	
	_moduleType = [_module moduleType];
		
	[self loadData];
}

- (void)segmentedControlChanged
{
	[self loadData];
}

- (BOOL)expiredSelected
{
	return _segmentedControl.selectedSegmentIndex == 1;
}

- (NSDictionary *)attributesAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self expiredSelected]) {
		return _expiredMultiAttributes[indexPath.row];
	}
	return _multiAttributes[indexPath.row];
}

- (void)loadData
{
	BOOL bExpired = [self expiredSelected];
	[self displayHUD:NSLocalizedString(@"加载中...", nil)];
	
	if (_moduleType == CompanyModuleTypeNotice) {
		[[JAFHTTPClient shared] noticesIsExpired:bExpired withBlock:^(NSArray *multiAttributes, NSError *error) {
			if (!error) {
				if (bExpired) {
					_expiredMultiAttributes = multiAttributes;
				} else {
					_multiAttributes = multiAttributes;
				}
				[self.tableView reloadData];
			}
			[self hideHUD:YES];
		}];
	} else {
		BOOL bTraining = _moduleType == CompanyModuleTypeTraining;
		[[JAFHTTPClient shared] eventsIsExpired:bExpired isTraining:bTraining withBlock:^(NSArray *multiAttributes, NSError *error) {
			if (!error) {
				if (bExpired) {
					_expiredMultiAttributes = multiAttributes;
				} else {
					_multiAttributes = multiAttributes;
				}
				[self.tableView reloadData];
			}
			[self hideHUD:YES];
		}];
	}
		
	[self.tableView reloadData];
}

- (void)joinButtonClicked:(Event *)event
{
    [[JAFHTTPClient shared] joinEvent:event.eventId fee:event.eventFee withBlock:^(BOOL success, NSError *error) {
		if (success) {
			[self loadData];
			[self displayHUDTitle:nil message:@"报名成功!"];
		} else {
			[self displayHUDTitle:nil message:@"报名失败!"];
		}
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if ([self expiredSelected]) {
		return _expiredMultiAttributes.count;
	}
	return _multiAttributes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (_moduleType == CompanyModuleTypeNotice) {
	    NoticeCell *cell = (NoticeCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
		return [cell height];
	}
    EventCell *cell = (EventCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (_moduleType == CompanyModuleTypeNotice) {
		
	} else {
		NSDictionary *attributes = [self expiredSelected] ? _expiredMultiAttributes[indexPath.row] : _multiAttributes[indexPath.row];
		Event *event = [[Event alloc] initWithAttributes:attributes];
		event.bExpired = [self expiredSelected];
		EventDetailViewController *controller = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:nil];
		controller.event = event;
		[self.navigationController pushViewController:controller animated:YES];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
	if (_moduleType == CompanyModuleTypeNotice) {
		NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
		if (!cell) {
			cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
		}
		Notice *notice = [[Notice alloc] initWithAttributes:[self attributesAtIndexPath:indexPath]];
		notice.bExpired = [self expiredSelected];
		cell.bExpired = [self expiredSelected];
		cell.notice = notice;
		return cell;
	} else {
		EventCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
		if (!cell) {
			cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
			cell.delegate = self;
		}
		Event *event = [[Event alloc] initWithAttributes:[self attributesAtIndexPath:indexPath]];
		event.bExpired = [self expiredSelected];
		cell.bExpired = [self expiredSelected];
		cell.event = event;
		return cell;
	}
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
