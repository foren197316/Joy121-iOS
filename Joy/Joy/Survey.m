//
//  Survery.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "Survey.h"
#import "SurveyRate.h"

@implementation Survey

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_content = attributes[@"Description"];
		_title = attributes[@"Title"];
		_endTime = [attributes[@"ExpireTime"] getCorrectDate];
		_questions = attributes[@"Questions"];
		_sid = attributes[@"SurveyId"];
		
		if ([attributes[@"SurveyAnswer"] isKindOfClass:[NSDictionary class]]) {
			_answers = attributes[@"SurveyAnswer"];
		}
		
		if (attributes[@"SurveyRates"]) {
			_surveyRates = [SurveyRate multiWithAttributesArray:attributes[@"SurveyRates"]];
		}
	}
	return self;
}

@end
