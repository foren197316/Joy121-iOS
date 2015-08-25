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

@interface ApplyInfoViewController()  <EntryTableViewDelegate> {
    EntryTableView *_tableView;
    NSMutableArray *_datas;
    NSArray *_costCenteDatas;
}

@end

@implementation ApplyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _datas = [NSMutableArray array];

    
    _tableView = [[EntryTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _tableView.entryDelegate = self;
    [self.view addSubview:_tableView];
    
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
            [button setTitle:[JPersonInfo person].ComDep == nil ? @"请选择" : [JPersonInfo person].ComDep forState:UIControlStateNormal];
        } clickHandler:^{
            [[JAFHTTPClient shared] getSysDataWithType:@"CostCenterno" parentId:-1 success:^(NSArray *sysDatas) {
                _costCenteDatas = sysDatas;
                NSMutableArray *datas = [NSMutableArray array];
                for (JSysData *data in sysDatas) {
                    [datas addObject:data.SysKeyName];
                }
                [ActionSheetStringPicker showPickerWithTitle:@"选择部门"
                                                        rows:datas
                                            initialSelection:0
                                                   doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                       [JPersonInfo person].ComDep = [datas objectAtIndex:selectedIndex];
                                                       [_tableView reloadData];
                                                   }
                                                 cancelBlock:^(ActionSheetStringPicker *picker) {
                                                     NSLog(@"Block Picker Canceled");
                                                 }
                                                      origin:self.view];
            } failure:^(NSString *msg) {
                
            }];
        }];
        [_datas addObject:cell];
    }
    {
        ApplyPickerCell *cell = [[ApplyPickerCell alloc] initWithLabelString:@"应聘职位 : " labelImage:[UIImage imageNamed:@"entry_position"] updateHandler:^(UIButton *button) {
            [button setTitle:[JPersonInfo person].ComPos == nil ? @"请选择" : [JPersonInfo person].ComPos  forState:UIControlStateNormal];
        } clickHandler:^{
            if ([JPersonInfo person].ComDep == nil) {
                return;
            }
        }];
        [_datas addObject:cell];
    }
    {
        ApplyPickerCell *cell = [[ApplyPickerCell alloc] initWithLabelString:@"到岗日期 : " labelImage:[UIImage imageNamed:@"entry_date"] updateHandler:^(UIButton *button) {
            [button setTitle:[JPersonInfo person].ComEntryDate forState:UIControlStateNormal];
        } clickHandler:^{
            
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

- (void)entryTableViewSaveEvent:(EntryTableView *)tableView {
}

- (void)entryTableViewNextEvent:(EntryTableView *)tableView {
    UserInfoViewController *vc = [[UserInfoViewController alloc] init];
    vc.title = @"个人信息";
    [self.navigationController pushViewController:vc animated:YES];
}


@end
