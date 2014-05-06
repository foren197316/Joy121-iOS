//
//  Notice.m
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

//{
//    Company = "DELPHI_SZ";
//    Content = "<p>\U4e94\U4e00\U52b3\U52a8\U8282\U653e\U5047\U516c\U544a\Uff0c5.1,5.2,5.3\U53f7\U653e\U5047\Uff0c5.4\U6b63\U5e38\U4e0a\U73ed</p>";
//    ExpireTime = "/Date(1401379200000+0800)/";
//    PostId = 23;
//    PostTime = "/Date(-62135596800000+0800)/";
//    Title = "\U4e94\U4e00\U52b3\U52a8\U8282\U653e\U5047\U516c\U544a";
//},


#import "Notice.h"

@implementation Notice

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (Notice *)createNoticeWithDict:(NSDictionary *)dict
{
    Notice *notice = [[Notice alloc] init];
    notice.content = [self replaceHtml:dict[@"Content"]];
    notice.title = dict[@"Title"];
    notice.postTime = [self getCorrectDate:dict[@"ExpireTime"]];
    return notice;
}

+ (NSArray *)createNoticesWithArray:(NSArray *)array
{
    NSMutableArray *noticeArr = [NSMutableArray array];
    for (int i = 0; i < [array count]; i ++) {
        NSDictionary *info = array[i];
        Notice *notice = [self createNoticeWithDict:info];
        [noticeArr addObject:notice];
    }
    return noticeArr;
}

+ (NSString *)replaceHtml:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    return str;
}

+ (NSString *)getCorrectDate:(NSString *)str
{
    NSString *timeStr = str;
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"+0800)/" withString:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]/1000];
    return [dateFormatter stringFromDate:date];
}
@end
