//
//  StoreViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "StoreViewController.h"

static NSString *imageKey = @"image";
static NSString *titleKey = @"title";
static NSString *detailsKey = @"details";

@interface StoreViewController ()

@property (readwrite) NSMutableArray *attributes;

@end

@implementation StoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		UIImage *normalImage = [UIImage imageNamed:@"mall_icon"];
		UIImage *selectedImage = [UIImage imageNamed:@"mall_icon_press"];//TODO: 图片要换
		if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
			self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:normalImage selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
		} else {
			[self.tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
		}
		self.tabBarItem.title = NSLocalizedString(@"在线商城", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = NSLocalizedString(@"在线商城", nil);
	
	//TODO:此处数据都是写死的，以后要改...
	_attributes = [NSMutableArray array];
	[_attributes addObject:@{imageKey : @"sc", titleKey : @"有机蔬菜", detailsKey : @"花叶菜/根茎菜/菌菇菜/薯芋菜/瓜果菜..."}];
	[_attributes addObject:@{imageKey : @"sg", titleKey : @"时令水果", detailsKey : @"国产水果/进口水果/季节水果/水果礼盒..."}];
	[_attributes addObject:@{imageKey : @"rql", titleKey : @"肉禽蛋类", detailsKey : @"牛羊肉/猪鸡肉/草鸡蛋/青壳蛋/进口肉..."}];
	[_attributes addObject:@{imageKey : @"dftc", titleKey : @"地方特产", detailsKey : @"西北特产/东北特产/西南特产/台湾特产..."}];
	[_attributes addObject:@{imageKey : @"jg", titleKey : @"坚果炒货", detailsKey : @"榛子/核桃/松子/腰果/杏仁/开心果/碧..."}];
	[_attributes addObject:@{imageKey : @"hwg", titleKey : @"海外直购", detailsKey : @"进口红酒/进口牛奶/进口巧克力/进口零食..."}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _attributes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
        [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		cell.imageView.image = [UIImage imageNamed:_attributes[indexPath.row][imageKey]];
		cell.textLabel.text = _attributes[indexPath.row][titleKey];
		cell.detailTextLabel.text = _attributes[indexPath.row][detailsKey];
    }
    return cell;
}

@end
