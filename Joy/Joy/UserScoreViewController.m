//
//  UserScoreViewController.m
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "UserScoreViewController.h"
#import "ScoreInfo.h"

@interface UserScoreViewController ()

@end

#define CELL_COLOR_ONE  [UIColor colorWithRed:253.0/255.0 green:253.0/255.0 blue:253.0/255.0 alpha:1.0]
#define CELL_COLOR_TWO [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0]
#define CELL_TXT_COLOR [UIColor colorWithRed:253.0/255.0 green:173.0/255.0 blue:103.0/255.0 alpha:1.0]

@implementation UserScoreViewController {
    NSArray *infoArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"积分历史";
        infoArray = [NSArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadScoreInfo];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadScoreInfo
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] userScore:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if (result[@"retobj"] && [result[@"retobj"] isKindOfClass:[NSArray class]]) {
			infoArray = [ScoreInfo multiWithAttributesArray:result[@"retobj"]];
            [_tableView reloadData];
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoArray count];
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
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        if ((indexPath.row + 1) % 2 == 0) {
            [cell.contentView setBackgroundColor:CELL_COLOR_ONE];
        } else {
            [cell.contentView setBackgroundColor:CELL_COLOR_TWO];
        }
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 200, 14)];
        [timeLabel setTextColor:CELL_TXT_COLOR];
        [timeLabel setBackgroundColor:[UIColor clearColor]];
        [timeLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:timeLabel];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 3, 95, 14)];
        [scoreLabel setTextAlignment:NSTextAlignmentRight];
        [scoreLabel setBackgroundColor:[UIColor clearColor]];
        [scoreLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:scoreLabel];
        
        UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 290, 12)];
        [markLabel setFont:[UIFont systemFontOfSize:12]];
        [markLabel setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:markLabel];
        if ([infoArray count] > 0) {
            ScoreInfo *info = infoArray[indexPath.row];
            timeLabel.text = info.date;
            markLabel.text = [NSString stringWithFormat:@"备注说明: %@", info.mark];
            scoreLabel.text = [NSString stringWithFormat:@"%@", info.score];
        }
        
    }
    return cell;
}

@end
