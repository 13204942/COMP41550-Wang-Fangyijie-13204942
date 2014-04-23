//
//  DebtVC.h
//  MyAccount
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebtVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *debtRecords;

@end
