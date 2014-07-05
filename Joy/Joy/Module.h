//
//  Module.h
//  Joy
//
//  Created by zhangbin on 7/5/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

typedef NS_ENUM(NSUInteger, CompanyModuleType) {
    CompanyModuleTypeEvent,
    CompanyModuleTypeTraining
};


@interface Module : ZBModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;

@end
