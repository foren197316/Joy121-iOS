//
//  SignInViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIButton *checkBoxButton;
@property (nonatomic, weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
- (IBAction)checkBoxButtonClick:(id)sender;
- (IBAction)signInButtonClick:(id)sender;
- (IBAction)registerButtonClick:(id)sender;
@end
