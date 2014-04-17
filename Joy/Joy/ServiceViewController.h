//
//  ServiceViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UIButton *liftSmallBtn;
@property (nonatomic, weak) IBOutlet UIButton *liftBigBtn;
@property (nonatomic, weak) IBOutlet UIButton *healthSmallBtn;
@property (nonatomic, weak) IBOutlet UIButton *healthBigBtn;
@property (nonatomic, weak) IBOutlet UIButton *saveSmallBtn;
@property (nonatomic, weak) IBOutlet UIButton *saveBigBtn;

- (IBAction)liftBtnClick:(id)sender;
- (IBAction)healthBtnClick:(id)sender;
- (IBAction)saveBtnClick:(id)sender;
@end
