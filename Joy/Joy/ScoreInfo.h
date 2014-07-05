//
//  ScoreInfo.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

@interface ScoreInfo : ZBModel

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *mark;

@end
