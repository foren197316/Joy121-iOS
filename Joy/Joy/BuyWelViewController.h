//
//  BuyWelViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JUser.h"
#import "WelInfo.h"

@interface BuyWelViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *receiverLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *phoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *goodsLabel;
@property (nonatomic, weak) IBOutlet UILabel *describeLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel; //单件金额
@property (nonatomic, weak) IBOutlet UILabel *totalPriceLabel; //总价
@property (nonatomic, weak) IBOutlet UILabel *leftMoneyLabel; //余额
@property (nonatomic, weak) IBOutlet UILabel *timesLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UITextView *bzTextView;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;

@property (nonatomic, strong) JUser *user;
@property (nonatomic, strong) WelInfo *info;
@property (nonatomic, assign) NSInteger times;
- (IBAction)confirmBZButtonClick:(id)sender;
- (IBAction)submitButtonClick:(id)sender;
@end
