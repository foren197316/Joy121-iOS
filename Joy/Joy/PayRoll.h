//
//  PayRoll.h
//  Joy
//
//  Created by summer on 11/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface PayRoll : ZBModel
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *payablepay; //基本工资小计
@property (nonatomic, strong) NSString *subsidysum;//补贴小计
@property (nonatomic, strong) NSString *sequestrate;//扣款小计
@property (nonatomic, strong) NSString *username;//名字
@property (nonatomic, strong) NSString *period;//时间
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *employeeid;
@property (nonatomic, strong) NSString *englishname;
@property (nonatomic, strong) NSString *basepay;
@property (nonatomic, strong) NSString *meritpay;
@property (nonatomic, strong) NSString *housingallowance;
@property (nonatomic, strong) NSString *positionsalary;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *overtimesalary;
@property (nonatomic, strong) NSString *mealallowance;
@property (nonatomic, strong) NSString *temperatureallowance;
@property (nonatomic, strong) NSString *others;
@property (nonatomic, strong) NSString *transportationallowance;
@property (nonatomic, strong) NSString *endowmentinsurance;//养老金
@property (nonatomic, strong) NSString *endowmentinsuranceretroactive;//养老金补缴
@property (nonatomic, strong) NSString *hospitalizationinsurance;//医疗
@property (nonatomic, strong) NSString *hospitalizationinsuranceretroactive;//医疗补缴
@property (nonatomic, strong) NSString *unemploymentinsurance;//失业金
@property (nonatomic, strong) NSString *unemploymentinsuranceretroactive;//失业金补缴
@property (nonatomic, strong) NSString *reservefund;//公积金
@property (nonatomic, strong) NSString *reservefundretroactive;//公积金补缴
@property (nonatomic, strong) NSString *taxdeduction;
@property (nonatomic, strong) NSString *sickleave;
@property (nonatomic, strong) NSString *personalleave;
@property (nonatomic, strong) NSString *salaryaccount;
@property (nonatomic, strong) NSString *leavededuction;
@property (nonatomic, strong) NSString *bonus;
@property (nonatomic, strong) NSString *annualbonus;
@property (nonatomic, strong) NSString *pretaxwages;
@property (nonatomic, strong) NSString *incometax;
@property (nonatomic, strong) NSString *onechildfee;
@property (nonatomic, strong) NSString *subsidy;
@property (nonatomic, strong) NSString *realwages;

@end
