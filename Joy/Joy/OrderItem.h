//
//  OrderItem.h
//  Joy
//
//  Created by zhangbin on 7/29/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface OrderItem : ZBModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageULRString;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *propertyString;

- (NSString *)displayProperty;

@end
