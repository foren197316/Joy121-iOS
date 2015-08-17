//
//  FamilyInfoViewController.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "FamilyInfoViewController.h"
#import "EntryTableView.h"
#import "HobbyViewController.h"

@interface FamilyInfoViewController () <EntryTableViewDelegate> {
    EntryTableView *_tableView;
    NSArray *_datas;
}
@end

@implementation FamilyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _datas = @[@{@"icon": [UIImage imageNamed:@"entry_department"], @"title": @"应聘部门 : "},
               @{@"icon": [UIImage imageNamed:@"entry_position"], @"title": @"应聘职位 : "},
               @{@"icon": [UIImage imageNamed:@"entry_date"], @"title": @"到岗日期 : "},
               @{@"icon": [UIImage imageNamed:@"entry_nowaddress"], @"title": @"现  居  地 : "},
               @{@"icon": [UIImage imageNamed:@"entry_contactway"], @"title": @"联系电话 : "},
               @{@"icon": [UIImage imageNamed:@"entry_emergencyperson"], @"title": @"紧急联系人 : "},
               @{@"icon": [UIImage imageNamed:@"entry_emergencycontact"], @"title": @"紧急联系方式 : "},
               @{@"icon": [UIImage imageNamed:@"entry_houschold"], @"title": @"户口所在地 : "}];
    
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
    HobbyViewController *vc = [[HobbyViewController alloc] init];
    vc.title = @"兴趣爱好";
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
