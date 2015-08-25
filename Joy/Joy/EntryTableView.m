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
        
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
        self.tableFooterView = footerView;
        
        float emptyWidth = (footerView.width - 240) / 3;
        UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(emptyWidth, 10, 120, 40)];
        [saveButton setTitle:@"保    存" forState:UIControlStateNormal];
        [saveButton setTintColor:[UIColor whiteColor]];
        [saveButton setBackgroundImage:[[UIColor colorWithRed:0.54 green:0.6 blue:0.64 alpha:1] toImage] forState:UIControlStateNormal];
        saveButton.layer.borderColor = [UIColor colorWithRed:0.67 green:0.73 blue:0.76 alpha:1].CGColor;
        saveButton.layer.borderWidth = 4;
        [saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:saveButton];
        
        UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(emptyWidth * 2 + 120, 10, 120, 40)];
        [nextButton setTitle:@"下一步 >" forState:UIControlStateNormal];
        [nextButton setTintColor:[UIColor whiteColor]];
        [nextButton setBackgroundImage:[[UIColor colorWithRed:0.38 green:0.61 blue:0.35 alpha:1] toImage] forState:UIControlStateNormal];
        nextButton.layer.borderColor = [UIColor colorWithRed:0.51 green:0.71 blue:0.48 alpha:1].CGColor;
        nextButton.layer.borderWidth = 4;
        [nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:nextButton];
    }
    return self;
}

- (void)setDatas:(NSArray *)datas {
    if (datas) {
        _datas = datas;
        [self reloadData];
    }
}

- (void)next:(id)sender {
    if (_entryDelegate) {
        [_entryDelegate entryTableViewNextEvent:self];
    }
}

- (void)save:(id)sender {
    if (_entryDelegate) {
        [_entryDelegate entryTableViewSaveEvent:self];
    }
    
    [[JAFHTTPClient shared] updatePersonInfo:[JPersonInfo person] success:^{
        
    } failure:^(NSString *msg) {
        NSLog(@"%@", msg);
    }];
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
