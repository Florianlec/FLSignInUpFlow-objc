//
//  NSString+Helper.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

-(BOOL)isValidEmail
{
    if ([self rangeOfString:@".."].location == NSNotFound && [self rangeOfString:@".@"].location == NSNotFound && [self rangeOfString:@"@."].location == NSNotFound) {
        BOOL stricterFilter = NO;
        NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
        NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
        NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        return [emailTest evaluateWithObject:self];
    }
    return NO;
}

@end
