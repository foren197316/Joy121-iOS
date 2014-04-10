//
//  MeDetailViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JUser.h"

@interface MeDetailViewController : UIViewController

@property (nonatomic, strong) JUser *user;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *realNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *companyLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
- (IBAction)signOut:(id)sender;
@end
