//
//  SurveryCell.h
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Survery.h"

@protocol SurveryCellDelegate <NSObject>
- (void)voteButtonClicked:(NSString *)voteString andSurvery:(Survery *)survery;
@end

@interface SurveryCell : UITableViewCell {
    
}
@property (nonatomic, weak) id<SurveryCellDelegate> delegate;
@property (nonatomic, strong) Survery *survery;
- (CGFloat)height;
@end
