//
//  FLSignInUpViewModel.h
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLSignInUpViewItem.h"

#pragma mark -
#pragma mark - FLSignInUpViewModel Blocks
#pragma mark -

typedef void(^Block)(NSMutableDictionary *items);
typedef void(^FieldValidatorBlock)(BOOL isValid, NSString *errorMessage, FLSignInUpViewItem *item);

#pragma mark -
#pragma mark - FLSignInUpViewModelProtocol Methods
#pragma mark -

@protocol FLSignInUpViewModelProtocol <NSObject>
- (void)fieldBecomeFirstResponder:(NSIndexPath *)indexPath;
@end

#pragma mark -
#pragma mark - FLSignInUpViewModel Class
#pragma mark -

@interface FLSignInUpViewModel : NSObject
@property (nonatomic, weak) id <FLSignInUpViewModelProtocol> delegate;
@property (nonatomic) BOOL isSignUp;
@property (nonatomic, strong) NSMutableDictionary *sections;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableDictionary *errors;
@property (nonatomic) Block block;

+ (FLSignInUpViewModel *)sharedInstance;
- (void)itemsBySections:(Block)block;
- (void)login;
- (void)signup;
- (void)resetAttributes;
- (void)facebookSSO;
- (void)googleSSO;
- (void)forgotYourPassword;
- (void)checkEmail:(FieldValidatorBlock)block;
- (void)checkPassword:(FieldValidatorBlock)block;
@end
