//
//  ExperienceViewController.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "ExperienceViewController.h"
#import "EntryTableView.h"
#import "FamilyInfoViewController.h"

@interface ExperienceViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    int _selectType;
}

@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    if ([JPersonInfo person].Experiences == nil) {
        [JPersonInfo person].Experiences = [[JExperiences alloc] init];
        [JPersonInfo person].Experiences.Learning = @[];
        [JPersonInfo person].Experiences.Job = @[];
    }
    _selectType = 0;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40)];
    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.width, 40)];
    [self.view addSubview:headerView];
    UIButton *learnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, headerView.width / 2, headerView.height)];
    learnButton.backgroundColor = [UIColor colorWithRed:0.44 green:0.7 blue:0.88 alpha:1];
    [learnButton setTitle:@"学习经历" forState:UIControlStateNormal];
    [learnButton addTarget:self action:@selector(clickLearn:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:learnButton];
    UIButton *jobButton = [[UIButton alloc] initWithFrame:CGRectMake(learnButton.right, 0, headerView.width / 2, headerView.height)];
    jobButton.backgroundColor = [UIColor colorWithRed:0.53 green:0.72 blue:0.5 alpha:1];
    [jobButton setTitle:@"工作经验" forState:UIControlStateNormal];
    [jobButton addTarget:self action:@selector(clickJob:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:jobButton];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.bottom, _tableView.width, 50)];
    _tableView.tableFooterView = footerView;
    
    float emptyWidth = (footerView.width - 240) / 3;
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(emptyWidth, 10, 120, 40)];
    [saveButton setTitle:@"保    存" forState:UIControlStateNormal];
    [saveButton setTintColor:[UIColor whiteColor]];
    [saveButton setBackgroundImage:[[UIColor colorWithRed:0.54 green:0.6 blue:0.64 alpha:1] toImage] forState:UIControlStateNormal];
    saveButton.layer.borderColor = [UIColor colorWithRed:0.67 green:0.73 blue:0.76 alpha:1].CGColor;
    saveButton.layer.borderWidth = 4;
    [saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:saveButton];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(emptyWidth * 2 + 120, 10, 120, 40)];
    [nextButton setTitle:@"下一步 >" forState:UIControlStateNormal];
    [nextButton setTintColor:[UIColor whiteColor]];
    [nextButton setBackgroundImage:[[UIColor colorWithRed:0.38 green:0.61 blue:0.35 alpha:1] toImage] forState:UIControlStateNormal];
    nextButton.layer.borderColor = [UIColor colorWithRed:0.51 green:0.71 blue:0.48 alpha:1].CGColor;
    nextButton.layer.borderWidth = 4;
    [nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:nextButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickLearn:(id)sender {
    _selectType = 0;
    [_tableView reloadData];
}

- (void)clickJob:(id)sender {
    _selectType = 1;
    [_tableView reloadData];
}

- (void)save:(id)sender {
    
}

- (void)next:(id)sender {
    FamilyInfoViewController *vc = [[FamilyInfoViewController alloc] init];
    vc.title = @"家庭信息";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma uitableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_selectType == 0) {
        return [JPersonInfo person].Experiences.Learning.count;
    } else {
        return [JPersonInfo person].Experiences.Job.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectType == 0) {
        
    } else {
        
    }
    return [[UITableViewCell alloc] initWithFrame:CGRectZero];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
