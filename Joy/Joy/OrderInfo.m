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
    info.status = [dict[@"Flag"] integerValue] == 2 ? @"已确认" : @"待处理";
    info.createTime = [dict[@"CreateTime"] getCorrectDate];
    info.welArrays = [WelInfo createWelInfosWithArray:dict[@"LstCommoditySet"]];
    return info;
}

@end
