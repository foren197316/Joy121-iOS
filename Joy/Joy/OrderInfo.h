//
//  OrderInfo.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"
#import "WelInfo.h"

@interface OrderInfo : ZBModel

@property (nonatomic, strong) NSArray *welArrays;//WelInfo
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *orderNo;

@end
