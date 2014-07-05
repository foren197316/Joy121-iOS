//
//  NoticeViewController.m
//  Joy
//
//  Created by 颜超 on 14-5-6.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeCell.h"

@interface NoticeViewController ()

@property (readwrite) NSArray *notices;

@end

@implementation NoticeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"公告", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self displayHUD:@"加载中..."];
	[[JAFHTTPClient shared] companyNoticeIsExpired:YES withBlock:^(NSArray *multiAttributes, NSError *error) {
		if (!error) {
			_notices = [Notice multiWithAttributesArray:multiAttributes];
			[_tableView reloadData];
		}
        [self hideHUD:YES];
	}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _notices.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeCell *cell = (NoticeCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"Cell";
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
		Notice *notice = _notices[indexPath.row];
		[cell setNotice:notice];
    }
    return cell;
}

@end
