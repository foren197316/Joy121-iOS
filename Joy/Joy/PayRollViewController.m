//
//  PayRollViewController.m
//  Joy
//
//  Created by summer on 11/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "PayRollViewController.h"
#import "PayRoll.h"
#define HeightOfHeaderView 100
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
            payroll.payablepay=@"12265.21";
            payroll.subsidysum=@"11.11";
            payroll.sequestrate=@"11.11";
            payroll.username=@"summer";
            payroll.period=@"2014/06/01";
            
            PayRoll *payroll2=[[PayRoll alloc] init];
            payroll2.id=@"1";
            payroll2.realwagwages=@"1111221";
            payroll2.payablepay=@"11181.51";
            payroll2.subsidysum=@"11.121";
            payroll2.sequestrate=@"11.11";
            payroll2.username=@"summer2";
            payroll2.period=@"2014/07/01";
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
    PayRoll *payroll=_PayRolls[indexPath.row];
    NSString * pay=[[NSString alloc] initWithFormat:@"%@%@",@"￥",payroll.payablepay];
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(-50, 30, 150, 30)];
//    [cell.imageView setImageWithURL:[NSURL URLWithString:@"http://pic17.nipic.com/20111107/8775306_114515279130_2.jpg"] placeholderImage:[UIImage imageNamed:@"GoodsPlaceholder"]];
   // UIImageView *imageView=[[UIImageView alloc] initWithFrame::CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
    [keyLabel setTextColor:[UIColor blackColor]];
    [keyLabel setTextAlignment:NSTextAlignmentRight];
   // keyLabel.backgroundColor = [UIColor redColor];
    keyLabel.text = pay;
    [cell.contentView addSubview:keyLabel];
    NSString * time=[[NSString alloc] initWithFormat:@"%@%@",payroll.period,@""];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(tableView.frame.size.width -140 , 30, 120, 30);
    [button setTitle:NSLocalizedString(time, nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.tag = indexPath.row;
    [button addTarget:self action:@selector(rent:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 91.5;
}

@end
