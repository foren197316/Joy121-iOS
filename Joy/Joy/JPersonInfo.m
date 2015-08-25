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
