//
//  PeriodRecordsVC.h
//  MyAccount
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllRecordsVC.h"
#import "Record.h"
#import "DateOperation.h"
#import "ViewDetailVC.h"

@interface PeriodRecordsVC : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    IBOutlet UITextField *balanceText;
    
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *periodRecords;
@property (strong, nonatomic) AllRecordsVC *allRecords;
@property (strong, nonatomic) IBOutlet UILabel *topLabel;

@property (strong, nonatomic) NSString *selectedTime;

@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSFetchedResultsController *fetchRecords;

@end
