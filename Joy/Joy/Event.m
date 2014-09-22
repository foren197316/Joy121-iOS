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
		_joinCount = [NSString stringWithFormat:@"%@", attributes[@"CurrentCount"]];
		_limitCount = [NSString stringWithFormat:@"%@", attributes[@"LimitCount"]];
		_hadJoined = attributes[@"IsJoin"];
		_deadline = [attributes[@"DeadLine"] getCorrectDate];
	}
	return self;
}

- (NSString *)status
{
	if (_bExpired) {
		if (_hadJoined.integerValue == 1) {
			return NSLocalizedString(@"已参与", nil);
		} else {
			return NSLocalizedString(@"未参与", nil);
		}
	} else {
		if (_loginName.length) {
			return NSLocalizedString(@"取消报名", nil);
		} else if ([_limitCount isEqualToString:_joinCount]) {
			return NSLocalizedString(@"人数已满", nil);
		} else {
			return NSLocalizedString(@"未报名", nil);
		}
	}
}

- (BOOL)isEnabled
{
	if (_bExpired) {
		return NO;
	}
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = @"yyyy-MM-dd";
	NSDate *deadline = [dateFormatter dateFromString:_deadline];
	if (deadline == [deadline earlierDate:[NSDate date]]) {
		return NO;
	}
	
	if (!_loginName.length && [_limitCount isEqualToString:_joinCount]) {
		return NO;
	}
	
	return YES;
}

@end
