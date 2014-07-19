//
//  DSHGoodsForCart.h
//  Joy
//
//  Created by zhangbin on 7/19/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSHGoods.h"

@interface DSHGoodsForCart : NSObject

@property (nonatomic, strong) DSHGoods *goods;
@property (nonatomic, strong) NSNumber *quanlity;
@property (nonatomic, strong) NSString *propertyValues;

- (NSNumber *)totalPrice;
- (NSNumber *)totalCredits;
- (NSDictionary *)orderAttributes;
- (NSString *)describe;

@end
