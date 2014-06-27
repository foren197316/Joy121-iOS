//
//  StoreViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController {
    NSArray *imageNamesArray;
    NSArray *titlesArray;
    NSArray *describeArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //TODO:此处数据都是写死的，以后要改...
        imageNamesArray = @[@"sc", @"sg", @"rql", @"dftc", @"jg", @"hwg"];
        titlesArray = @[@"有机蔬菜", @"时令水果" ,@"肉禽蛋类", @"地方特产", @"坚果炒货", @"海外直购"];
        describeArray = @[@"花叶菜/根茎菜/菌菇菜/薯芋菜/瓜果菜...", @"国产水果/进口水果/季节水果/水果礼盒...", @"牛羊肉/猪鸡肉/草鸡蛋/青壳蛋/进口肉...", @"西北特产/东北特产/西南特产/台湾特产...", @"榛子/核桃/松子/腰果/杏仁/开心果/碧...", @"进口红酒/进口牛奶/进口巧克力/进口零食..."];
        
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"mall_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"mall_icon"]];//TODO: 图片要换
        self.tabBarItem.title = @"在线商城";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTitleIconWithTitle:@"在线商城"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,15, 50, 50)];
        [iconImageView setImage:[UIImage imageNamed:imageNamesArray[indexPath.row]]];
        [cell.contentView addSubview:iconImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 200, 20)];
        [titleLabel setText:titlesArray[indexPath.row]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:titleLabel];
        
        UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 45, 200, 20)];
        [describeLabel setText:describeArray[indexPath.row]];
        [describeLabel setFont:[UIFont systemFontOfSize:14]];
        [describeLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:describeLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 13)];
        [imageView setImage:[UIImage imageNamed:@"arrow"]];
        [cell setAccessoryView:imageView];
//        cell.textLabel.text = infoArray[indexPath.row];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 79, 320, .5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [cell.contentView addSubview:line];
    }
    return cell;
}

@end
