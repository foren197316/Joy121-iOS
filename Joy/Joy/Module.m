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
#import "ContactsTableViewController.h"
#import "DepotTableViewController.h"
#import "PayRollViewController.h"
//#import "ClockViewController.h"
#import "SystemViewController.h"
#import "PerformanceViewController.h"
#import "NSString+ZBUtilites.h"

#define sCompanyModuleTypeBenefits @"福利"
#define sCompanyModuleTypeLogoStore @"商店"
#define sCompanyModuleTypeBusinessman @"商户"
#define sCompanyModuleTypeGroupOn @"团购"
#define sCompanyModuleTypeContacts @"通讯录"
#define sCompanyModuleTypeNotice @"公告"
#define sCompanyModuleTypeEvent @"活动"
#define sCompanyModuleTypeTraining @"培训"
#define sCompanyModuleTypeSurvey @"调查"
#define sCompanyModuleTypeDepot @"领用"
#define sCompanyModuleTypePayRoll @"工资单"
#define sCompanyModuleTypeClock @"打卡"
#define sCompanyModuleTypeSystem @"规章"
#define sCompanyModuleTypePerformance @"绩效"


#define kIcon @"icon"
#define kChildViewControllerClass @"class"

@implementation Module

- (instancetype)initWithAttributes:(NSDictionary *)attributes; {
	self = [super initWithAttributes:attributes];
	if (self) {
		_ID = [attributes[@"ModuleId"] notNull];
		_name = [attributes[@"ModuleName"] notNull];
	}
	return self;
}

- (NSDictionary *)attributes {
	static NSMutableDictionary *attributes;
	if (!attributes) {
		attributes = [NSMutableDictionary dictionary];
		attributes[@(CompanyModuleTypeBenefits)] = @{kIcon : [UIImage imageNamed:@"ModuleBenefits"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeLogoStore)] = @{kIcon : [UIImage imageNamed:@"ModuleLogoStore"], kChildViewControllerClass : [LogoStoreViewController class]};
		attributes[@(CompanyModuleTypeBusinessman)] = @{kIcon : [UIImage imageNamed:@"ModuleBusinessman"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeGroupOn)] = @{kIcon : [UIImage imageNamed:@"ModuleGroupOn"], kChildViewControllerClass : [JoyViewController class]};
		attributes[@(CompanyModuleTypeContacts)] = @{kIcon : [UIImage imageNamed:@"ModuleContacts"], kChildViewControllerClass : [ContactsTableViewController class]};
		attributes[@(CompanyModuleTypeNotice)] = @{kIcon : [UIImage imageNamed:@"ModuleNotice"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeEvent)] = @{kIcon : [UIImage imageNamed:@"ModuleEvent"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeTraining)] = @{kIcon : [UIImage imageNamed:@"ModuleTraining"], kChildViewControllerClass : [ModuleViewController class]};
		attributes[@(CompanyModuleTypeSurvey)] = @{kIcon : [UIImage imageNamed:@"ModuleSurvey"], kChildViewControllerClass : [SurveyViewController class]};
		attributes[@(CompanyModuleTypeDepot)] = @{kIcon : [UIImage imageNamed:@"ModuleSurvey"], kChildViewControllerClass : [DepotTableViewController class]};
        attributes[@(CompanyModuleTypePayRoll)] = @{kIcon : [UIImage imageNamed:@"ModuleSurvey"], kChildViewControllerClass : [PayRollViewController class]};
        attributes[@(CompanyModuleTypeSystem)] = @{kIcon : [UIImage imageNamed:@"ModuleTraining"], kChildViewControllerClass:[SystemViewController class]};
		attributes[@(CompanyModuleTypePerformance)] = @{kIcon : [UIImage imageNamed:@"ModuleTraining"], kChildViewControllerClass:[PerformanceViewController class]};
	}
	return attributes;
}

- (CompanyModuleType)moduleType {
	if ([_name stringContainsString:sCompanyModuleTypeBenefits]) {
		return CompanyModuleTypeBenefits;
	} else if ([_name stringContainsString:sCompanyModuleTypeLogoStore]) {
		return CompanyModuleTypeLogoStore;
	} else if ([_name stringContainsString:sCompanyModuleTypeBusinessman]) {
		return CompanyModuleTypeBusinessman;
	} else if ([_name stringContainsString:sCompanyModuleTypeGroupOn]) {
		return CompanyModuleTypeGroupOn;
	} else if ([_name stringContainsString:sCompanyModuleTypeNotice]) {
		return CompanyModuleTypeNotice;
	} else if ([_name stringContainsString:sCompanyModuleTypeEvent]) {
		return CompanyModuleTypeEvent;
	} else if ([_name stringContainsString:sCompanyModuleTypeTraining]) {
		return CompanyModuleTypeTraining;
	} else if ([_name stringContainsString:sCompanyModuleTypeSurvey]) {
		return CompanyModuleTypeSurvey;
	} else if ([_name stringContainsString:sCompanyModuleTypeContacts]) {
		return CompanyModuleTypeContacts;
	} else if ([_name stringContainsString:sCompanyModuleTypeDepot]) {
		return CompanyModuleTypeDepot;
	} else if ([_name stringContainsString:sCompanyModuleTypePayRoll]) {
		return CompanyModuleTypePayRoll;
	} else if ([_name stringContainsString:sCompanyModuleTypeClock]) {
		return CompanyModuleTypeClock;
	} else if ([_name stringContainsString:sCompanyModuleTypeSystem]) {
		return  CompanyModuleTypeSystem;
	} else if ([_name stringContainsString:sCompanyModuleTypePerformance]) {
		return  CompanyModuleTypePerformance;
	}
	return CompanyModuleTypeBenefits;
}

- (UIImage *)icon {
	return [self attributes][@([self moduleType])][kIcon];
}

- (Class)childViewControllerClass {
	return [self attributes][@([self moduleType])][kChildViewControllerClass];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"< id: %@, name: %@>", _ID, _name];
}

@end
