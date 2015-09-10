//
//  NSString+Joy.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "NSString+Joy.h"

@implementation NSString (Joy)

- (NSString *)replaceHtml
{
	NSString *string;
    string = [self stringByReplacingOccurrencesOfString:@"<p>" withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return string;
}

- (NSString *)getCorrectDate
{
    NSString *timeStr = self;
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue] / 1000];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)getCorrectDateWithoutTime
{
    NSString *timeStr = self;
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue] / 1000];
    return [dateFormatter stringFromDate:date];
}

- (NSDate *)getCorrectDateDate {
    NSString *timeStr = self;
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue] / 1000];
    return date;
}

- (NSDate *)toDate {
    if ([self isEqualToString:@""]) {
        return [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:self];
    return date;
}

@end
