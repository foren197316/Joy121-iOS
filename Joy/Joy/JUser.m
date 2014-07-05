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

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_realName = attributes[@"UserName"];
		_companyName = attributes[@"CompanyName"];
		_score = attributes[@"Points"];
		_userName = attributes[@"LoginName"];
		_cardNo = attributes[@"IdNo"];
		_gender = [attributes[@"Gender"] isEqualToString:@"0"] ? @"男" : @"女";
		_email = attributes[@"Mail"];
		_telephone = attributes[@"PhoneNumber"];
		_reDate = [attributes[@"CreateTime"] getCorrectDate];
		_birthDay = [attributes[@"BirthDay"] getCorrectDate];
		if (attributes[@"CompanyInfo"]) {
			_address = attributes[@"CompanyInfo"][@"CompAddr"];
			_icon = [NSString stringWithFormat:@"%@%@", HEADER_URL, attributes[@"CompanyInfo"][@"CompLogo"]];
			_companyShort = attributes[@"CompanyInfo"][@"Company"];
		}
	}
	return self;
}

@end
