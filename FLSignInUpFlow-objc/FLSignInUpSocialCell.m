//
//  FLSignInUpSocialCell.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLSignInUpSocialCell.h"

@interface FLSignInUpSocialCell ()

@property (nonatomic, weak) IBOutlet UIButton *facebookButton;
@property (nonatomic, weak) IBOutlet UIButton *googleButton;

@end

@implementation FLSignInUpSocialCell

#pragma mark -
#pragma mark - Public Methods
#pragma mark -

- (void)performWithItem:(FLSignInUpViewItem *)item {
    self.item = item;
    self.facebookButton.titleLabel.font = [UIFont fontWithName:self.facebookButton.titleLabel.font.fontName size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    self.googleButton.titleLabel.font = [UIFont fontWithName:self.googleButton.titleLabel.font.fontName size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
}

#pragma mark -
#pragma mark - IBActions Methods
#pragma mark -

- (IBAction)facebookTouchUpInside:(id)sender {
    [[FLSignInUpViewModel sharedInstance] facebookSSO];
}

- (IBAction)googleTouchUpInside:(id)sender {
    [[FLSignInUpViewModel sharedInstance] googleSSO];
}

@end
