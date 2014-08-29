//
//  Survery.h
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBModel.h"

@interface Survey : ZBModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *questions;
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSDictionary *answers;
@property (nonatomic, strong) NSArray *surveyRates;
@property (nonatomic, strong) NSString *optionType;
@property (nonatomic, strong) NSString *min;
@property (nonatomic, strong) NSString *max;
@property (nonatomic, assign) BOOL bExpired;

- (NSString *)votesStringWithVotes:(NSArray *)votes;
- (BOOL)isRadio;

@end
