//
//  ViewDetailVC.h
//  MyAccount
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewDetailVC : UIViewController <NSFetchedResultsControllerDelegate, UITextViewDelegate>
{
    IBOutlet UITextField *recordTitle;
    IBOutlet UITextField *recordTime;
    IBOutlet UITextField *recordMoney;
    IBOutlet UITextView *description;
    
    AppDelegate *mydelegate;
}

@property (strong, nonatomic) NSDate *singleRecordTime;
@property (strong, nonatomic) NSString *singleRecordTitle;
@property (strong, nonatomic) NSNumber *singleRecordMoney;
@property (strong, nonatomic) NSString *singleRecordDescription;

@property (strong, nonatomic) NSDictionary *record;

@end
