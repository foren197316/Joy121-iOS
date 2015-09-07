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
    NSMutableArray *_family;
}
@end

@implementation FamilyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *family = [JPersonInfo person].Family;
//    id array = [NSJSONSerialization JSONObjectWithData:[[JPersonInfo person].Family dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    _family = [NSMutableArray arrayWithArray:[JFamily objectArrayWithKeyValuesArray:family]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60)];
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

- (void)next:(id)sender {
    HobbyViewController *vc = [[HobbyViewController alloc] init];
    vc.title = @"兴趣爱好";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma uitableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _family.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, tableView.width - 80, 20)];
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
    JFamily *family = [_family objectAtIndex:indexPath.row];
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
