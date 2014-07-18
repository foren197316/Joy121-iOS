//
//  DSHFlashImage.h
//  dushuhu
//
//  Created by zhangbin on 3/21/14.
//  Copyright (c) 2014 zoombin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

@interface DSHFlashImage : ZBModel

@property (nonatomic, strong) NSString *path;

+ (CGSize)originSize;
+ (CGFloat)scaledHeightFitWith:(CGFloat)width;

@end
