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

@interface FamilyInfoViewController () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_datas;
}
@end

@implementation FamilyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([JPersonInfo person].Family == nil) {
        [JPersonInfo person].Family = @[];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
    
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

- (void)save:(id)sender {
    
}

- (void)next:(id)sender {
    HobbyViewController *vc = [[HobbyViewController alloc] init];
    vc.title = @"兴趣爱好";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma uitableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [JPersonInfo person].Family.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, tableView.width - 80, 20)];
        nameLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.tag = 10000;
        [cell.contentView addSubview:nameLabel];
        
        
        UILabel *birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, nameLabel.bottom, tableView.width - 80, 20)];
        birthdayLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
        birthdayLabel.font = [UIFont systemFontOfSize:15];
        birthdayLabel.tag = 10001;
        [cell.contentView addSubview:birthdayLabel];
        
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, birthdayLabel.bottom, tableView.width - 80, 20)];
        addressLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
        addressLabel.font = [UIFont systemFontOfSize:15];
        addressLabel.tag = 10002;
        [cell.contentView addSubview:addressLabel];
        
        
        UILabel *shipLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, addressLabel.bottom, tableView.width - 80, 20)];
        shipLabel.textColor = [UIColor colorWithRed:0.35 green:0.47 blue:0.58 alpha:1];
        shipLabel.font = [UIFont systemFontOfSize:15];
        shipLabel.tag = 10003;
        [cell.contentView addSubview:shipLabel];
    }
    JFamily *family = [[JPersonInfo person].Family objectAtIndex:indexPath.row];
    ((UILabel *)[cell.contentView viewWithTag:10000]).text = [NSString stringWithFormat:@"姓名：%@", family.Name];
    ((UILabel *)[cell.contentView viewWithTag:10001]).text = [NSString stringWithFormat:@"生日：%@", family.Birthday];
    ((UILabel *)[cell.contentView viewWithTag:10002]).text = [NSString stringWithFormat:@"地址：%@", family.Address];
    ((UILabel *)[cell.contentView viewWithTag:10003]).text = [NSString stringWithFormat:@"关系：%@", family.RelationShip];
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
