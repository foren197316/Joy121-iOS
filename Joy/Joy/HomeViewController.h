//
//  HomeViewController.h
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loadingView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UIScrollView *recommandScroll;
- (IBAction)pageAction:(id)sender;
@end
