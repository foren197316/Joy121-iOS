//
//  Event.m
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_eventId = attributes[@"ActId"];
		_title = attributes[@"ActName"];
		_eventFee = attributes[@"ActFee"];
		_iconUrl = [NSString stringWithFormat:@"%@%@%@", [JAFHTTPClient shared].baseURL.absoluteString, @"files/activity/", attributes[@"ActPicturePath"]];
		_shortDescribe = [attributes[@"Content"] replaceHtml];
		_location = attributes[@"LocationAddr"];
		if (![attributes[@"LoginName"] isKindOfClass:[NSNull class]]) {
			_loginName = attributes[@"LoginName"];
		}
		_startTime = [attributes[@"StartTime"] getCorrectDate];
		_endTime = [attributes[@"EndTime"] getCorrectDate];
		_joinCount = attributes[@"CurrentCount"];
		_limitCount = attributes[@"LimitCount"];
	}
	return self;
}

@end
