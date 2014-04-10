//
//  OrderInfo.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "OrderInfo.h"
#import "WelInfo.h"

@implementation OrderInfo

+ (NSArray *)createOrderInfosWithArray:(NSArray *)arr
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i ++) {
        OrderInfo *info = [self createOrderInfoWithDictionary:arr[i]];
        [array addObject:info];
    }
    return array;
}

+ (OrderInfo *)createOrderInfoWithDictionary:(NSDictionary *)dict
{
    OrderInfo *info = [[OrderInfo alloc] init];
    info.orderNo = dict[@"OrderId"];
    info.score = dict[@"Points"];
    info.createTime = [self getCorrectDate:dict[@"CreateTime"]];
    info.welArrays = [WelInfo createWelInfosWithArray:dict[@"LstCommoditySet"]];
    return info;
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
