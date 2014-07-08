//
//  DSHGoods.h
//  dushuhu
//
//  Created by zhangbin on 3/5/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

@interface DSHGoods : ZBModel

@property (nonatomic, strong) NSString *goodsID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shopPrice;
@property (nonatomic, strong) NSString *marketPrice;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *imageThumbPath;
@property (nonatomic, strong) NSString *describe;
@property (nonatomic, strong) NSString *boughtCount;
@property (nonatomic, strong) NSNumber *credits;

- (NSNumber *)price;
- (BOOL)needCredits;
- (NSString *)creditsPrice;

@end
