//
//  SalaryDetailView.m
//  Joy
//
//  Created by 无非 on 14/11/25.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SalaryDetailView.h"
#import <AFHTTPClient.h>

@interface SalaryDetailView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *salaryDetailTableView;
    NSArray *titleArray;
    AFHTTPClient *afhttp;
    NSMutableArray *oneArray;
    NSMutableArray *twoArray;
    NSMutableArray *fourArray;
    NSMutableArray * fiveArray;
    NSMutableArray *leftNameArray;
    NSMutableArray * payrollminusArray;
    NSMutableArray * payrolltax;
}
@end

@implementation SalaryDetailView
@synthesize peridValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工资单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    oneArray = [[NSMutableArray alloc]init];
    twoArray = [[NSMutableArray alloc]init];
    fourArray = [[NSMutableArray alloc]init];
    fiveArray=[[NSMutableArray alloc] init];
    titleArray = [NSArray arrayWithObjects:@"基本薪资",@"薪资增项",@"薪资减项",@"计税薪资",nil];
    leftNameArray = [NSMutableArray arrayWithObjects:@"津贴:",@"独生子女费:",@"奖金:",@"年终奖:", nil];
    payrollminusArray=[NSMutableArray arrayWithObjects:@"请假扣款合计",@"个人养老保险",@"个人医疗保险",@"个人失业保险",@"个人公积金", nil];
    payrolltax=[NSMutableArray arrayWithObjects:@"税前工资",@"所得税",@"其他",@"实发工资", nil];
    salaryDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    salaryDetailTableView.delegate = self;
    salaryDetailTableView.dataSource = self;
    [self.view addSubview:salaryDetailTableView];
    [self receviceInformation];
}

- (void)receviceInformation
{
    [self displayHUD:@"加载中..."];
    NSString *one = @"loginname";
    NSString *two = @"period";
    NSString *three = [[JAFHTTPClient shared] userName];
  //  NSString *three = @"231121199412304611";
    NSString *four = self.peridValue;
  //  NSString *strUrl = [NSString stringWithFormat:@"http://a.joy121.com/AjaxPage/app/Msg.ashx?action=comp_payroll_detail&json={%@:%@,%@:%@}" ,one,@"310225198112162465",two,@"201406"];
    NSString *strUrl = [NSString stringWithFormat:@"http://a.joy121.com/AjaxPage/app/Msg.ashx?action=comp_payroll_detail&json={%@:%@,%@:%@}" ,one,three,two,four];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:strUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@",[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding]);
    if (received == nil) {
        [self hideHUD:YES];
        [self displayHUDTitle:nil message:@"链接服务器失败" duration:1.0];
    }
    else{
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableLeaves error:&error];
        if (error == nil) {
            [self hideHUD:YES];
            NSDictionary *jsonDic = [dic objectForKey:@"retobj"];
            if (![jsonDic isKindOfClass:[NSNull class]]) {
                    [oneArray addObject:[jsonDic objectForKey:@"basepay"]];
                    
                    [twoArray addObject:[jsonDic objectForKey:@"subsidy"]];
                    [twoArray addObject:[jsonDic objectForKey:@"onechildfee"]];
                    [twoArray addObject:[jsonDic objectForKey:@"bonus"]];
                    [twoArray addObject:[jsonDic objectForKey:@"annualbonus"]];
                    
                    [fourArray addObject:[jsonDic objectForKey:@"leavededuction"]];
                    [fourArray addObject:[jsonDic objectForKey:@"endowmentinsurance"]];
                    [fourArray addObject:[jsonDic objectForKey:@"hospitalizationinsurance"]];
                    [fourArray addObject:[jsonDic objectForKey:@"unemploymentinsurance"]];
                    [fourArray addObject:[jsonDic objectForKey:@"reservefund"]];
                    
                    [fiveArray addObject:[jsonDic objectForKey:@"pretaxwages"]];
                    [fiveArray addObject:[jsonDic objectForKey:@"incometax"]];
                    [fiveArray addObject:[jsonDic objectForKey:@"others"]];
                    [fiveArray addObject:[jsonDic objectForKey:@"realwages"]];
      
                    
                    [salaryDetailTableView reloadData];
                
            }
            else{
                [self hideHUD:YES];
                [self displayHUDTitle:nil message:@"链接服务器失败" duration:1.0];
            }
        }
        else{
            [self hideHUD:YES];
            [self displayHUDTitle:nil message:@"链接服务器失败" duration:1.0];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return oneArray.count;
    }
    else if (section == 1){
        return twoArray.count;
    }
    else if(section ==2)
    {
        return fourArray.count;
    }
    else
    {
        return fiveArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellInderFier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellInderFier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellInderFier];
        
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"基本工资：";
        cell.detailTextLabel.text = [@"￥" stringByAppendingString: [oneArray objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 1){
        cell.textLabel.text = [leftNameArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [@"￥" stringByAppendingString: [twoArray objectAtIndex:indexPath.row]];
    }
    else if(indexPath.section==2)
    {
        cell.textLabel.text = [payrollminusArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [@"￥" stringByAppendingString: [fourArray objectAtIndex:indexPath.row]];
    }
    else if(indexPath.section==3)
    {
        cell.textLabel.text = [payrolltax objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [@"￥" stringByAppendingString: [fiveArray objectAtIndex:indexPath.row]];

    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [titleArray objectAtIndex:section];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
