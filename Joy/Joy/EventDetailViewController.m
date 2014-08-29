//
//  EventDetailViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "EventDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface EventDetailViewController () <UIAlertViewDelegate>

@end

@implementation EventDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title =  NSLocalizedString(@"活动详情", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_scrollView setContentSize:CGSizeMake(320, 568)];
	
	_titleLabel.textColor = [UIColor blackColor];
	_locationTitleLabel.textColor = [UIColor blackColor];
	_contentTitleLabel.textColor = [UIColor blackColor];
	_countLabel.textColor = [UIColor blackColor];
	_endTimeLabel.textColor = [UIColor blackColor];
	
    [self loadImage];
	[self refreshInterface];
}

- (void)loadImage
{
    [_imageScrollView setContentSize:CGSizeMake(_imageScrollView.frame.size.width * 1, 150)];
    _pageControl.numberOfPages = 1;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _imageScrollView.frame.size.width, 150)];
    [imageView setImageWithURL:[NSURL URLWithString:_event.iconUrl]];
    [_imageScrollView addSubview:imageView];
}

- (void)refreshInterface
{
	_titleLabel.text = _event.title;
    _countLabel.text = [NSString stringWithFormat:@"%@/%@", _event.joinCount, _event.limitCount];
    _endTimeLabel.text = _event.endTime;
    _locationLabel.text = _event.location;
    _describeTextView.text = _event.shortDescribe;
	[_joinButton setTitle:_event.status forState:UIControlStateNormal];
	_joinButton.backgroundColor = [_event isEnabled] ? [UIColor secondaryColor] : [UIColor grayColor];
	_joinButton.userInteractionEnabled = [_event isEnabled];
}

- (IBAction)joinButtonClick:(id)sender
{
	UIAlertView *alert;
	if (_event.loginName) {
		alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"确定要退出吗？", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
	} else {
		alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"确定参加吗？", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:NSLocalizedString(@"确定", nil), nil];
	}
	[alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != alertView.cancelButtonIndex) {
		if (_event.loginName) {
			[[JAFHTTPClient shared] quitEvent:_event.eventId withBlock:^(BOOL success, NSError *error) {
				if (success) {
					NSInteger count = [_event.joinCount integerValue] - 1;
					_event.joinCount = [NSString stringWithFormat:@"%ld", count];
					_event.loginName = nil;
					[self refreshInterface];
					
					[self displayHUDTitle:nil message:@"退出成功!" duration:1];
					[_joinButton setTitle:NSLocalizedString(@"未报名", nil) forState:UIControlStateNormal];
				} else {
					[self displayHUDTitle:nil message:@"退出失败!" duration:1];
				}
			}];
		} else {
			[[JAFHTTPClient shared] joinEvent:_event.eventId fee:_event.eventFee withBlock:^(BOOL success, NSError *error) {
				if (success) {
					//TODO: hardcode 服务器应该返回状态才对
					NSInteger count = [_event.joinCount integerValue] + 1;
					_event.joinCount = [NSString stringWithFormat:@"%ld", count];
					_event.loginName = [[JAFHTTPClient shared] userName];
					[self refreshInterface];
					
					[self displayHUDTitle:nil message:@"报名成功!" duration:1];
					[_joinButton setTitle:NSLocalizedString(@"取消报名", nil) forState:UIControlStateNormal];
				} else {
					[self displayHUDTitle:nil message:@"报名失败!" duration:1];
				}
			}];
		}
	}
}

@end
