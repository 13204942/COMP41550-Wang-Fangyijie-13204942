//
//  ViewAccountVC.h
//  MyAccount
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAccountVC : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *todayWeekMonth;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSFetchedResultsController *setupFetchedResultsController;

@end
