//
//  FLLoginViewController.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLLoginViewController.h"
#import "FLSignInUpViewModel.h"
#import "Constants.h"

@interface FLLoginViewController ()

@end

@implementation FLLoginViewController

#pragma mark -
#pragma mark - UIViewController Methods
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kFLLoginVCLoginSegue]) {
        [FLSignInUpViewModel sharedInstance].isSignUp = false;
    } else if ([segue.identifier isEqualToString:kFLLoginVCSignupSegue]) {
        [FLSignInUpViewModel sharedInstance].isSignUp = true;
    }
}
@end
