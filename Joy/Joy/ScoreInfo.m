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
    info.date = [dict[@"ActionTime"] getCorrectDate];
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

@end
