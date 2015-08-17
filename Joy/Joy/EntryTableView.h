//
//  EntryTableView.h
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EntryTableView;

@protocol EntryTableViewDelegate <NSObject>

- (void)entryTableViewSaveEvent:(EntryTableView *)tableView;

- (void)entryTableViewNextEvent:(EntryTableView *)tableView;

@end

@interface EntryTableView : UITableView

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) id<EntryTableViewDelegate> entryDelegate;

@end
