//
//  WelInfo.m
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "WelInfo.h"

#define URL  @"http://www.joy121.com/SYS/Files/img/s_"

@implementation WelInfo

+ (WelInfo *)createWelInfoWithDictionary:(NSDictionary *)dict
{
    WelInfo *info = [[WelInfo alloc] init];
    info.wid = dict[@"Id"];
    info.picturesArray = [dict[@"AppPicture"]  componentsSeparatedByString:@";"];
    info.headPic = [NSString stringWithFormat:@"%@%@",URL, dict[@"Picture"]];
    if (dict[@"AppDescription"] != [NSNull null]) {
        info.shortDescribe = dict[@"AppDescription"];
    } else {
        info.shortDescribe = @"";
    }
    info.welName = dict[@"SetName"];
    info.longDescribe = dict[@"Description"];
    if (info.longDescribe) {
        info.longDescribe = [info.longDescribe stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    }
    info.startTime = [dict[@"StartDate"] getCorrectDate];
    info.endTime = [dict[@"EXPIREDDATE"] getCorrectDate];
    info.score = dict[@"Points"];
    info.type = dict[@"SetType"];
    info.typeName = dict[@"TypeName"];
    return info;
}

+ (NSArray *)createWelInfosWithArray:(NSArray *)arr
{
    NSMutableArray *welArrays = [[NSMutableArray alloc] init];
    for (int i = 0; i < [arr count]; i ++) {
        WelInfo *info = [self createWelInfoWithDictionary:arr[i]];
        [welArrays addObject:info];
    }
    return welArrays;
}

@end
