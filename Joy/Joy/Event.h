//
//  Event.h
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *shortDescribe;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *joinCount;
@property (nonatomic, strong) NSString *limitCount;
@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *eventFee;

+ (Event *)createEventWithDict:(NSDictionary *)dict;
+ (NSArray *)createEventsWithArray:(NSArray *)array;


@end
