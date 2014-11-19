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
@end
