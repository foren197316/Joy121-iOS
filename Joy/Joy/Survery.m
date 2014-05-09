//
//  Survery.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

//(
// {
//     Description = "\U4e3a\U4e86\U6839\U636e\U5458\U5de5\U5b9e\U9645\U9700\U6c42\U548c\U516c\U53f8\U8d22\U52a1\U7684\U53cc\U8d62\Uff0c\U505a\U6b64\U6b21\U8c03\U67e5\U3002";
//     ExpireTime = "/Date(1399690800000+0800)/";
//     LoginName = steven;
//     OptionType = 0;
//     Questions = "2000\U4ee5\U4e0b^2000-3000^3000-5000^5000-10000^10000-20000^20000-30000^30000-50000^50000\U4ee5\U4e0a";
//     ResultShow = 1;
//     ScopeLevel = "DELPHI_SZ";
//     SurveyId = 10;
//     Title = "\U516c\U53f8\U5458\U5de5\U56db\U91d1\U7f34\U7eb3";
// },
#import "Survery.h"

@implementation Survery

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (Survery *)createSurveryWithDict:(NSDictionary *)dict
{
    Survery *survery = [[Survery alloc] init];
    survery.content = dict[@"Description"];
    survery.title = dict[@"Title"];
    survery.endTime = [self getCorrectDate:dict[@"ExpireTime"]];
    survery.questions = dict[@"Questions"];
    survery.sid = dict[@"SurveyId"];
    return survery;
}

+ (NSArray *)createSurverysWithArray:(NSArray *)array
{
    NSMutableArray *surArrays = [NSMutableArray array];
    for (int i = 0; i < [array count]; i ++) {
        Survery *survery = [self createSurveryWithDict:array[i]];
        [surArrays addObject:survery];
    }
    return surArrays;
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
