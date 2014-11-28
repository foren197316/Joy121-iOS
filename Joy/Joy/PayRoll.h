//
//  PayRoll.h
//  Joy
//
//  Created by summer on 11/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface PayRoll : ZBModel
@property(nonatomic,strong) NSString * id;
@property(nonatomic,strong) NSString * realwagwages;  //实发工资
@property(nonatomic,strong) NSString * payablepay; //基本工资小计
@property(nonatomic,strong) NSString * subsidysum;//补贴小计
@property(nonatomic,strong) NSString * sequestrate;//扣款小计
@property(nonatomic,strong) NSString * username;//名字
@property(nonatomic,strong) NSString * period;//时间
@property(nonatomic,strong) NSString * department;
@property(nonatomic,strong) NSString * employeeid;
@property(nonatomic,strong) NSString * englishname;
@property(nonatomic,strong) NSString * basepay;
@property(nonatomic,strong) NSString * meritpay;
@property(nonatomic,strong) NSString * housingallowance;
@property(nonatomic,strong) NSString * positionsalary;
@property(nonatomic,strong) NSString * secret;
@property(nonatomic,strong) NSString * overtimesaraly;
@property(nonatomic,strong) NSString * mealallowance;
@property(nonatomic,strong) NSString * temperatureallowance;
@property(nonatomic,strong) NSString * others;
@property(nonatomic,strong) NSString * transportationallowance;
@property(nonatomic,strong) NSString * endowmentinsurance;
@property(nonatomic,strong) NSString * hospitalizationinsurance;
@property(nonatomic,strong) NSString * unemploymentinsurance;
@property(nonatomic,strong) NSString * reservefund;
@property(nonatomic,strong) NSString * taxdeduction;
@property(nonatomic,strong) NSString * sickleave;
@property(nonatomic,strong) NSString * personalleave;
@property(nonatomic,strong) NSString * salaryaccount;
@property(nonatomic,strong) NSString * leavededuction;
@property(nonatomic,strong) NSString * bonus;
@property(nonatomic,strong) NSString * annualbonus;
@property(nonatomic,strong) NSString * pretaxwages;
@property(nonatomic,strong) NSString * incometax;
@property(nonatomic,strong) NSString * onechildfee;
@property(nonatomic,strong) NSString * subsidy;
@end
