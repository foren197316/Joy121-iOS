//
//  WelDetailViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelInfo.h"

@interface WelDetailViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) WelInfo *welInfo;
@property (nonatomic, weak) IBOutlet UIView *backgroundView;
@property (nonatomic, weak) IBOutlet UIScrollView *imageScrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UITextView *longDescribeTextView;
@property (nonatomic, weak) IBOutlet UILabel *describeTitleLabel;

@end
