//
//  NSString+Joy.h
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Joy)

- (NSString *)replaceHtml;

- (NSString *)getCorrectDate;

- (NSString *)getCorrectDateWithoutTime;

- (NSDate *)getCorrectDateDate;

- (NSDate *)toDate;

@end
