//
//  ApplyInfoViewController.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "ApplyInfoViewController.h"
#import "UserInfoViewController.h"
#import "EntryTableView.h"

@interface ApplyInfoViewController() {
    EntryTableView *_tableView;
    NSMutableArray *_datas;
    NSArray *_costCenteDatas;
    NSArray *_composes;
    JSysData *_costCenter;
    JSysData *_compose;
}

@end

@implementation ApplyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"入职管理";
    self.view.backgroundColor = [UIColor whiteColor];
    _costCenteDatas = @[];
    _composes = @[];
    _datas = [NSMutableArray array];

    
    _tableView = [[EntryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 60)];
    [self.view addSubview:_tableView];
    [self loadSaveBar];
    
    [self getCostCenteDatas];
}

- (void)getCostCenteDatas {
    __weak ApplyInfoViewController *weakVC = self;
    // 获取部门
    [[JAFHTTPClient shared] getSysDataWithType:@"CostCenterno" parentId:-1 success:^(NSArray *sysDatas) {
        _costCenteDatas = sysDatas;
        
        [[JAFHTTPClient shared] getSysDataWithType:@"Compos" parentId:-1 success:^(NSArray *sysDatas) {
            _composes = sysDatas;
            [weakVC getPersonInfo];
        } failure:^(NSString *msg) {
        }];
    } failure:^(NSString *msg) {

    }];
}

- (NSString *)costCenternoName:(NSString *)sysValue {
    for (JSysData *data in _costCenteDatas) {
        if ([data.SysValue isEqualToString:sysValue]) {
            return data.SysKeyName;
        }
    }
    return @"请选择";
}

- (NSString *)composName:(NSString *)sysValue {
    for (JSysData *data in _composes) {
        if ([data.SysValue isEqualToString:sysValue]) {
            return data.SysKeyName;
        }
    }
    return @"请选择";
}


- (void)getPersonInfo {
    // 获取个人信息
    __weak ApplyInfoViewController *weakVC = self;
    [[JAFHTTPClient shared] getPersonInfo:^(JPersonInfo *personInfo) {
        [JPersonInfo setPerson:personInfo];
        [weakVC updateInfo];
    } failure:^(NSString *msg) {
        
    }];
}

- (void)updateInfo {
    
    [_datas removeAllObjects];
    {
        ApplyPickerCell *cell = [[ApplyPickerCell alloc] initWithLabelString:@"应聘部门 : " labelImage:[UIImage imageNamed:@"entry_department"] updateHandler:^(UIButton *button) {
            [button setTitle:[self costCenternoName:[JPersonInfo person].ComDep] forState:UIControlStateNormal];
        } clickHandler:^{
            [ActionSheetStringPicker showPickerWithTitle:@"选择部门"
                                                    rows:_costCenteDatas
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   _costCenter = [_costCenteDatas objectAtIndex:selectedIndex];
                                                   _compose = nil;
                                                   [JPersonInfo person].ComDep = _costCenter.SysValue;
                                                   [JPersonInfo person].ComPos = nil;
                                                   [_tableView reloadData];
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];

        }];
        [_datas addObject:cell];
    }
    {
        ApplyPickerCell *cell = [[ApplyPickerCell alloc] initWithLabelString:@"应聘职位 : " labelImage:[UIImage imageNamed:@"entry_position"] updateHandler:^(UIButton *button) {
            [button setTitle:[self composName:[JPersonInfo person].ComPos] forState:UIControlStateNormal];
        } clickHandler:^{
            if (_composes.count == 0) {
                return;
            }
            [ActionSheetStringPicker showPickerWithTitle:@"选择职位"
                                                    rows:_composes
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   if (selectedIndex >= _composes.count) {
                                                       return;
                                                   }
                                                   _compose = [_composes objectAtIndex:selectedIndex];;
                                                   [JPersonInfo person].ComPos = _compose.SysValue;
                                                   [_tableView reloadData];
                                               }
                                             cancelBlock:^(ActionSheetStringPicker *picker) {
                                                 NSLog(@"Block Picker Canceled");
                                             }
                                                  origin:self.view];

        }];
        [_datas addObject:cell];
    }
    {
        ApplyPickerCell *cell = [[ApplyPickerCell alloc] initWithLabelString:@"到岗日期 : " labelImage:[UIImage imageNamed:@"entry_date"] updateHandler:^(UIButton *button) {
            [button setTitle:[[JPersonInfo person].ComEntryDate getCorrectDateWithoutTime] forState:UIControlStateNormal];
        } clickHandler:^{
            [ActionSheetDatePicker showPickerWithTitle:@"到岗日期" datePickerMode:UIDatePickerModeDate selectedDate:[[JPersonInfo person].ComEntryDate getCorrectDateDate] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                [JPersonInfo person].ComEntryDate = [selectedDate toCorrectDate];
                [_tableView reloadData];
            } cancelBlock:^(ActionSheetDatePicker *picker) {
                NSLog(@"Block Picker Canceled");
            } origin:self.view];
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"现  居  地 : " labelImage:[UIImage imageNamed:@"entry_nowaddress"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].Address;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].Address = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"联系电话 : " labelImage:[UIImage imageNamed:@"entry_contactway"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].Mobile;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].Mobile = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"紧急联系人 : " labelImage:[UIImage imageNamed:@"entry_emergencyperson"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].UrgentContact;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].UrgentContact = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"紧急联系方式 : " labelImage:[UIImage imageNamed:@"entry_emergencycontact"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].UrgentMobile;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].UrgentMobile = string;
        }];
        [_datas addObject:cell];
    }
    {
        ApplyTextFiledCell *cell = [[ApplyTextFiledCell alloc] initWithLabelString:@"户口所在地 : " labelImage:[UIImage imageNamed:@"entry_houschold"] updateHandler:^(UITextField *textFiled) {
            textFiled.text = [JPersonInfo person].Residence;
        } changeHandler:^(NSString *string) {
            [JPersonInfo person].Residence = string;
        }];
        [_datas addObject:cell];
    }
    _tableView.datas = _datas;
}

- (void)next:(id)sender {
    
    UserInfoViewController *vc = [[UserInfoViewController alloc] init];
    vc.title = @"个人信息";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
