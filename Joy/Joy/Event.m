//
//  Event.m
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

//{
//    flag = 1;
//    msg = "<null>";
//    retobj =     (
//                  {
//                      ActFee = 0;
//                      ActId = 1;
//                      ActLocationId = 0;
//                      ActName = "\U590d\U6d3b\U8282\U6148\U5584\U4e49\U5356\U6d3b\U52a8";
//                      ActPicturePath = "http://www.tech-ex.com/article_images3/9/514449/195670_2.jpg";
//                      ActTypeId = 1;
//                      ActTypeName = "<null>";
//                      Content = "<p>\U590d\U6d3b\U8282\U6148\U5584\U4e49\U5356\U6d3b\U52a8</p>\n<p>\U65f6\U95f4\Uff1a2014\U5e745\U670822\U65e5 \U4e0a\U53489:00-11:00</p>\n<p>\U5730\U70b9\Uff1a\U82cf\U5dde\U5de5\U4e1a\U56ed\U533a\U9ad8\U6559\U533a\U767d\U9e6d\U56ed</p>";
//                      CurrentCount = 2;
//                      DeadLine = "/Date(1400083200000+0800)/";
//                      EndTime = "/Date(1400727600000+0800)/";
//                      LimitCount = 100;
//                      LocationAddr = "\U9ad8\U6559\U533a\U767d\U9e6d\U56ed";
//                      LoginName = steven;
//                      ScopeLevel = "DELPHI_SZ";
//                      StartTime = "/Date(1400720400000+0800)/";
//                  }
//                  );
//}

#import "Event.h"

#define EVENT_IMAGE_URL  @"http://www.joy121.com/sys/Files/activity/"

@implementation Event

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (Event *)createEventWithDict:(NSDictionary *)dict
{
    Event *event = [[Event alloc] init];
    event.eventId = dict[@"ActId"];
    event.title = dict[@"ActName"];
    event.eventFee = dict[@"ActFee"];
    event.iconUrl = [NSString stringWithFormat:@"%@%@",EVENT_IMAGE_URL,dict[@"ActPicturePath"]];
    event.shortDescribe = [dict[@"Content"] replaceHtml];
    event.location = dict[@"LocationAddr"];
    if (![dict[@"LoginName"] isKindOfClass:[NSNull class]]) {
        event.loginName = dict[@"LoginName"];
    }
    event.startTime = [dict[@"StartTime"] getCorrectDate];
    event.endTime = [dict[@"EndTime"] getCorrectDate];
    event.joinCount = dict[@"CurrentCount"];
    event.limitCount = dict[@"LimitCount"];
    return event;
}

+ (NSArray *)createEventsWithArray:(NSArray *)array
{
    NSMutableArray *eventsArray = [NSMutableArray array];
    for (int i = 0; i < [array count]; i ++) {
        Event *event = [self createEventWithDict:array[i]];
        [eventsArray addObject:event];
    }
    return eventsArray;
}

@end
