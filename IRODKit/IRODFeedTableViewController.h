//
//  IRODFeedTableViewController.h
//  IRODKit
//
//  Created by Evadne Wu on 9/25/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRODFeedViewController.h"

@interface IRODFeedTableViewController : IRODFeedViewController

@property (nonatomic, readonly, retain) UITableView *tableView;
@property (nonatomic, readwrite, copy) void (^onSelection)(NSIndexPath *rowIndexPath, NSString *selectedKey, NSString *selectedValue);

@end
