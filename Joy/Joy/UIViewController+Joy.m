//
//  UIViewController+Joy.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "UIViewController+Joy.h"

@implementation UIViewController (Joy)

//TODO:
- (void)addBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, 20, 20)];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//TODO
- (void)addTitleIconWithTitle:(NSString *)title
{
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [iconView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7.5, 25, 25)];
    [iconImageView setImage:[UIImage imageNamed:@"title_icon"]];
    [iconView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 70, 20)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [iconView addSubview:titleLabel];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:iconView];
    
    self.navigationItem.leftBarButtonItem = barItem;
}
@end
