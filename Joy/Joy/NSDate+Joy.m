//
//  NSDate+Joy.m
//  Joy
//
//  Created by gejw on 15/9/2.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "NSDate+Joy.h"

@implementation NSDate (Joy)

- (NSString *)toCorrectDate {
    NSTimeInterval time = [self timeIntervalSince1970] * 1000;
    NSString *timeStr = [NSString stringWithFormat:@"/Date(%f+0800)/", time];
    return timeStr;
}

@end
