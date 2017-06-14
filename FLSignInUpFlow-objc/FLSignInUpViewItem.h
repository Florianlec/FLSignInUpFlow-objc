//
//  FLSignInUpViewItem.h
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark - FLSignInUpViewItem Class
#pragma mark -

@interface FLSignInUpViewItem : NSObject

@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) NSString *value;
@property(nonatomic, copy) NSString *detailTitle;
@property(nonatomic, copy) NSString *error;

- (instancetype)initWithIdentifier:(NSString *)identifier
                             title:(NSString *)title
                               key:(NSString *)key
                             value:(NSString *)value
                       detailTitle:(NSString *)detailTitle
                             error:(NSString *)error;

@end
