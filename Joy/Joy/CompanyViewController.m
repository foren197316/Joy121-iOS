//
//  CompanyViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-16.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "CompanyViewController.h"
#import "JoyViewController.h"
#import "NoticeViewController.h"
#import "EventViewController.h"
#import "SurveryViewController.h"


@interface CompanyViewController ()

@end

@implementation CompanyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"Home_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"Home_icon"]];
		self.tabBarItem.title = NSLocalizedString(@"公司门户", nil);
    }
    return self;
}

- (IBAction)joyClick:(id)sender
{
    JoyViewController *viewController = [[JoyViewController alloc] initWithNibName:@"JoyViewController" bundle:nil];
    [viewController addBackBtn];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)noticeClick:(id)sender
{
    NoticeViewController *viewController = [[NoticeViewController alloc] initWithNibName:@"NoticeViewController" bundle:nil];
    [viewController addBackBtn];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)eventClick:(id)sender
{
    EventViewController *viewController = [[EventViewController alloc] initWithNibName:@"EventViewController" bundle:nil];
    [viewController addBackBtn];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)surveyClick:(id)sender
{
    SurveryViewController *viewController = [[SurveryViewController alloc] initWithNibName:@"SurveryViewController" bundle:nil];
    [viewController addBackBtn];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTitleIconWithTitle:@"公司门户"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
