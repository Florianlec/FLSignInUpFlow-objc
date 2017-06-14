//
//  Constants.h
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#pragma mark - FLLoginViewController Constants
extern NSString *const kFLLoginVCLoginSegue;
extern NSString *const kFLLoginVCSignupSegue;

#pragma mark - FLSignInUpViewController Constants
extern NSString *const kFLSignInUpVCReloadItemsNotification;

#pragma mark - FLSignInUpViewModel Constants
extern NSString *const kFLSignInUpViewModelEmail;
extern NSString *const kFLSignInUpViewModelPassword;
extern NSString *const kFLSignInUpViewModelFirstName;
extern NSString *const kFLSignInUpViewModelLastName;

#pragma mark - FLSignInUpViewItem Constants
extern NSString *const kFLSignInUpViewItemStandardCell;
extern NSString *const kFLSignInUpViewItemSocialCell;
extern NSString *const kFLSignInUpViewItemButtonCell;

#pragma mark - FLSignInUpViewController Constants
extern NSString *const kFLSignInUpViewControllerReloadItemsNotification;

@end
