//
//  DSHGoodsView.h
//  dushuhu
//
//  Created by zhangbin on 3/27/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHGoods.h"

@protocol DSHGoodsViewDelegate;
@interface DSHGoodsView : UIView

@property (nonatomic, weak) id<DSHGoodsViewDelegate> delegate;
@property (nonatomic, strong) DSHGoods *goods;

+ (CGSize)size;
+ (CGSize)bigSize;

@end


@protocol DSHGoodsViewDelegate <NSObject>

- (void)goodsView:(DSHGoodsView *)goodsView didSelectGoods:(DSHGoods *)goods;

@end
