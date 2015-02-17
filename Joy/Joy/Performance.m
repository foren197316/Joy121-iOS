//
//  Performance.m
//  Joy
//
//  Created by zhangbin on 2/17/15.
//  Copyright (c) 2015 颜超. All rights reserved.
//

#import "Performance.h"
#import "NSString+ZBUtilites.h"

@implementation Performance

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		_period = [attributes[@"Period"] notNull];
		_score = [attributes[@"PerformanceScore"] notNull];
		_points = [attributes[@"PerformancePoints"] notNull];
		_name = [attributes[@"ReportName"] notNull];
		_ranking = [attributes[@"PerformanceSeq"] notNull];
		_total = [attributes[@"TotalNum"] notNull];
		_reportCaseID = [attributes[@"ReportCaseId"] notNull];
		_costCenterNO = [attributes[@"CostCenterNo"] notNull];
		_username = [attributes[@"UserName"] notNull];
	}
	return self;
}

- (BOOL)isYearly {
	return [_name stringContainsString:@"年度"];
}

- (BOOL)isQuarterly {
	return [_name stringContainsString:@"季度"];
}

- (BOOL)isMonthly {
	return [_name stringContainsString:@"月度"];
}

- (UIColor *)flagColor {
	if ([self isYearly]) {
		return [UIColor redColor];
	} else if ([self isQuarterly]) {
		return [UIColor colorWithRed:78/255.0f green:212/255.0f blue:34/255.0f alpha:1.0f];
	}
	return [UIColor colorWithRed:106/255.0f green:146/255.0f blue:240/255.0f alpha:1.0f];
}

@end
