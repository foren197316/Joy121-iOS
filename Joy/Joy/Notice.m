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
	self = [self init];
	if (self) {
		_content = [attributes[@"Content"] replaceHtml];
		_title = attributes[@"Title"];
		_postTime = [attributes[@"PostTime"] getCorrectDate];
	}
	return self;
}

@end
