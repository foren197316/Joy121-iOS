//
//  Food.h
//  Joy
//
//  Created by zhangbin on 7/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ZBModel.h"

@interface Food : ZBModel

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *describe;
@property (nonatomic, strong) NSNumber *price;

@end
