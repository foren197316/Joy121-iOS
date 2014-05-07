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
        // Custom initialization
        self.title = @"活动详情";
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
    
    [self loadImage];
    // Do any additional setup after loading the view from its nib.
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
    [[JAFHTTPClient shared] joinEvent:_event.eventId fee:_event.eventFee withBlock:^(NSDictionary *result, NSError *error) {
        if (result) {
            if ([result[@"retobj"] integerValue] == 1) {
                UIButton *btn = sender;
                [btn setEnabled:NO];
                [btn setBackgroundColor:[UIColor grayColor]];
                [btn setTitle:@"已报名" forState:UIControlStateNormal];
            } else {
                [self displayHUDTitle:nil message:@"报名失败!"];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
