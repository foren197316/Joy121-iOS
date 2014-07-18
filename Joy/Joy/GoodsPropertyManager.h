//
//  GoodsPropertyManager.h
//  Joy
//
//  Created by zhangbin on 7/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsPropertyManager : NSObject

+ (instancetype)shared;
- (void)updateWithBlock:(void (^)())block;
- (void)displayNameOfIdentifier:(NSString *)identifier withBlock:(void (^)(NSString *displayName))block;

@end
