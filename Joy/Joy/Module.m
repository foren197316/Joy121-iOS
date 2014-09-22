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
#import "SurveyViewController.h"

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
	static NSMutableDictionary *attributes;
	if (!attributes) {
		attributes = [NSMutableDictionary dictionary];
		attributes[@(CompanyModuleTypeBenefits)] = @{kIcon : [UIImage imageNamed:@"ModuleBenefits"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeLogoStore)] = @{kIcon : [UIImage imageNamed:@"ModuleLogoStore"], kChildViewControllerClass : [LogoStoreViewController class]};
		attributes[@(CompanyModuleTypeBusinessman)] = @{kIcon : [UIImage imageNamed:@"ModuleBusinessman"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeGroupOn)] = @{kIcon : [UIImage imageNamed:@"ModuleGroupOn"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeContacts)] = @{kIcon : [UIImage imageNamed:@"ModuleContacts"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeNotice)] = @{kIcon : [UIImage imageNamed:@"ModuleNotice"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeEvent)] = @{kIcon : [UIImage imageNamed:@"ModuleEvent"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeTraining)] = @{kIcon : [UIImage imageNamed:@"ModuleTraining"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeSurvey)] = @{kIcon : [UIImage imageNamed:@"ModuleSurvey"], kChildViewControllerClass : [SurveyViewController class]};
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
	
	range = [_name rangeOfString:sCompanyModuleTypeContacts];
	if (range.location != NSNotFound) {
		return CompanyModuleTypeContacts;
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
