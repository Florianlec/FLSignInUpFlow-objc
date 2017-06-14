//
//  FLSignInUpViewController.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLSignInUpViewController.h"
#import "FLSignInUpViewModel.h"
#import "FLSignInUpAbstractCell.h"
#import "Constants.h"

@interface FLSignInUpViewController () <UITableViewDelegate, UITableViewDataSource, FLSignInUpAbstractCellProtocol, FLSignInUpViewModelProtocol>

@end

@implementation FLSignInUpViewController

#pragma mark -
#pragma mark - UIViewController Methods
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [FLSignInUpViewModel sharedInstance].delegate = self;
    [self p_manageTableViewItems];
    self.navigationItem.title = [FLSignInUpViewModel sharedInstance].isSignUp ? NSLocalizedString(@"Create an account", @"") : NSLocalizedString(@"Login", @"");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_manageTableViewItems)
                                                 name:kFLSignInUpVCReloadItemsNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kFLSignInUpVCReloadItemsNotification object:nil];
    [[FLSignInUpViewModel sharedInstance] resetAttributes];
}

#pragma mark -
#pragma mark - Private Methods
#pragma mark -

- (void)p_manageTableViewItems {
    [[FLSignInUpViewModel sharedInstance] itemsBySections:^(NSMutableDictionary *items) {
        [self.tableView reloadData];
    }];
}

#pragma mark -
#pragma mark - UITableViewDelegate Methods
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

#pragma mark -
#pragma mark - UITableViewDataSource Methods
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[FLSignInUpViewModel sharedInstance].sections[[NSString stringWithFormat:@"%ld", (long)section]] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[FLSignInUpViewModel sharedInstance] sections].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FLSignInUpViewItem *item = [FLSignInUpViewModel sharedInstance].sections[[NSString stringWithFormat:@"%ld", (long)indexPath.section]][indexPath.row];
    FLSignInUpAbstractCell *cell = [tableView dequeueReusableCellWithIdentifier:item.identifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell performWithItem:item];
    return cell;
}

#pragma mark -
#pragma mark - FLSignInUpAbstractCellProtocol Methods
#pragma mark -

- (void)nextTouchUpInside:(NSIndexPath *)indexPath {
    FLSignInUpAbstractCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]];
    [nextCell textFieldBecomeFirstResponder];
}

#pragma mark -
#pragma mark - FLSignInUpAbstractCellProtocol Methods
#pragma mark -

- (void)fieldBecomeFirstResponder:(NSIndexPath *)indexPath {
    FLSignInUpAbstractCell *nextCell = [self.tableView cellForRowAtIndexPath:indexPath];
    [nextCell textFieldBecomeFirstResponder];
}

@end
