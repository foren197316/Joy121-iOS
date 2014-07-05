//
//  ScoreInfo.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "ScoreInfo.h"

@implementation ScoreInfo

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_date = [attributes[@"ActionTime"] getCorrectDate];
		_score = attributes[@"Points"];
		_mark = attributes[@"Remark"];
	}
	return self;
}

@end
