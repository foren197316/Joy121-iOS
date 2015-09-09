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

@interface UserInfoViewController () {
    EntryTableView *_tableView;
    NSMutableArray *_datas;
}

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _datas = [NSMutableArray array];
    
    _tableView = [[EntryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60)];
    [self.view addSubview:_tableView];
    [self loadSaveBar];

    [self updateInfo];
}

- (void)updateInfo {
    [_datas removeAllObjects];
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"中  文  名 : " labelImage:[UIImage imageNamed:@"entry_chinesename"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].PersonName;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].PersonName = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"英  文  名 : " labelImage:[UIImage imageNamed:@"entry_englishname"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].EnglishName;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].EnglishName = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyPickerCell *cell = [[ApplyPickerCell alloc] initWithLabelString:@"性    别 : " labelImage:[UIImage imageNamed:@"entry_gender"] updateHandler:^(UIButton *button) {
            NSString *gender = [[JPersonInfo person].Gender isEqualToString:@"0"] ? @"男" : @"女";
            [button setTitle:gender forState:UIControlStateNormal];
        } clickHandler:^{
            [ActionSheetStringPicker showPickerWithTitle:@"选择职位"
                                                    rows:@[@"男", @"女"]
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   [JPersonInfo person].Gender = [NSString stringWithFormat:@"%i", @(selectedIndex).intValue];
                                                   [_tableView reloadData];
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];
            
        }];
        [_datas addObject:cell];
    }
//    {
//        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"性    别 : " labelImage:[UIImage imageNamed:@"entry_gender"] updateHandler:^(UITextField *textFiled) {
//            textFiled.text = [JPersonInfo person].Gender;
//        } changeHandler:^(NSString *string) {
//            [JPersonInfo person].Gender = string;
//        }];
//        [_datas addObject:cell];
//    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"籍    贯 : " labelImage:[UIImage imageNamed:@"entry_birthplace"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].Regions;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].Regions = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"身份证号 : " labelImage:[UIImage imageNamed:@"entry_idno"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].IdNo;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].IdNo = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"学历编号 : " labelImage:[UIImage imageNamed:@"entry_degreeno"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].EducationNo;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].EducationNo = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"公积金编号 : " labelImage:[UIImage imageNamed:@"entry_accumulationno"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].AccumFund;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].AccumFund = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"开户银行 : " labelImage:[UIImage imageNamed:@"entry_bankname"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].DepositBank;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].DepositBank = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"银行账号 : " labelImage:[UIImage imageNamed:@"entry_bankno"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].DepositCardNo;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].DepositCardNo = string;
        }];
        [_datas addObject:cell];
    }
    _tableView.datas = _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)next:(id)sender {
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
