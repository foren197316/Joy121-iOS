//
//  PayRollViewController.m
//  Joy
//
//  Created by summer on 11/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "PayRollViewController.h"
#import "PayRoll.h"
#import "SalaryDetailView.h"
#define HeightOfHeaderView 100
@interface PayRollViewController ()<UIAlertViewDelegate>
{
    SalaryDetailView *salaryDetailView;
}
@property(readwrite) NSArray * PayRolls;
@property (readwrite) PayRoll *dict;
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
    _PayRolls = [[NSArray alloc]init];
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] companyPayRoll:^(NSArray *multiAttributes, NSError *error) {
           [self hideHUD:YES];
           _PayRolls=[PayRoll multiWithAttributesArray:multiAttributes];
            NSLog(@"工资单数组：%@",_PayRolls);
             [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
        PayRoll *payroll=_PayRolls[indexPath.row];
        NSString * pay=[[NSString alloc] initWithFormat:@"%@%@",@"￥",payroll.realwagwages];
        UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 160, 70)];
        [keyLabel setTextColor:[UIColor blackColor]];
        [keyLabel setTextAlignment:NSTextAlignmentCenter];
        keyLabel.text = pay;
        keyLabel.font = [UIFont systemFontOfSize:25.0];
        keyLabel.backgroundColor = [UIColor colorWithRed:230.0f/255.0f green:198.0f/255.0f blue:183.0f/255.0f alpha:1.0];
        [cell.contentView addSubview:keyLabel];
        
        UILabel *smallLables = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 160, 20)];
        [smallLables setTextColor:[UIColor blackColor]];
        [smallLables setTextAlignment:NSTextAlignmentCenter];
        smallLables.text = @"实发工资";
        smallLables.font = [UIFont systemFontOfSize:12.0];
        smallLables.backgroundColor = [UIColor clearColor];
        [keyLabel addSubview:smallLables];
        
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:keyLabel.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(5.0, 5.0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = keyLabel.bounds;
        maskLayer.path = maskPath.CGPath;
        keyLabel.layer.mask = maskLayer;
        
        
        NSString * time=[[NSString alloc] initWithFormat:@"%@",payroll.period];//日期展示
        NSString *year = [time substringToIndex:4];
        NSString *month = [time substringWithRange:NSMakeRange(4, 2)];
        NSString *newTime = [[year stringByAppendingString:@"/"] stringByAppendingString:month];
        UILabel *timeLable = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - 130, 20, 100, 50)];
        [timeLable setTextColor:[UIColor blackColor]];
        [timeLable setTextAlignment:NSTextAlignmentCenter];
        timeLable.font = [UIFont systemFontOfSize:17.0];
        timeLable.backgroundColor = [UIColor clearColor];
        timeLable.text = newTime;
        [cell.contentView addSubview:timeLable];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//TableViewCell的按钮类型
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell效果
    }
   return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    salaryDetailView = [[SalaryDetailView alloc]initWithNibName:@"SalaryDetailView" bundle:nil];
    PayRoll *payroll=_PayRolls[indexPath.row];
    salaryDetailView.peridValue = payroll.period;//将发放工资  月份传到下个界面
    salaryDetailView.salaryValue = payroll.realwagwages;//将发放工资金额传到下个界面
    [self.navigationController pushViewController:salaryDetailView animated:YES];
}

@end
