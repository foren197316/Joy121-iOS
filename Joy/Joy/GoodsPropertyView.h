//
//  GoodsPropertyView.h
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsProperty.h"

@class GoodsPropertyView;
@protocol GoodsPropertyViewDelegate <NSObject>

- (void)goodsPropertyView:(GoodsPropertyView *)goodsPropertyView selected:(BOOL)selected;

@end

@interface GoodsPropertyView : UIView

@property (nonatomic, weak) id <GoodsPropertyViewDelegate> delegate;
@property (nonatomic, strong) GoodsProperty *property;
@property (nonatomic, assign) BOOL selected;

+ (CGSize)size;

@end
