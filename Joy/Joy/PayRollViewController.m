//
//  PayRollViewController.m
//  Joy
//
//  Created by summer on 11/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "PayRollViewController.h"
#import "PayRoll.h"

@interface PayRollViewController ()
@property(readwrite) NSArray * PayRolls;
@end

@implementation PayRollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] officeDepotWithBlock:^(NSArray *multiAttributes, NSError *error) {
        [self hideHUD:YES];
        if(!error)
        {
            PayRoll *payroll=[[PayRoll alloc] init];
            payroll.id=@"1";
            payroll.realwagwages=@"1111.111";
            payroll.payablepay=@"111.111";
            payroll.subsidysum=@"11.11";
            payroll.sequestrate=@"11.11";
            _PayRolls=@[payroll];
            [self.tableView reloadData];
        }
    }];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)rent:(UIButton *) sender
{
    NSInteger tag=sender.tag;
    PayRoll *payroll=_PayRolls[tag];
    NSString * message=[NSString stringWithFormat:@"确认查看%@工资单吗？",payroll.id];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    [[JAFHTTPClient shared] submitDepotRent:payroll.id number:@(1) withBlock:^(NSError *error) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _PayRolls.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(tableView.frame.size.width - 40, 10, 40, 30);
    [button setTitle:NSLocalizedString(@"详情", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tag = indexPath.row;
    [button addTarget:self action:@selector(rent:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    
    PayRoll *payroll=_PayRolls[indexPath.row];
    cell.textLabel.text=payroll.payablepay;
    return cell;
}
@end
