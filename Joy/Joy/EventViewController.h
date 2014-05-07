//
//  EventViewController.h
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventCell.h"

@interface EventViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, EventCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
