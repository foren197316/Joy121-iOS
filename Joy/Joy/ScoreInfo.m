//
//  ScoreInfo.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "ScoreInfo.h"

@implementation ScoreInfo

+ (ScoreInfo *)createScoreInfoWithDict:(NSDictionary *)dict
{
    ScoreInfo *info = [[ScoreInfo alloc] init];
    info.date = [self getCorrectDate:dict[@"ActionTime"]];
    info.score = dict[@"Points"];
    info.mark = dict[@"Remark"];
    return info;
}

+ (NSArray *)createScoreInfosWithArray:(NSArray *)array
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i ++) {
        ScoreInfo *info = [self createScoreInfoWithDict:array[i]];
        [arr addObject:info];
    }
    return arr;
}

+ (NSString *)getCorrectDate:(NSString *)str
{
    NSString *timeStr = str;
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]/1000];
    return [dateFormatter stringFromDate:date];
}
@end
