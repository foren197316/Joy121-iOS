//
//  EntryTableView.h
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyImageCell.h"
#import "ApplyPickerCell.h"
#import "ApplyRadioCell.h"
#import "ApplyTextFiledCell.h"

@class EntryTableView;

@interface EntryTableView : UITableView

@property (nonatomic, strong) NSArray *datas;

@end
