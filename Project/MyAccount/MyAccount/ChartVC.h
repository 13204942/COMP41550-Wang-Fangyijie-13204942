//
//  ChartVC.h
//  MyAccount
//
//  Created by apple on 14-4-18.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChartVC : UIViewController
{
    AppDelegate *mydelegate;
}


@property (strong, nonatomic) IBOutlet UIScrollView *chartView;
@property (strong, nonatomic) NSManagedObjectContext *context;

- (NSMutableArray *)calculateDayMoney;
- (NSMutableArray *)resultDay;

@end
