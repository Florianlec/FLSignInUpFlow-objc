//
//  UIViewController+Helper.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "UIViewController+Helper.h"

@implementation UIViewController (Helper)

+ (UIViewController *)signUpErrorViewController {
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FLSignInUpErrorViewController"];
}

@end
