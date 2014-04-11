//
//  BuyWelViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "BuyWelViewController.h"

@interface BuyWelViewController ()

@end

@implementation BuyWelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"收货信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyBoard)];
    [self.view addGestureRecognizer:tapGesture];
    
    [_scrollView setContentSize:CGSizeMake(320, 568)];
    [self loadUserInfo];
    _goodsLabel.text =  _info.welName;
    _describeLabel.text = _info.longDescribe;
    _timesLabel.text = [NSString stringWithFormat:@"X %ld", _times];
    _priceLabel.text = [NSString stringWithFormat:@"%@   %@", _info.welName,_info.score];
    _totalPriceLabel.text = [NSString stringWithFormat:@"%ld", [_info.score integerValue] * _times];
    // Do any additional setup after loading the view.
}

- (void)hidenKeyBoard
{
    [_bzTextView resignFirstResponder];
}

- (void)loadUserInfo
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userInfoWithBlock:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if (result) {
            _user = [JUser createJUserWithDict:result[@"retobj"]];
            _receiverLabel.text = _user.realName;
            _addressLabel.text = _user.address;
            _phoneLabel.text = _user.telephone;
            _leftMoneyLabel.text = [NSString stringWithFormat:@"%@", _user.score];
        }
    }];
}

- (IBAction)confirmBZButtonClick:(id)sender
{
    [_confirmButton setHidden:YES];
    [_bzTextView setEditable:NO];
}

- (IBAction)submitButtonClick:(id)sender
{
    if ([_user.score integerValue] < [_info.score integerValue]) {
        [self displayHUDTitle:nil message:@"余额不足!"];
        return;
    }
    [self displayHUD:@"提交订单中..."];
   [[JAFHTTPClient shared] orderSubmit:_info.wid
                                  type:@"2"
                                  name:_user.realName
                               address:_user.companyName
                                 phone:_user.telephone
                                  mark:_bzTextView.text
                             withBlock:^(NSDictionary *result, NSError *error) {
                                 if ([result[@"retobj"][@"StatusFlag"] integerValue] == 1) {
                                     [self displayHUDTitle:nil message:@"订单提交成功"];
                                 } else {
                                     [self displayHUDTitle:nil message:@"订单提交失败"];
                                 }
   }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
