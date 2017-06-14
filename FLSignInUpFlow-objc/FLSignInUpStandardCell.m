//
//  FLSignInUpStandardCell.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLSignInUpStandardCell.h"

@interface FLSignInUpStandardCell () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) NSString *textFieldStr;

@end

@implementation FLSignInUpStandardCell

#pragma mark -
#pragma mark - Public Methods
#pragma mark -

- (void)performWithItem:(FLSignInUpViewItem *)item {
    self.item = item;
    self.titleLabel.text = self.item.title;
    self.titleLabel.font = [UIFont fontWithName:self.titleLabel.font.fontName size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    self.textField.font = [UIFont fontWithName:self.textField.font.fontName size:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline].pointSize];
    self.textField.text = self.item.value;
    self.textField.delegate = self;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = self.item.detailTitle;
    self.textField.secureTextEntry = false;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    if ([self.item.key isEqualToString:kFLSignInUpViewModelPassword]) {
        self.textField.secureTextEntry = true;
        self.textField.clearButtonMode = UITextFieldViewModeNever;
    }
    if ([FLSignInUpViewModel sharedInstance].isSignUp == false) {
        self.textField.returnKeyType = UIReturnKeyNext;
        if ([self.item.key isEqualToString:kFLSignInUpViewModelPassword]) self.textField.returnKeyType = UIReturnKeyGo;
    } else  {
        self.textField.returnKeyType = UIReturnKeyNext;
        if ([self.item.key isEqualToString:kFLSignInUpViewModelLastName]) self.textField.returnKeyType = UIReturnKeyGo;
    }
    self.textField.textColor = [UIColor blackColor];
    [self p_dealWithErrorView];
}
- (void)textFieldBecomeFirstResponder {
    [self.textField becomeFirstResponder];
}

#pragma mark -
#pragma mark - Private Methods
#pragma mark -

- (void)p_configureErrorView:(NSString *)message {
    UIViewController *signInUpErrorViewController = [UIViewController signUpErrorViewController];
    self.errorView = (FLSignInUpAccessoryView *)signInUpErrorViewController.view;
    self.errorView.frame = CGRectMake(0, 0, self.bounds.size.width, 30);
    self.errorView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.errorView.errorLabel.text = message;
    [self.textField setInputAccessoryView:self.errorView];
}
- (void)p_removeErrorView {
    [self.textField setInputAccessoryView:nil];
    [self.errorView removeFromSuperview];
}
- (void)p_dealWithErrorView {
    if (self.item.error != nil && self.item.error.length > 0) {
        self.textField.textColor = [self p_errorColor];
        [self p_configureErrorView:self.item.error];
    } else {
        [self p_removeErrorView];
    }
}
- (UIColor *)p_errorColor {
    return [UIColor redColor];
}

#pragma mark -
#pragma mark - UITextFieldDelegate Methods
#pragma mark -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.textFieldStr = textField.text;
    if ([self.textFieldStr isEqualToString:@""]) {
        [[FLSignInUpViewModel sharedInstance].errors setValue:@"" forKey:self.item.key];
    }
    [[FLSignInUpViewModel sharedInstance].errors setValue:self.textFieldStr forKey:self.item.key];
    [self p_removeErrorView];
    if ([self.item.key isEqualToString:kFLSignInUpViewModelEmail]) {
        [[FLSignInUpViewModel sharedInstance] checkEmail:^(BOOL isValid, NSString *errorMessage, FLSignInUpViewItem *item) {
            self.item = item;
            if (isValid == true) {
                [self.textField setTextColor:[UIColor blackColor]];
            } else {
                [self.textField setTextColor:[self p_errorColor]];
            }
        }];
    }
    if ([self.item.key isEqualToString:kFLSignInUpViewModelPassword]) {
        [[FLSignInUpViewModel sharedInstance] checkPassword:^(BOOL isValid, NSString *errorMessage, FLSignInUpViewItem *item) {
            self.item = item;
            if (isValid == true) {
                [self.textField setTextColor:[UIColor blackColor]];
            } else {
                [self.textField setTextColor:[self p_errorColor]];
            }
        }];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textFieldStr = textField.text;
    self.textField.textColor = [UIColor blackColor];
    [self p_dealWithErrorView];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.textField.textColor = [UIColor blackColor];
    [self p_removeErrorView];
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.textFieldStr = newString;
    [[FLSignInUpViewModel sharedInstance].params setValue:newString forKey:self.item.key];
    return true;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return true;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self p_removeErrorView];
    self.textFieldStr = @"";
    [[FLSignInUpViewModel sharedInstance].params setValue:nil forKey:self.item.key];
    [[FLSignInUpViewModel sharedInstance].errors setValue:nil forKey:self.item.key];
    return true;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeyGo) {
        if ([FLSignInUpViewModel sharedInstance].isSignUp) {
            [[FLSignInUpViewModel sharedInstance] signup];
        } else {
            [[FLSignInUpViewModel sharedInstance] login];
        }
    } else {
        [self.delegate nextTouchUpInside:self.indexPath];
    }
    return true;
}

@end
