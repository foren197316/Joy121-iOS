//
//  DSHCategory.h
//  dushuhu
//
//  Created by zhangbin on 3/27/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import "ZBModel.h"

@interface DSHCategory : ZBModel

@property (nonatomic, strong) NSString *categoryID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *URLString;
@property (nonatomic, strong) NSArray *multiGoods;
@property (nonatomic, strong) UIColor *color;

@end
