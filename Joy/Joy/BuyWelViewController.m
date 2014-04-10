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
        self.title = @"我的福利";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_scrollView setContentSize:CGSizeMake(320, 568)];
    [self loadUserInfo];
    _goodsLabel.text = [NSString stringWithFormat:@"【%@】%@", _info.welName, _info.shortDescribe];
    _describeLabel.text = _info.longDescribe;
    _timesLabel.text = [NSString stringWithFormat:@"X %d", _times];
    _priceLabel.text = [NSString stringWithFormat:@"%@", _info.score];
    _totalPriceLabel.text = [NSString stringWithFormat:@"%d", [_info.score integerValue] * _times];
    // Do any additional setup after loading the view.
}

- (void)loadUserInfo
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userInfoWithBlock:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if (result) {
            _user = [JUser createJUserWithDict:result[@"retobj"]];
            _receiverLabel.text = _user.realName;
            _addressLabel.text = _user.companyName;
            _phoneLabel.text = _user.telephone;
            _leftMoneyLabel.text = [NSString stringWithFormat:@"%@", _info.score];
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
   [[JAFHTTPClient shared] orderSubmit:_info.wid
                                  type:_info.type
                                  name:_user.realName
                               address:_user.companyName
                                 phone:_user.telephone
                                  mark:_bzTextView.text
                             withBlock:^(NSDictionary *result, NSError *error) {
       NSLog(@"%@", result);
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
