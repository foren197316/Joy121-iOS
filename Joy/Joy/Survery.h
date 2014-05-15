//
//  Survery.h
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Survery : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *questions;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSArray *surveyRates;
@property (nonatomic, strong) NSDictionary *answers;

+ (Survery *)createSurveryWithDict:(NSDictionary *)dict;
+ (NSArray *)createSurverysWithArray:(NSArray *)array;

@end
