//
//  SystemViewController.m
//  Joy
//
//  Created by summer on 14/12/9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SystemViewController.h"
#import "EventDetailViewController.h"
#import "EventCell.h"
#import "NoticeCell.h"
#import "Event.h"
#import "Notice.h"
@interface SystemViewController () <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, EventCellDelegate>

@property (readwrite) UISegmentedControl *segmentedControl;
@property (readwrite) CompanyModuleType moduleType;
@property (readwrite) NSArray *multiAttributes;
@property (readwrite) NSArray *expiredMultiAttributes;
@property (readwrite) Event *currentEvent;
@end
@implementation SystemViewController

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
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"员工需知", nil), NSLocalizedString(@"公司政策",   2),NSLocalizedString(@"地方政策",3)]];
}
- (void)twoBtnsAction:(UISegmentedControl *)tempBtn
{
    switch (tempBtn.tag) {
        case 1:
            NSLog(@"123");
            break;
        case 2:
            NSLog(@"234");
            break;
        case 3:
            break;
        default:
            break;
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
