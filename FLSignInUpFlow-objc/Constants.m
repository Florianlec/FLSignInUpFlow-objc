//
//  Constants.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const kFLLoginVCLoginSegue = @"loginSegue";
NSString *const kFLLoginVCSignupSegue = @"signupSegue";

NSString *const kFLSignInUpVCReloadItemsNotification = @"SignInUpReloadItems";

NSString *const kFLSignInUpViewModelEmail = @"email";
NSString *const kFLSignInUpViewModelPassword = @"password";
NSString *const kFLSignInUpViewModelFirstName = @"first_name";
NSString *const kFLSignInUpViewModelLastName = @"last_name";

NSString *const kFLSignInUpViewItemStandardCell = @"FLSignInUpStandardCell";
NSString *const kFLSignInUpViewItemSocialCell = @"FLSignInUpSocialCell";
NSString *const kFLSignInUpViewItemButtonCell = @"FLSignInUpButtonCell";

NSString *const kFLSignInUpViewControllerReloadItemsNotification = @"SignInUpReloadItems";
@end
