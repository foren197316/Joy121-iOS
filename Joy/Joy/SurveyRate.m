//
//  SurveyRate.m
//  Joy
//
//  Created by zhangbin on 7/29/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "SurveyRate.h"

@implementation SurveyRate

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super init];
	if (self) {
		_questionIndex = attributes[@"QuestionIndex"];
		_ratedCount = attributes[@"Rate"];
	}
	return self;
}

@end
