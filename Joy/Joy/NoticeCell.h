//
//  NoticeCell.h
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notice.h"

@interface NoticeCell : UITableViewCell <UIWebViewDelegate>

@property (nonatomic, strong) Notice *notice;

- (CGFloat)height;

@end
