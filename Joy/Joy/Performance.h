//
//  Performance.h
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface Performance : ZBModel

@property (nonatomic, strong) NSString *period;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSNumber *points;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *ranking;
@property (nonatomic, strong) NSNumber *total;
@property (nonatomic, strong) NSString *reportCaseID;
@property (nonatomic, strong) NSString *costCenterNO;
@property (nonatomic, strong) NSString *username;


- (BOOL)isYearly;
- (BOOL)isQuarterly;
- (BOOL)isMonthly;
- (UIColor *)flagColor;

@end
