//
//  GoodsProperty.h
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface GoodsProperty : ZBModel

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *value;

@end
