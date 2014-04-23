//
//  CoreDataTableTableViewController.h
//  MyAccount
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property BOOL debug;

- (void)performFetch;

@end