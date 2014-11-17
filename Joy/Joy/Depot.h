//
//  Depot.h
//  Joy
//
//  Created by zhangbin on 11/17/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface Depot : ZBModel

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *imagePath;

@end
