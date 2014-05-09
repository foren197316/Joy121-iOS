//
//  SurveryViewController.h
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveryCell.h"

@interface SurveryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SurveryCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end
