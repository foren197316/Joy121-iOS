//
//  JUser.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "JUser.h"
#define HEADER_URL @"http://www.joy121.com/SYS/Files/logo/"


@implementation JUser

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (JUser *)createJUserWithDict:(NSDictionary *)dict
{
    JUser *user = [[JUser alloc] init];
    user.realName = dict[@"UserName"];
    user.companyName = dict[@"CompanyName"];
    user.score = dict[@"Points"];
    user.userName = dict[@"LoginName"];
    user.cardNo = dict[@"IdNo"];
    user.gender = [dict[@"Gender"] isEqualToString:@"0"] ? @"男" : @"女";
    user.email = dict[@"Mail"];
    user.telephone = dict[@"PhoneNumber"];
    user.reDate = [self getCorrectDate:dict[@"CreateTime"]];
    user.birthDay = [self getCorrectDate:dict[@"BirthDay"]];
    if (dict[@"CompanyInfo"]) {
        user.address = dict[@"CompanyInfo"][@"CompAddr"];
        user.icon = [NSString stringWithFormat:@"%@%@", HEADER_URL,dict[@"CompanyInfo"][@"CompLogo"]];
    }
    return user;
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
