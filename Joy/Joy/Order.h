//
//  Order.h
//  Joy
//
//  Created by zhangbin on 7/29/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface Order : ZBModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSNumber *points;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSArray *items;

@end
