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
    JExperiences *_experiences;
    NSArray *_colors;
}

@end

@implementation ExperienceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _experiences = [JExperiences objectWithKeyValues:[JPersonInfo person].Experiences];
    _selectType = 0;
    _colors = @[[UIColor colorWithRed:1 green:0.88 blue:0.53 alpha:1],
                [UIColor colorWithRed:0.53 green:0.72 blue:0.5 alpha:1],
                [UIColor colorWithRed:0.44 green:0.7 blue:0.88 alpha:1],
                [UIColor colorWithRed:0.32 green:0.32 blue:0.45 alpha:1]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, navHeight(self), self.view.width, 40)];
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headerView.bottom, self.view.width, self.view.height - 100)];
    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
    
    [self loadSaveBar];

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

- (void)next:(id)sender {
    FamilyInfoViewController *vc = [[FamilyInfoViewController alloc] init];
    vc.title = @"家庭信息";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma uitableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_selectType == 0) {
        return _experiences.Learning.count;
    } else {
        return _experiences.Job.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(50, 22, 4, 76)];
            colorView.tag = 9999;
            [cell.contentView addSubview:colorView];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, tableView.width - 120, 20)];
            nameLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
            nameLabel.font = [UIFont systemFontOfSize:13];
            nameLabel.tag = 10000;
            [cell.contentView addSubview:nameLabel];
            
            
            UILabel *birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, nameLabel.bottom, tableView.width - 120, 20)];
            birthdayLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
            birthdayLabel.font = [UIFont systemFontOfSize:13];
            birthdayLabel.tag = 10001;
            [cell.contentView addSubview:birthdayLabel];
            
            
            UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, birthdayLabel.bottom, tableView.width - 120, 20)];
            addressLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
            addressLabel.font = [UIFont systemFontOfSize:13];
            addressLabel.tag = 10002;
            [cell.contentView addSubview:addressLabel];
            
            
            UILabel *shipLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, addressLabel.bottom, tableView.width - 120, 20)];
            shipLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
            shipLabel.font = [UIFont systemFontOfSize:13];
            shipLabel.tag = 10003;
            [cell.contentView addSubview:shipLabel];
        }
    
    if (_selectType == 0) {
        JLearning *learn = [_experiences.Learning objectAtIndex:indexPath.row];
        [cell.contentView viewWithTag:9999].backgroundColor = [_colors objectAtIndex:indexPath.row % _colors.count];
        ((UILabel *)[cell.contentView viewWithTag:10000]).text = [NSString stringWithFormat:@"时间：%@", learn.Date];
        ((UILabel *)[cell.contentView viewWithTag:10001]).text = [NSString stringWithFormat:@"学校：%@", learn.School];
        ((UILabel *)[cell.contentView viewWithTag:10002]).text = [NSString stringWithFormat:@"专业：%@", learn.Profession];
        ((UILabel *)[cell.contentView viewWithTag:10003]).text = [NSString stringWithFormat:@"收获：%@", learn.Achievement];
    } else {
        JJob *job = [_experiences.Job objectAtIndex:indexPath.row];
        [cell.contentView viewWithTag:9999].backgroundColor = [_colors objectAtIndex:indexPath.row % _colors.count];
        ((UILabel *)[cell.contentView viewWithTag:10000]).text = [NSString stringWithFormat:@"时间：%@", job.Date];
        ((UILabel *)[cell.contentView viewWithTag:10001]).text = [NSString stringWithFormat:@"公司：%@", job.Company];
        ((UILabel *)[cell.contentView viewWithTag:10002]).text = [NSString stringWithFormat:@"职位：%@", job.Position];
        ((UILabel *)[cell.contentView viewWithTag:10003]).text = [NSString stringWithFormat:@"收获：%@", job.Achievement];
    }
        return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
