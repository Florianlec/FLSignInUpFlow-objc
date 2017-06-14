//
//  FLSignInUpButtonCell.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLSignInUpButtonCell.h"

@interface FLSignInUpButtonCell ()

@property (nonatomic, weak) IBOutlet UIButton *button;

@end

@implementation FLSignInUpButtonCell

#pragma mark -
#pragma mark - Public Methods
#pragma mark -

- (void)performWithItem:(FLSignInUpViewItem *)item {
    self.item = item;
    self.button.titleLabel.font = [UIFont fontWithName:self.button.titleLabel.font.fontName size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    [self.button setTitle:self.item.title forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark - IBActions
#pragma mark -

- (IBAction)buttonTouchUpInside:(id)sender {
    if ([self.item.title isEqualToString:NSLocalizedString(@"Login", @"")]) {
        [[FLSignInUpViewModel sharedInstance] login];
    } else if ([self.item.title isEqualToString:NSLocalizedString(@"Signup", @"")]) {
        [[FLSignInUpViewModel sharedInstance] signup];
    } else if ([self.item.title isEqualToString:NSLocalizedString(@"Forgot your password?", @"")]) {
        [[FLSignInUpViewModel sharedInstance] forgotYourPassword];
    }
}

@end
