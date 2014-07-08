//
//  DSHCart.h
//  dushuhu
//
//  Created by zhangbin on 3/29/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSHGoods.h"

@interface DSHCart : NSObject

+ (instancetype)shared;
- (void)increaseGoods:(DSHGoods *)goods;
- (void)decreaseGoods:(DSHGoods *)goods;
- (void)setGoods:(DSHGoods *)goods quanlity:(NSNumber *)quanlity;
- (NSArray *)allGoods;
- (NSNumber *)sumPrice;
- (NSNumber *)sumCredits;
- (BOOL)existsGoods:(DSHGoods *)goods;
- (NSNumber *)quanlityOfGoods:(DSHGoods *)goods;
- (void)removeGoods:(DSHGoods *)goods;
- (BOOL)isEmpty;
- (BOOL)needPay;
- (BOOL)isValidOrder:(NSString **)message withMinimumPriceForOrder:(NSNumber *)minimum currentCredits:(NSNumber *)currentCredits sessionValidation:(BOOL)validation;
- (NSDictionary *)multiGoodsAttributes;
- (void)reset;
- (NSString *)describe;

@end
