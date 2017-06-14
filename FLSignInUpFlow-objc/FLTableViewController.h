//
//  FLTableViewController.h
//  FLSignInUpFlow-objc
//
//  Created by Florian Lecluse on 6/13/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark - FLTableViewController Class
#pragma mark -

@interface FLTableViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isKeyboardOpen;

@end
