//
//  JUser.h
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

@interface JUser : ZBModel

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *birthDay;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *reDate;//注册日期
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *cardNo;//身份证
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *companyShort;

@end

