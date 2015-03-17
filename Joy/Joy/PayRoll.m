//
//  PayRoll.m
//  Joy
//
//  Created by summer on 11/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "PayRoll.h"

@implementation PayRoll

-(instancetype) initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
    if (self){
		_ID = [attributes[@"Id"] notNull];
        _payablepay = [attributes[@"payablepay"] notNull];
        _subsidysum = [attributes[@"subsudysum"] notNull];
        _sequestrate = [attributes[@"sequestrate"] notNull];
        _period = [attributes[@"period"] notNull];
		
		_bonus = [attributes[@"bonus"] notNull];//奖金
		_annualbonus = [attributes[@"annualbonus"] notNull];//年终奖
		_onechildfee = [attributes[@"onechildfee"] notNull];//独生子女
		_realwages = [attributes[@"realwages"] notNull];//实发工资
		_subsidy = [attributes[@"subsidy"] notNull];//津贴
		_others = [attributes[@"others"] notNull];//其他
		_incometax = [attributes[@"incometax"] notNull];//所得税
		_pretaxwages = [attributes[@"pretaxwages"] notNull];//税前工资
		
		_leavededuction = [attributes[@"leavededuction"] notNull];//请假扣款
		_endowmentinsurance = [attributes[@"endowmentinsurance"] notNull];//个人养老保险
		_hospitalizationinsurance = [attributes[@"hospitalizationinsurance"] notNull];//个人医疗保险
		_unemploymentinsurance = [attributes[@"unemploymentinsurance"] notNull];//个人失业保险
		_reservefund = [attributes[@"reservefund"] notNull];//个人公积金
    }
    return self;
}

@end
