//
//  DSHGoodsTableViewCell.h
//  dushuhu
//
//  Created by zhangbin on 3/6/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHGoods.h"
#import "DSHCart.h"
#import "DSHGoodsForCart.h"
#import "WelInfo.h"
//#import "WelInfoForCart.h"

@protocol DSHGoodsTableViewCellDelegate <NSObject>

@optional
- (void)willAddToCart:(DSHGoods *)goods;
- (void)willIncreaseGoods:(DSHGoods *)goods;
- (void)willDecreaseGoods:(DSHGoods *)goods;
- (void)willIncreaseWel:(WelInfo *)wel;
- (void)willDecreaseWel:(WelInfo *)wel;

@end

@interface DSHGoodsTableViewCell : UITableViewCell

@property (nonatomic, weak) id<DSHGoodsTableViewCellDelegate> delegate;
@property (nonatomic, assign) BOOL isCartSytle;
@property (nonatomic, strong) DSHGoodsForCart *goodsForCart;
@property (nonatomic, strong) DSHGoods *goods;
@property (nonatomic, strong) NSNumber *quanlity;
@property (nonatomic, strong) WelInfo *wel;

+ (CGFloat)height;

@end