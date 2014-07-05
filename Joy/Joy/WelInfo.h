//
//  WelInfo.h
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

@interface WelInfo : ZBModel

@property (nonatomic, strong) NSString *shortDescribe;
@property (nonatomic, strong) NSArray *picturesArray;
@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *wid;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *longDescribe;
@property (nonatomic, strong) NSString *welName;//全称
@property (nonatomic, strong) NSString *type;//id
@property (nonatomic, strong) NSString *typeName;//类型名称
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

@end
