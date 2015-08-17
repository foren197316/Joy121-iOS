//
//  UserInfoViewController.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "UserInfoViewController.h"
#import "EntryTableView.h"
#import "CardInfoViewController.h"

@interface UserInfoViewController () <EntryTableViewDelegate> {
    EntryTableView *_tableView;
    NSArray *_datas;
}

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _datas = @[@{@"icon": [UIImage imageNamed:@"entry_chinesename"], @"title": @"中  文  名 : "},
               @{@"icon": [UIImage imageNamed:@"entry_englishname"], @"title": @"英  文  名 : "},
               @{@"icon": [UIImage imageNamed:@"entry_gender"], @"title": @"性    别 : "},
               @{@"icon": [UIImage imageNamed:@"entry_birthplace"], @"title": @"籍    贯 : "},
               @{@"icon": [UIImage imageNamed:@"entry_idno"], @"title": @"身份证号 : "},
               @{@"icon": [UIImage imageNamed:@"entry_degreeno"], @"title": @"学历编号 : "},
               @{@"icon": [UIImage imageNamed:@"entry_accumulationno"], @"title": @"公积金编号 : "},
               @{@"icon": [UIImage imageNamed:@"entry_bankname"], @"title": @"开户银行 : "},
               @{@"icon": [UIImage imageNamed:@"entry_bankno"], @"title": @"银行账号 : "}];
    
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
    CardInfoViewController *vc = [[CardInfoViewController alloc] init];
    vc.title = @"证件信息";
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
