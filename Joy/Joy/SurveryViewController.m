//
//  SurveryViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-8.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "SurveryViewController.h"

@interface SurveryViewController ()

@end

@implementation SurveryViewController {
    NSArray *surveryArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"公司调查";
    }
    return self;
}

- (void)loadSurveryList
{
    [self displayHUD:@"加载中..."];
    [[JAFHTTPClient shared] surList:nil withBlock:^(NSDictionary *result, NSError *error) {
        [self hideHUD:YES];
        if ([result[@"retobj"] isKindOfClass:[NSArray class]]) {
            if ([result[@"retobj"] count] > 0) {
				surveryArray = [Survery multiWithAttributesArray:result[@"retobj"]];
                [_tableView reloadData];
            }
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSurveryList];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [surveryArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SurveryCell *cell = (SurveryCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    SurveryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[SurveryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setDelegate:self];
        [cell setBackgroundColor:[UIColor clearColor]];
        if ([surveryArray count] > 0) {
            Survery *survery = surveryArray[indexPath.row];
            [cell setSurvery:survery];
        }
    }
    return cell;
}

- (void)voteButtonClicked:(NSString *)voteString andSurvery:(Survery *)survery
{
    [[JAFHTTPClient shared] voteSubmit:survery.sid answers:voteString withBlock:^(NSDictionary *result, NSError *error) {
        [self loadSurveryList];
    }];
}

@end
