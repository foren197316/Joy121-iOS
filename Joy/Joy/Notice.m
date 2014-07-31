//
//  Notice.m
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "Notice.h"

@implementation Notice

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_content = [attributes[@"Content"] replaceHtml];
		_title = attributes[@"Title"];
		_postTime = [attributes[@"PostTime"] getCorrectDate];
		if (attributes[@"ActPicturePath"]) {
			NSString *host = [JAFHTTPClient shared].baseURL.absoluteString;
			_imageULRString = [NSString stringWithFormat:@"%@%@%@", host, @"files/post/", attributes[@"ActPicturePath"]];
		}
//		_imageULRString = @"http://cloud.joy121.com/files/activity/19.jpg";//TODO: for test
	}
	return self;
}

@end
