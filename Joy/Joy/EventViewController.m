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

@interface EventViewController ()

@end

@implementation EventViewController {
    NSArray *eventsArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"公司活动";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadEventList];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadEventList
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] eventList:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if ([result[@"retobj"] isKindOfClass:[NSArray class]]) {
            if ([result[@"retobj"] count] > 0) {
                eventsArray = [Event createEventsWithArray:result[@"retobj"]];
                [_tableView reloadData];
            }
        }
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
            [self loadEventList];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventsArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventCell *cell = (EventCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *event = eventsArray[indexPath.row];
    EventDetailViewController *viewCtrl = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:nil];
    [viewCtrl setEvent:event];
    [viewCtrl addBackBtn];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setDelegate:self];
        [cell setBackgroundColor:[UIColor clearColor]];
        if ([eventsArray count] > 0) {
            Event *event = eventsArray[indexPath.row];
            [cell setEvent:event];
        }
    }
    return cell;
}

@end
