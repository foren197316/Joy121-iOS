//
//  Module.m
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "Module.h"
#import "JoyViewController.h"
#import "LogoStoreViewController.h"
#import "ModuleViewController.h"
#import "SurveryViewController.h"

#define sCompanyModuleTypeBenefits @"福利"
#define sCompanyModuleTypeLogoStore @"商店"
#define sCompanyModuleTypeBusinessman @"商户"
#define sCompanyModuleTypeGroupOn @"团购"
#define sCompanyModuleTypeContacts @"通讯录"
#define sCompanyModuleTypeNotice @"公告"
#define sCompanyModuleTypeEvent @"活动"
#define sCompanyModuleTypeTraining @"培训"
#define sCompanyModuleTypeSurvey @"调查"

#define kIcon @"icon"
#define kChildViewControllerClass @"class"

@implementation Module

- (instancetype)initWithAttributes:(NSDictionary *)attributes;
{
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = attributes[@"ModuleId"];
		_name = attributes[@"ModuleName"];
	}
	return self;
}

- (NSDictionary *)attributes
{
	//TODO: icon need change
	static NSMutableDictionary *attributes;
	if (!attributes) {
		attributes = [NSMutableDictionary dictionary];
		attributes[@(CompanyModuleTypeBenefits)] = @{kIcon : [UIImage imageNamed:@"Company_1"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeLogoStore)] = @{kIcon : [UIImage imageNamed:@"Company_2"], kChildViewControllerClass : [LogoStoreViewController class]};
		attributes[@(CompanyModuleTypeBusinessman)] = @{kIcon : [UIImage imageNamed:@"Company_3"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeGroupOn)] = @{kIcon : [UIImage imageNamed:@"Company_4"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeContacts)] = @{kIcon : [UIImage imageNamed:@"Company_1"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeNotice)] = @{kIcon : [UIImage imageNamed:@"Company_5"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeEvent)] = @{kIcon : [UIImage imageNamed:@"Company_6"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeTraining)] = @{kIcon : [UIImage imageNamed:@"Company_1"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeSurvey)] = @{kIcon : [UIImage imageNamed:@"Company_7"], kChildViewControllerClass : [SurveryViewController class]};
	}
	return attributes;
}

- (CompanyModuleType)moduleType
{
	NSRange range;
	range = [_name rangeOfString:sCompanyModuleTypeBenefits];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeBenefits;
	}
	
	range = [_name rangeOfString:sCompanyModuleTypeLogoStore];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeLogoStore;
	}
	
	range = [_name rangeOfString:sCompanyModuleTypeBusinessman];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeBusinessman;
	}
	
	range = [_name rangeOfString:sCompanyModuleTypeGroupOn];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeGroupOn;
	}
	
	range = [_name rangeOfString:sCompanyModuleTypeNotice];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeNotice;
	}
	
	range = [_name rangeOfString:sCompanyModuleTypeEvent];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeEvent;
	}
	
	range = [_name rangeOfString:sCompanyModuleTypeTraining];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeTraining;
	}
	
	range = [_name rangeOfString:sCompanyModuleTypeSurvey];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeSurvey;
	}
	
	return CompanyModuleTypeBenefits;
}

- (UIImage *)icon
{
	return [self attributes][@([self moduleType])][kIcon];
}

- (Class)childViewControllerClass
{
	return [self attributes][@([self moduleType])][kChildViewControllerClass];
}

@end
