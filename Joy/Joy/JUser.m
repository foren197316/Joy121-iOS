//
//  JUser.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "JUser.h"

@implementation JUser

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super initWithAttributes:attributes];
	if (self) {
		if (attributes[@"UserName"] != [NSNull null]) _realName = attributes[@"UserName"];
		if (attributes[@"CompanyName"] != [NSNull null]) _companyName = attributes[@"CompanyName"];
		if (attributes[@"Points"] != [NSNull null]) _score = [NSString stringWithFormat:@"%@", attributes[@"Points"]];
		if (attributes[@"LoginName"] != [NSNull null]) _userName = attributes[@"LoginName"];
		if (attributes[@"IdNo"] != [NSNull null]) _cardNo = attributes[@"IdNo"];
		if (attributes[@"Gender"] != [NSNull null]) _gender = [attributes[@"Gender"] isEqualToString:@"0"] ? @"男" : @"女";
		if (attributes[@"Mail"] != [NSNull null]) _email = attributes[@"Mail"];
		if (attributes[@"PhoneNumber"] != [NSNull null]) _telephone = attributes[@"PhoneNumber"];
		if (attributes[@"CreateTime"] != [NSNull null]) _reDate = [attributes[@"CreateTime"] getCorrectDate];
		if (attributes[@"BirthDay"] != [NSNull null]) _birthDay = [attributes[@"BirthDay"] getCorrectDate];
		if (attributes[@"CompanyInfo"]) {
			_address = attributes[@"CompanyInfo"][@"CompAddr"];
			_icon = [NSString stringWithFormat:@"%@%@%@", [JAFHTTPClient shared].baseURL.absoluteString, @"files/logo/", attributes[@"CompanyInfo"][@"CompLogo"]];
			_companyShort = attributes[@"CompanyInfo"][@"Company"];
		}
		
		if (attributes[@"CompanyInfo"]) {
			_company = [[Company alloc] initWithAttributes:attributes[@"CompanyInfo"]];
		}
	}
	return self;
}

@end
