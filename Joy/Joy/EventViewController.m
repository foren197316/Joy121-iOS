//
//  EventViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "EventViewController.h"
#import "EventDetailViewController.h"
#import "EventCell.h"
#import "Event.h"

@interface EventViewController () <UITableViewDataSource, UITableViewDelegate, EventCellDelegate>

@property (readwrite) NSArray *events;

@end

@implementation EventViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.title = NSLocalizedString(@"公司活动", nil);
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] eventsIsExpired:NO isTraining:NO withBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_events = [Event multiWithAttributesArray:multiAttributes];
			[self.tableView reloadData];
		}
        [self hideHUD:YES];
    }];
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
    return _events.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = (EventCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *event = _events[indexPath.row];
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
	cell.event = _events[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 10;
}

@end
