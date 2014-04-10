//
//  MeViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JUser.h"

@interface MeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) JUser *user;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *realNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *companyLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, assign) BOOL bEdit;
- (IBAction)editButtonClicked:(id)sender;
- (IBAction)signOut:(id)sender;
@end
