//
//  EventDetailViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "EventDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface EventDetailViewController ()

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
    
    _titleLabel.text = _event.title;
    _countLabel.text = [NSString stringWithFormat:@"%@/%@", _event.joinCount, _event.limitCount];
    _endTimeLabel.text = _event.endTime;
    _locationLabel.text = _event.location;
    _describeTextView.text = _event.shortDescribe;
   
	[_joinButton setTitle:_event.status forState:UIControlStateNormal];
	[_joinButton setUserInteractionEnabled:_event.isEnabled];
	_joinButton.backgroundColor = _event.isEnabled ? [UIColor themeColor] : [UIColor grayColor];
	
    [self loadImage];
}

- (void)loadImage
{
    [_imageScrollView setContentSize:CGSizeMake(_imageScrollView.frame.size.width * 1, 150)];
    _pageControl.numberOfPages = 1;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _imageScrollView.frame.size.width, 150)];
    [imageView setImageWithURL:[NSURL URLWithString:_event.iconUrl]];
    [_imageScrollView addSubview:imageView];
}

- (IBAction)joinButtonClick:(id)sender
{
    NSLog(@"加入!");
    [[JAFHTTPClient shared] joinEvent:_event.eventId fee:_event.eventFee withBlock:^(BOOL success, NSError *error) {
		if (success) {
			UIButton *btn = sender;
			[btn setBackgroundColor:[UIColor grayColor]];
			[btn setTitle:@"已报名" forState:UIControlStateNormal];
			[btn setUserInteractionEnabled:NO];
		} else {
			[self displayHUDTitle:nil message:@"报名失败!"];
		}
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
