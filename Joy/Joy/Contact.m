//
//  Contact.m
//  Joy
//
//  Created by zhangbin on 11/11/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
	self = [super init];
	if (self) {
		if (attributes[@"PersonName"] != [NSNull null]) _personName = attributes[@"PersonName"];
		if (attributes[@"EnglishName"] != [NSNull null]) _englishName = attributes[@"EnglishName"];
		if (attributes[@"Mobile"] != [NSNull null]) _mobile = attributes[@"Mobile"];
		if (attributes[@"ComPos"] != [NSNull null]) _companyPosition = attributes[@"ComPos"];
		if (attributes[@"ComDep"] != [NSNull null]) _companyDepartment = attributes[@"ComDep"];
		if (attributes[@"Email"] != [NSNull null]) _email = attributes[@"Email"];
		if (attributes[@"Phone"] != [NSNull null]) _phone = attributes[@"Phone"];
		if (attributes[@"CompanyName"] != [NSNull null]) _companyName = attributes[@"CompanyName"];
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"< personName: %@, mobile: %@, department: %@, phone: %@ >", _personName, _mobile, _companyDepartment, _phone];
}

@end
