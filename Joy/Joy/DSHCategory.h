//
//  DSHCategory.h
//  dushuhu
//
//  Created by zhangbin on 3/27/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "ZBModel.h"

@interface DSHCategory : ZBModel

@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *multiGoods;

@end
