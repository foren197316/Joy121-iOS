//
//  SurveryCell.h
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Survey.h"

@protocol SurveyCellDelegate <NSObject>

- (void)voteButtonClicked:(NSString *)voteString andSurvery:(Survey *)survery;

@end

@interface SurveyCell : UITableViewCell

@property (nonatomic, weak) id<SurveyCellDelegate> delegate;
@property (nonatomic, strong) Survey *survery;
- (CGFloat)height;

@end
