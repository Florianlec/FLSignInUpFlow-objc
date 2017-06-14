//
//  FLSignInUpAbstractCell.h
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLSignInUpViewItem.h"
#import "FLSignInUpAccessoryView.h"
#import "FLSignInUpViewModel.h"
#import "UIViewController+Helper.h"
#import "Constants.h"

#pragma mark -
#pragma mark - FLSignInUpAbstractCellProtocol Methods
#pragma mark -

@protocol FLSignInUpAbstractCellProtocol <NSObject>
- (void)nextTouchUpInside:(NSIndexPath *)indexPath;
@end

#pragma mark -
#pragma mark - FLSignInUpAbstractCell Class
#pragma mark -

@interface FLSignInUpAbstractCell : UITableViewCell
@property (nonatomic, weak) id <FLSignInUpAbstractCellProtocol> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) FLSignInUpViewItem *item;
@property (nonatomic, strong) FLSignInUpAccessoryView *errorView;

- (void)performWithItem:(FLSignInUpViewItem *)item;
- (void)textFieldBecomeFirstResponder;

@end
