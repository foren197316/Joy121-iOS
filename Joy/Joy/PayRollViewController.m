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
@property (readwrite) NSMutableDictionary *dict;
@end

@implementation PayRollViewController
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"工资单", nil);
    }
    return self;
}
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
            payroll.username=@"summer";
            
            
            PayRoll *payroll2=[[PayRoll alloc] init];
            payroll2.id=@"1";
            payroll2.realwagwages=@"1111221";
            payroll2.payablepay=@"111.111";
            payroll2.subsidysum=@"11.121";
            payroll2.sequestrate=@"11.11";
            payroll2.username=@"summer2";
            _PayRolls=@[payroll,payroll2];
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
    NSString * message=[NSString stringWithFormat:@"确认查看%@工资单吗？",payroll.username];
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
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 25, 60, 20)];
    [dateLabel setFont:[UIFont systemFontOfSize:18]];
    dateLabel.textColor = [UIColor blackColor];
    [dateLabel setBackgroundColor:[UIColor yellowColor]];
    dateLabel.text = @"实发工资";
    [cell addSubview:dateLabel];

    
    PayRoll *payroll=_PayRolls[indexPath.row];
    cell.textLabel.text=payroll.payablepay;
    
    return cell;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (!_dict) {
//        return nil;
//    }
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    UILabel *typeName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 68, 20)];
//    [typeName setFont:[UIFont systemFontOfSize:15]];
//    [typeName setBackgroundColor:[UIColor clearColor]];
//    typeName.textColor = [UIColor blackColor];
//    typeName.text = @"测试";
//    [view addSubview:typeName];
//    
//    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 200, 20)];
//    [dateLabel setFont:[UIFont systemFontOfSize:12]];
//    dateLabel.textColor = [UIColor blackColor];
//    [dateLabel setBackgroundColor:[UIColor clearColor]];
//    dateLabel.text = @"测试2";
//    [view addSubview:dateLabel];
//    return view;
//}


@end
