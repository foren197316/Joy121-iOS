//
//  PerformanceTableViewCell.h
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Performance.h"

@interface PerformanceTableViewCell : UITableViewCell

@property (nonatomic, strong) Performance *performance;
@property (nonatomic, assign) BOOL isEncourage;

+ (CGFloat)biggerHeight;

@end
