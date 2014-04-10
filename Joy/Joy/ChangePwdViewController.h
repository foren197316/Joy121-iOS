//
//  ChangePwdViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePwdViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *oPwdTextField;
@property (nonatomic, weak) IBOutlet UITextField *nPwdTextField;
@property (nonatomic, weak) IBOutlet UITextField *cPwdTextField;
- (IBAction)changePasswordButtonClick:(id)sender;
@end
