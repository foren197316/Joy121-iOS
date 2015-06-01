//
//  SalaryDetailView.m
//  Joy
//
//  Created by 无非 on 14/11/25.
//  Copyright (c) 2014年 颜超. All rights reserved.
//


#import "SalaryDetailViewController.h"

@interface SalaryDetailViewController () <UITableViewDataSource,UITableViewDelegate> {
    UITableView *salaryDetailTableView;
    NSArray *titleArray;
    NSMutableArray *basePayArray;
    NSMutableArray *leftNameArray;
    NSMutableArray *payrollminusArray;
    NSMutableArray *payrolltax;
}

@end

@implementation SalaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工资单详情";
    self.view.backgroundColor = [UIColor whiteColor];
	
    titleArray = [NSArray arrayWithObjects:@"基本薪资", @"薪资增项", @"薪资减项", @"计税薪资",nil];
    basePayArray = [NSMutableArray arrayWithObjects:@"基本工资:", nil];
    leftNameArray = [NSMutableArray arrayWithObjects:@"加班费:", @"津贴:", @"独生子女费:", @"奖金:", @"年终奖:", @"其他:", nil];
    payrollminusArray = [NSMutableArray arrayWithObjects:@"请假扣款合计:", @"个人养老保险:", @"个人养老保险补缴:", @"个人医疗保险:", @"个人医疗保险补缴:", @"个人失业保险:", @"个人失业保险补缴:", @"个人公积金:", @"个人公积金补缴:", nil];
    payrolltax = [NSMutableArray arrayWithObjects:@"税前工资:", @"所得税:", @"实发工资:", nil];
    salaryDetailTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    salaryDetailTableView.delegate = self;
    salaryDetailTableView.dataSource = self;
    [self.view addSubview:salaryDetailTableView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    view.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:1.0];
    salaryDetailTableView.tableHeaderView = view;
    UITextField *salaryFromLast = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, view.frame.size.width - 20, view.frame.size.height - 30)];
    [salaryFromLast setTextColor:[UIColor blackColor]];
    [salaryFromLast setTextAlignment:NSTextAlignmentCenter];
    salaryFromLast.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    salaryFromLast.enabled = NO;
    salaryFromLast.text = [@"￥" stringByAppendingString:_payRoll.realwages];
    salaryFromLast.font = [UIFont systemFontOfSize:25.0];
    salaryFromLast.layer.cornerRadius = 3.0f;
    salaryFromLast.layer.masksToBounds = YES;
    salaryFromLast.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:198.0f/255.0f blue:183.0f/255.0f alpha:1.0];
    [view addSubview:salaryFromLast];
	
    UILabel *dateFromLast = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 20)];
    [dateFromLast setTextColor:[UIColor blackColor]];
    [dateFromLast setTextAlignment:NSTextAlignmentCenter];
    NSString *year = [_payRoll.period substringToIndex:4];
    NSString *month = [_payRoll.period substringWithRange:NSMakeRange(4, 2)];
    NSString *newTime = [[year stringByAppendingString:@"/"] stringByAppendingString:month];
    dateFromLast.text = [@"薪资发放月份" stringByAppendingString:newTime];
    dateFromLast.font = [UIFont systemFontOfSize:12.0];
    dateFromLast.layer.cornerRadius = 3.0f;
    dateFromLast.layer.masksToBounds = YES;
    dateFromLast.backgroundColor = [UIColor clearColor];
    [view addSubview:dateFromLast];
    
	[self displayHUD:@"加载中..."];
	[[JAFHTTPClient shared] detailOfPayroll:_payRoll.period withBlock:^(NSDictionary *attributes, NSError *error) {
		if (!error) {
			[self hideHUD:YES];
			_payRoll = [[PayRoll alloc] initWithAttributes:attributes];
			[salaryDetailTableView reloadData];
		} else {
			[self displayHUDTitle:nil message:error.localizedDescription];
		}
	}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
		return basePayArray.count;
    } else if (section == 1){
		return leftNameArray.count;
    } else if(section == 2) {
        return payrollminusArray.count;
    } else {
        return payrolltax.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    if (indexPath.section == 0) {//基本薪资
        cell.textLabel.text = @"基本工资：";
        NSString *string = @"";
        string = _payRoll.basepay;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@", string];
    } else if (indexPath.section == 1){//薪资增项
        cell.textLabel.text = [leftNameArray objectAtIndex:indexPath.row];
		NSString *string = @"";
		if (indexPath.row == 0) {
			string = _payRoll.overtimesalary;
        } else if (indexPath.row == 1) {
            string = _payRoll.subsidy;
        } else if (indexPath.row == 2) {
			string = _payRoll.onechildfee;
		} else if (indexPath.row == 3) {
			string = _payRoll.bonus;
		} else if (indexPath.row == 4) {
			string = _payRoll.annualbonus;
		} else if (indexPath.row == 5){
			string = _payRoll.others;
		}
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@", string];
    } else if(indexPath.section== 2) {//薪资减项
        cell.textLabel.text = [payrollminusArray objectAtIndex:indexPath.row];
		NSString *string = @"";
		if (indexPath.row == 0) {
			string = _payRoll.leavededuction;
		} else if (indexPath.row == 1) {
			string = _payRoll.endowmentinsurance;
        } else if (indexPath.row == 2) {
            string = _payRoll.endowmentinsuranceretroactive;
        } else if (indexPath.row == 3) {
			string = _payRoll.hospitalizationinsurance;
        } else if (indexPath.row == 4) {
            string = _payRoll.hospitalizationinsuranceretroactive;
        } else if (indexPath.row == 5) {
			string = _payRoll.unemploymentinsurance;
        } else if (indexPath.row == 6) {
            string = _payRoll.unemploymentinsuranceretroactive;
        } else if (indexPath.row == 7) {
			string = _payRoll.reservefund;
        } else if (indexPath.row == 8) {
            string = _payRoll.reservefundretroactive;
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@", string];
    } else if(indexPath.section == 3) {//计税薪资
        cell.textLabel.text = [payrolltax objectAtIndex:indexPath.row];
		NSString *string = @"";
		if (indexPath.row  == 0) {
			string = _payRoll.pretaxwages;
		} else if (indexPath.row == 1) {
			string = _payRoll.incometax;
		} else if (indexPath.row == 2) {
			string = _payRoll.realwages;
		}
		cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@", string];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [titleArray objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

@end
