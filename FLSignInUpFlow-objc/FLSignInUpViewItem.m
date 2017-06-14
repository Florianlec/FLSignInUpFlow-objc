//
//  FLSignInUpViewItem.m
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import "FLSignInUpViewItem.h"

@implementation FLSignInUpViewItem

#pragma mark -
#pragma mark - Init Method
#pragma mark -

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title key:(NSString *)key value:(NSString *)value detailTitle:(NSString *)detailTitle error:(NSString *)error {
    if (self = [super init]) {
        self.identifier = identifier;
        self.title = title;
        self.key = key;
        self.value = value;
        self.detailTitle = detailTitle;
        self.error = error;
    }
    return self;
}

@end
