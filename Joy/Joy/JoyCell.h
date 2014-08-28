//
//  JoyCell.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelInfo.h"

@protocol JoyCellDelegate <NSObject>
- (void)buyButtonClicked:(WelInfo *)info;
@end
@interface JoyCell : UITableViewCell

@property (nonatomic, weak) id<JoyCellDelegate> delegate;
@property (nonatomic, strong) WelInfo *info;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *describeLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UIButton *addToCartButton;

- (IBAction)buyButtonClick:(id)sender;

@end
