//
//  GoodsAmount.h
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface GoodsAmount : ZBModel

@property (nonatomic, strong) NSString *goodsID;
@property (nonatomic, strong) NSArray *properties;
@property (nonatomic, strong) NSString *amount;

@end
