//
//  ChangePwdViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "ChangePwdViewController.h"
#import "AppDelegate.h"

@interface ChangePwdViewController ()

@end

@implementation ChangePwdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"修改密码";
    }
    return self;
}

- (IBAction)changePasswordButtonClick:(id)sender
{
    if ([_oPwdTextField.text areAllCharactersSpace] || _oPwdTextField.text == nil) {
        [self displayHUDTitle:nil message:@"请输入旧密码!"];
        return;
    }
    if ([_nPwdTextField.text areAllCharactersSpace] || _nPwdTextField.text == nil) {
        [self displayHUDTitle:nil message:@"请输入新密码!"];
        return;
    }
    if ([_cPwdTextField.text areAllCharactersSpace] || _cPwdTextField.text == nil) {
        [self displayHUDTitle:nil message:@"请再次输入新密码!"];
        return;
    }
    if (![_nPwdTextField.text isEqualToString:_cPwdTextField.text]) {
        [self displayHUDTitle:nil message:@"两次密码输入不一致"];
        return;
    }
    [[JAFHTTPClient shared] changePwd:_oPwdTextField.text newPwd:_nPwdTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        if (result[@"retobj"]) {
            if ([result[@"retobj"] integerValue] == 1) {
                [self displayHUDTitle:nil message:@"密码修改成功"];
                [self performSelector:@selector(reLogin) withObject:nil afterDelay:2.0];
            } else {
                [self displayHUDTitle:nil message:@"密码修改失败"];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR];
        }
    }];
}

- (void)reLogin
{
    [JAFHTTPClient signOut];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate addSignIn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
