//
//  SignInViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SignInViewController.h"
#import "AppDelegate.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)checkBoxButtonClick:(id)sender
{
    _checkBoxButton.selected = !_checkBoxButton.selected;
}

- (IBAction)signInButtonClick:(id)sender
{
    [self hidenAllKeyBoard];
    if ([_userNameTextField.text areAllCharactersSpace] || _userNameTextField.text == nil) {
        [self displayHUDTitle:nil message:@"请输入用户名!"];
        return;
    }
    if ([_passwordTextField.text areAllCharactersSpace] || _passwordTextField.text == nil) {
        [self displayHUDTitle:nil message:@"请输入密码!"];
        return;
    }
    [self displayHUD:@"登录中..."];
    [[JAFHTTPClient shared] signIn:_userNameTextField.text password:_passwordTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"%@", result);
        [self hideHUD:YES];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate addTabBar];
    }];
}


- (IBAction)registerButtonClick:(id)sender
{
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameTextField) {
        [_passwordTextField becomeFirstResponder];
    } else {
        [self signInButtonClick:nil];
    }
    return YES;
}

- (void)hidenAllKeyBoard
{
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
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
