//
//  WelInfo.m
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "WelInfo.h"

@implementation WelInfo

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_wid = attributes[@"Id"];
		_picturesArray = [attributes[@"AppPicture"] componentsSeparatedByString:@";"];
		_headPic = [NSString stringWithFormat:@"%@%@%@", [JAFHTTPClient shared].baseURL.absoluteString, @"files/img/s_",attributes[@"Picture"]];
		if (attributes[@"AppDescription"] != [NSNull null]) {
			_shortDescribe = attributes[@"AppDescription"];
		}
		_welName = attributes[@"SetName"];
		_longDescribe = attributes[@"Description"];
		if (_longDescribe) {
			_longDescribe = [_longDescribe stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
		}
		_startTime = [attributes[@"StartDate"] getCorrectDate];
		_endTime = [attributes[@"EXPIREDDATE"] getCorrectDate];
		_score = attributes[@"Points"];
		_type = attributes[@"SetType"];
		_typeName = attributes[@"TypeName"];
	}
	return self;
}

@end
