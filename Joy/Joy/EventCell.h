//
//  EventCell.h
//  Joy
//
//  Created by 颜超 on 14-5-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@protocol EventCellDelegate <NSObject>
- (void)joinButtonClicked:(Event *)event;
@end

@interface EventCell : UITableViewCell

@property (nonatomic, strong) Event *event;
@property (nonatomic, weak) id<EventCellDelegate> delegate;
- (CGFloat)height;
@end
