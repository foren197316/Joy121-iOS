//
//  ContactsTableViewController.m
//  Joy
//
//  Created by zhangbin on 11/11/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "JAFHTTPClient.h"
#import "Contact.h"
#import "ContactDetailsTableViewController.h"

@interface ContactsTableViewController () <UISearchBarDelegate>

@property (readwrite) NSArray *contacts;
@property (readwrite) UISearchBar *searchBar;
@property (readwrite) NSUInteger page;
@property (readwrite) BOOL noMore;

@end

@implementation ContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = NSLocalizedString(@"公司通讯录", nil);
	_page = 1;
	[self loadContacts:nil page:_page];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadContacts:(NSString *)queryString page:(NSUInteger)page
{
	[self displayHUD:@"加载中..."];
	[[JAFHTTPClient shared] contacts:queryString page:page pagesize:@"20" withBlock:^(NSArray *multiAttributes, NSError *error) {
		[self hideHUD:YES];
		if (!error) {
			if (multiAttributes.count > 0) {
				NSArray *tmp = [Contact multiWithAttributesArray:multiAttributes];
				NSMutableArray *all = [NSMutableArray array];
				if (tmp.count) {
					[all addObjectsFromArray:tmp];
				}
				if (_contacts.count) {
					[all addObjectsFromArray:_contacts];
				}
				_contacts = [NSArray arrayWithArray:all];
				[self.tableView reloadData];
			} else {
				_noMore = YES;
			}
		}
	}];
}

- (void)loadMore
{
	if (_noMore) {
		[self displayHUDTitle:NSLocalizedString(@"已经显示全部", nil) message:nil duration:0.3];
		return;
	}
	_page++;
	if (_searchBar.text.length > 0) {
		[self loadContacts:_searchBar.text page:_page];
	} else {
		[self loadContacts:nil page:_page];
	}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contacts.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (!_searchBar) {
		_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
		_searchBar.placeholder = @"请搜索中文名，英文名，部门";
		_searchBar.delegate = self;
	}
	return _searchBar;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
	}
	cell.imageView.image = [UIImage imageFromColor:[UIColor redColor]];
	Contact *contact = _contacts[indexPath.row];
	cell.imageView.image = [UIImage imageNamed:@"user_head"];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.personName ?: @"", contact.englishName ?: @""];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", contact.companyPosition ?: @"", contact.companyDepartment ?: @""];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ContactDetailsTableViewController *contactDetailsTableViewController = [[ContactDetailsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	contactDetailsTableViewController.contact = _contacts[indexPath.row];
	[self.navigationController pushViewController:contactDetailsTableViewController animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[_searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
	if (searchBar.text.length) {
		_page = 1;
		_contacts = [NSArray array];
		[self.tableView reloadData];
		[self loadContacts:searchBar.text page:_page];
	}
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
	if (endScrolling >= scrollView.contentSize.height - 10) {
		[self loadMore];
	}
}

@end
