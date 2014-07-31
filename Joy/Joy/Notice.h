//
//  Notice.h
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

@interface Notice : ZBModel

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *postTime;
@property (nonatomic, strong) NSString *imageULRString;
@property (nonatomic, assign) BOOL bExpired;

@end


