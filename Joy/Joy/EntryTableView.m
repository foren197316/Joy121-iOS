//
//  EntryTableView.m
//  Joy
//
//  Created by gejw on 15/8/18.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import "EntryTableView.h"

@interface EntryTableView () <UITableViewDelegate, UITableViewDataSource> {
    
}

@end

@implementation EntryTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        

    }
    return self;
}

- (void)setDatas:(NSArray *)datas {
    if (datas) {
        _datas = datas;
        [self reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyCommondCell *cell = [_datas objectAtIndex:indexPath.row];
    return cell.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyCommondCell *cell = [_datas objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
//    NSDictionary *item = [_datas objectAtIndex:indexPath.row];
//    NSUInteger type = [[item objectForKey:@"type"] integerValue];
//    switch (type) {
//        case CellImage:
//            
//            break;
//        case CellImage:
//            
//            break;
//        case CellImage:
//            
//            break;
//        case CellImage:
//            
//            break;
//            
//        default:
//            break;
//    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 25, 20)];
//        iconImageView.contentMode = UIViewContentModeScaleToFill;
//        iconImageView.tag = 10000;
//        [cell.contentView addSubview:iconImageView];
//        
//        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.right + 5, 0, 0, 50)];
//        titleLabel.tag = 10001;
//        titleLabel.textColor = [UIColor colorWithRed:0.4 green:0.51 blue:0.61 alpha:1];
//        titleLabel.font = [UIFont systemFontOfSize:15];
//        [cell.contentView addSubview:titleLabel];
//    }
//    UIImageView *iconImageView = (UIImageView *)[cell.contentView viewWithTag:10000];
//    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:10001];
//    iconImageView.image = [[_datas objectAtIndex:indexPath.row] objectForKey:@"icon"];
//    titleLabel.text = [[_datas objectAtIndex:indexPath.row] objectForKey:@"title"];
//    CGSize textSize = [titleLabel.text calcTextSize:CGSizeZero font:titleLabel.font];
//    titleLabel.frame = CGRectMake(titleLabel.x, titleLabel.y, textSize.width, titleLabel.height);
//    return cell;
}

@end
