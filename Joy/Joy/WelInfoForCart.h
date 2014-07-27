//
//  DSHWelForCart.h
//  Joy
//
//  Created by zhangbin on 7/27/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WelInfo.h"

@interface WelInfoForCart : NSObject

@property (nonatomic, strong) WelInfo *wel;
@property (nonatomic, strong) NSNumber *quanlity;

- (NSString *)describe;

@end
