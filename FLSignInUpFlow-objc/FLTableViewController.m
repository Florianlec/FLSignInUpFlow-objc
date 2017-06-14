//
//  FLTableViewController.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLTableViewController.h"

@interface FLTableViewController ()

@end

@implementation FLTableViewController

#pragma mark -
#pragma mark - Init Methods
#pragma mark -

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

#pragma mark -
#pragma mark - UIViewController Methods
#pragma mark -

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self unregisterForKeyboardNotifications];
}

#pragma mark -
#pragma mark - Private Methods
#pragma mark -

- (void)p_manageTableViewItems {}

#pragma mark -
#pragma mark - Keyboard Notification
#pragma mark -

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
}
- (void)unregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}
- (void)keyboardDidShow:(NSNotification *)aNotification {
    if (self.isKeyboardOpen) return;
    self.isKeyboardOpen = YES;
    CGSize keyboardSize = [aNotification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSNumber *rate = aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [self resizeTableViewWithKeyboardSize:keyboardSize rate:rate];
}
- (void)keyboardWillHide:(NSNotification *)aNotification {
    if (!self.isKeyboardOpen) return;
    self.isKeyboardOpen = NO;
    NSNumber *rate = aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    CGFloat height = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(height, UIEdgeInsetsZero.left, UIEdgeInsetsZero.bottom, UIEdgeInsetsZero.right);
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
    }];
}
- (void)keyboardDidChangeFrame:(NSNotification *)aNotification {
    if (self.isKeyboardOpen) {
        CGSize keyboardSize = [aNotification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        NSNumber *rate = aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        [self resizeTableViewWithKeyboardSize:keyboardSize rate:rate];
    }
}
- (void)didChangePreferredContentSize:(NSNotification *)aNotification {
    [self p_manageTableViewItems];
}
- (void)resizeTableViewWithKeyboardSize:(CGSize)keyboardSize rate:(NSNumber *)rate {
    CGFloat height = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(height, 0.0, keyboardSize.height, 0.0);
    [UIView animateWithDuration:rate.floatValue animations:^{
        self.tableView.contentInset = contentInsets;
        self.tableView.scrollIndicatorInsets = contentInsets;
    }];
}
@end
