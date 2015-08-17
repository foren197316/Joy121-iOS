//
//  CardInfoViewController.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "CardInfoViewController.h"
#import "EntryTableView.h"
#import "ExperienceViewController.h"

@interface CardInfoViewController () <EntryTableViewDelegate> {
    EntryTableView *_tableView;
    NSArray *_datas;
}

@end

@implementation CardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _datas = @[@{@"icon": [UIImage imageNamed:@"entry_myself"], @"title": @"证  件  照 : "},
               @{@"icon": [UIImage imageNamed:@"entry_myselfvideo"], @"title": @"我的视频 : "},
               @{@"icon": [UIImage imageNamed:@"entry_academicphoto"], @"title": @"学习证书 : "},
               @{@"icon": [UIImage imageNamed:@"entry_idphoto"], @"title": @"身  份  证 : "},
               @{@"icon": [UIImage imageNamed:@"entry_rapairorder"], @"title": @"退  工  单 : "},
               @{@"icon": [UIImage imageNamed:@"entry_checkreproting"], @"title": @"体检报告 : "}];
    
    _tableView = [[EntryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.entryDelegate = self;
    [self.view addSubview:_tableView];
    _tableView.datas = _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)entryTableViewSaveEvent:(EntryTableView *)tableView {
}

- (void)entryTableViewNextEvent:(EntryTableView *)tableView {
    ExperienceViewController *vc = [[ExperienceViewController alloc] init];
    vc.title = @"个人经历";
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
