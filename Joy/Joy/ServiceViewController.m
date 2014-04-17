//
//  ServiceViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController {
    NSArray *infoArray;
    NSArray *firstArray;
    NSArray *secondArray;
    NSArray *thirdArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        infoArray = [NSArray array];
        firstArray = @[@"电影票务", @"游泳健身", @"休闲旅游", @"教育培训"];
        secondArray = @[@"入职体检", @"年度体检", @"牙齿健康", @"心里资讯"];
        thirdArray = @[@"意外险", @"医疗险", @"雇主险", @"家属险"];
        
        [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"life_icon_press"] withFinishedUnselectedImage:[UIImage imageNamed:@"life_icon"]];
        self.tabBarItem.title = @"生活服务";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTitleIconWithTitle:@"生活服务"];
    [_tableView setTableHeaderView:_headerView];
    [self loadDataWithIndex:0];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadDataWithIndex:(NSInteger)index
{
    //TO DO:以后要改
    if (index == 0) {
        _liftBigBtn.selected = YES;
        _liftSmallBtn.selected = YES;
        _healthBigBtn.selected = NO;
        _healthSmallBtn.selected = NO;
        _saveBigBtn.selected = NO;
        _saveSmallBtn.selected = NO;
        infoArray = firstArray;
    } else if (index == 1) {
        _liftBigBtn.selected = NO;
        _liftSmallBtn.selected = NO;
        _healthBigBtn.selected = YES;
        _healthSmallBtn.selected = YES;
        _saveBigBtn.selected = NO;
        _saveSmallBtn.selected = NO;
        infoArray = secondArray;
    } else {
        _liftBigBtn.selected = NO;
        _liftSmallBtn.selected = NO;
        _healthBigBtn.selected = NO;
        _healthSmallBtn.selected = NO;
        _saveBigBtn.selected = YES;
        _saveSmallBtn.selected = YES;
        infoArray = thirdArray;
    }
    [_tableView reloadData];
}

- (IBAction)liftBtnClick:(id)sender
{
    [self loadDataWithIndex:0];
}

- (IBAction)healthBtnClick:(id)sender
{
    [self loadDataWithIndex:1];
}

- (IBAction)saveBtnClick:(id)sender
{
    [self loadDataWithIndex:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 13)];
        [imageView setImage:[UIImage imageNamed:@"arrow"]];
        [cell setAccessoryView:imageView];
        cell.textLabel.text = infoArray[indexPath.row];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 320, .5)];
        [line setBackgroundColor:[UIColor lightGrayColor]];
        [cell.contentView addSubview:line];
    }
    return cell;
}

@end
