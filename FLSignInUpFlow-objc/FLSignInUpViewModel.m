    //
//  FLSignInUpViewModel.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLSignInUpViewModel.h"
#import "Constants.h"
#import "SVProgressHUD.h"
#import "NSString+Helper.h"

@implementation FLSignInUpViewModel

#pragma mark -
#pragma mark - Static Methods
#pragma mark -

static FLSignInUpViewModel *_sharedInstance;

+ (FLSignInUpViewModel *)sharedInstance {
    static dispatch_once_t onceToken;
    
    if(_sharedInstance) return _sharedInstance;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [FLSignInUpViewModel hiddenAlloc];
        _sharedInstance = [_sharedInstance init];
    });
    
    return _sharedInstance;
}

+ (id)hiddenAlloc {
    return [super allocWithZone:NULL];
}

#pragma mark -
#pragma mark - Init Methods
#pragma mark -

- (id)init {
    if (self = [super init]) {
        self.sections = [NSMutableDictionary new];
        self.params = [NSMutableDictionary new];
        self.errors = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark -
#pragma mark - Public Methods
#pragma mark -

- (void)itemsBySections:(Block)block {
    if (!self.isSignUp) {
        self.sections = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                        @"0" : @[
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                                                         title:NSLocalizedString(@"Email", @"")
                                                                                                                           key:kFLSignInUpViewModelEmail
                                                                                                                         value:self.params[kFLSignInUpViewModelEmail] != nil ? self.params[kFLSignInUpViewModelEmail] : @""
                                                                                                                   detailTitle:NSLocalizedString(@"example@email.com", @"")
                                                                                                                         error:self.errors[kFLSignInUpViewModelEmail] != nil ? self.errors[kFLSignInUpViewModelEmail] : @""],
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                                                         title:NSLocalizedString(@"Password", @"")
                                                                                                                           key:kFLSignInUpViewModelPassword
                                                                                                                         value:self.params[kFLSignInUpViewModelPassword] != nil ? self.params[kFLSignInUpViewModelPassword] : @""
                                                                                                                   detailTitle:NSLocalizedString(@"At least 8 characters", @"")
                                                                                                                         error:self.errors[kFLSignInUpViewModelPassword] != nil ? self.errors[kFLSignInUpViewModelPassword] : @""]
                                                                                ],
                                                                        @"1" : @[
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemButtonCell
                                                                                                                         title:NSLocalizedString(@"Forgot your password?", @"")
                                                                                                                           key:@""
                                                                                                                         value:@""
                                                                                                                   detailTitle:@""
                                                                                                                         error:@""]
                                                                                ],
                                                                        @"2" : @[
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemButtonCell
                                                                                                                         title:NSLocalizedString(@"Login", @"")
                                                                                                                           key:@""
                                                                                                                         value:@""
                                                                                                                   detailTitle:@""
                                                                                                                         error:@""]
                                                                                ],
                                                                        @"3" : @[
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemSocialCell
                                                                                                                         title:@""
                                                                                                                           key:@""
                                                                                                                         value:@""
                                                                                                                   detailTitle:@""
                                                                                                                         error:@""]
                                                                                ]}];
    } else {
        self.sections = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                        @"0" : @[
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                                                         title:NSLocalizedString(@"Email", @"")
                                                                                                                           key:kFLSignInUpViewModelEmail
                                                                                                                         value:self.params[kFLSignInUpViewModelEmail] != nil ? self.params[kFLSignInUpViewModelEmail] : @""
                                                                                                                   detailTitle:NSLocalizedString(@"example@email.com", @"")
                                                                                                                         error:self.errors[kFLSignInUpViewModelEmail] != nil ? self.errors[kFLSignInUpViewModelEmail] : @""],
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                                                         title:NSLocalizedString(@"Password", @"")
                                                                                                                           key:kFLSignInUpViewModelPassword
                                                                                                                         value:self.params[kFLSignInUpViewModelPassword] != nil ? self.params[kFLSignInUpViewModelPassword] : @""
                                                                                                                   detailTitle:NSLocalizedString(@"At least 8 characters", @"")
                                                                                                                         error:self.errors[kFLSignInUpViewModelPassword] != nil ? self.errors[kFLSignInUpViewModelPassword] : @""],
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                                                         title:NSLocalizedString(@"First Name", @"")
                                                                                                                           key:kFLSignInUpViewModelFirstName
                                                                                                                         value:self.params[kFLSignInUpViewModelFirstName] != nil ? self.params[kFLSignInUpViewModelFirstName] : @""
                                                                                                                   detailTitle:@""
                                                                                                                         error:self.errors[kFLSignInUpViewModelFirstName] != nil ? self.errors[kFLSignInUpViewModelFirstName] : @""],
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                                                         title:NSLocalizedString(@"Last Name", @"")
                                                                                                                           key:kFLSignInUpViewModelLastName
                                                                                                                         value:self.params[kFLSignInUpViewModelLastName] != nil ? self.params[kFLSignInUpViewModelLastName] : @""
                                                                                                                   detailTitle:@""
                                                                                                                         error:self.errors[kFLSignInUpViewModelLastName] != nil ? self.errors[kFLSignInUpViewModelLastName] : @""]
                                                                                ],
                                                                        @"1" : @[
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemButtonCell
                                                                                                                         title:NSLocalizedString(@"Signup", @"")
                                                                                                                           key:@""
                                                                                                                         value:@""
                                                                                                                   detailTitle:@""
                                                                                                                         error:@""]
                                                                                ],
                                                                        @"2" : @[
                                                                                [[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemSocialCell
                                                                                                                         title:@""
                                                                                                                           key:@""
                                                                                                                         value:@""
                                                                                                                   detailTitle:@""
                                                                                                                         error:@""]
                                                                                ]
                                                                        }];
    }
    self.block = block;
    block(self.sections);
}

- (void)resetAttributes {
    self.block = nil;
    self.params = [NSMutableDictionary new];
    self.errors = [NSMutableDictionary new];
    self.sections = [NSMutableDictionary new];
}

- (void)login {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Login Success", @"")];
    NSLog(@"perform login through the Web API");
}

- (void)signup {
    if (self.delegate != nil) {
        [self checkEmail:^(BOOL isValid, NSString *errorMessage, FLSignInUpViewItem *item) {
            if (!isValid) {
                [self.delegate fieldBecomeFirstResponder:[NSIndexPath indexPathForRow:0 inSection:0]];
            } else {
                [self checkPassword:^(BOOL isValid, NSString *errorMessage, FLSignInUpViewItem *item) {
                    if (!isValid) {
                        [self.delegate fieldBecomeFirstResponder:[NSIndexPath indexPathForRow:1 inSection:0]];
                    } else {
                        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
                        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Signup Success", @"")];
                        NSLog(@"perform signup through the Web API");
                    }
                }];
            }
        }];
    }
}

- (void)facebookSSO {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Facebook SSO", @"")];
    NSLog(@"perform facebook SSO");
}

- (void)googleSSO {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Google SSO", @"")];
    NSLog(@"perform google SSO");
}

- (void)forgotYourPassword {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Forgot password action", @"")];
    NSLog(@"display forgot password view controller");
}

#pragma mark -
#pragma mark - Field Validator Methods
#pragma mark -

- (void)checkEmail:(FieldValidatorBlock)block {
    NSString *email = self.params[kFLSignInUpViewModelEmail];
    if (email != nil && email.length > 0) {
        email = [email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self.errors setValue:nil forKey:kFLSignInUpViewModelEmail];
        NSString *errorMessage = @"";
        BOOL isValid = true;
        if (self.isSignUp) {
            if ([email containsString:@"@"]) {
                if ([email isValidEmail] == false) {
                    if ([email length] > 0) {
                        isValid = false;
                        errorMessage = NSLocalizedString(@"Invalid email address", @"");
                        [self.errors setValue:errorMessage forKey:kFLSignInUpViewModelEmail];
                    }
                }
            } else {
                if ([email length] > 0) {
                    isValid = false;
                    errorMessage = NSLocalizedString(@"Invalid email address", @"");
                    [self.errors setValue:errorMessage forKey:kFLSignInUpViewModelEmail];
                }
            }
        }
        [self p_updateEmailItem];
        block(isValid, errorMessage, self.sections[@"0"][0]);
    }
}

- (void)checkPassword:(FieldValidatorBlock)block {
    NSString *password = self.params[kFLSignInUpViewModelPassword];
    if (password != nil) {
        [self.errors setValue:nil forKey:kFLSignInUpViewModelPassword];
        NSString *errorMessage = @"";
        BOOL isValid = true;
        if (self.isSignUp) {
            if (password.length > 0 && password.length < 8) {
                isValid = false;
                errorMessage = NSLocalizedString(@"At least 8 characters", @"");
                [self.errors setValue:errorMessage forKey:kFLSignInUpViewModelPassword];
            }
        }
        [self p_updatePasswordItem];
        block(isValid, errorMessage, self.sections[@"0"][1]);
    }
}

#pragma mark -
#pragma mark - Private Methods
#pragma mark -

- (void)p_updateEmailItem {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.sections[@"0"]];
    [array replaceObjectAtIndex:0 withObject:[[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                      title:NSLocalizedString(@"Email", @"")
                                                                                        key:kFLSignInUpViewModelEmail
                                                                                      value:self.params[kFLSignInUpViewModelEmail] != nil ? self.params[kFLSignInUpViewModelEmail] : @""
                                                                                detailTitle:NSLocalizedString(@"example@email.com", @"")
                                                                                      error:self.errors[kFLSignInUpViewModelEmail] != nil ? self.errors[kFLSignInUpViewModelEmail] : @""]];
    self.sections[@"0"] = array;
}

- (void)p_updatePasswordItem {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.sections[@"0"]];
    [array replaceObjectAtIndex:1 withObject:[[FLSignInUpViewItem alloc] initWithIdentifier:kFLSignInUpViewItemStandardCell
                                                                                      title:NSLocalizedString(@"Password", @"")
                                                                                        key:kFLSignInUpViewModelPassword
                                                                                      value:self.params[kFLSignInUpViewModelPassword] != nil ? self.params[kFLSignInUpViewModelPassword] : @""
                                                                                detailTitle:NSLocalizedString(@"At least 8 characters", @"")
                                                                                      error:self.errors[kFLSignInUpViewModelPassword] != nil ? self.errors[kFLSignInUpViewModelPassword] : @""]];
    self.sections[@"0"] = array;
}

@end
