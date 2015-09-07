//
//  JPersonInfo.m
//  Joy
//
//  Created by gejw on 15/8/21.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "JPersonInfo.h"

@implementation JPersonInfo

static JPersonInfo *personInfo = nil;
+ (JPersonInfo *)person {
    return personInfo;
}

+ (void)setPerson:(JPersonInfo *)person {
    personInfo = person;
}

@end

#pragma 个人经历

@implementation JExperiences

+ (NSDictionary *)objectClassInArray{
    return @{@"Job" : [JJob class], @"Learning" : [JLearning class]};
}

@end


@implementation JJob

@end


@implementation JLearning

@end

#pragma 家庭信息

@implementation JFamily

@end

#pragma 附件信息

@implementation JMaterials

@end
@implementation JIdimage

@end