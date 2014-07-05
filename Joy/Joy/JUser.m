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
    user.reDate = [dict[@"CreateTime"] getCorrectDate];
    user.birthDay = [dict[@"BirthDay"] getCorrectDate];
    if (dict[@"CompanyInfo"]) {
        user.address = dict[@"CompanyInfo"][@"CompAddr"];
        user.icon = [NSString stringWithFormat:@"%@%@", HEADER_URL,dict[@"CompanyInfo"][@"CompLogo"]];
        user.companyShort = dict[@"CompanyInfo"][@"Company"];
    }
    return user;
}

@end
