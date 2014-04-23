//
//  ViewDetailVC.m
//  MyAccount
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import "ViewDetailVC.h"
#import "AllRecordsVC.h"
#import "DateOperation.h"
#import "Record.h"


@interface ViewDetailVC ()

@end

@implementation ViewDetailVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setSingleRecordTime:(NSDate *)singleRecordTime
{
    _singleRecordTime = singleRecordTime;
    
    if (!_singleRecordTime) {
        NSLog(@"fail to get this record's time.");
    }
}

- (void)setSingleRecordTitle:(NSString *)singleRecordTitle
{
    _singleRecordTitle = singleRecordTitle;
    
    if (!_singleRecordTitle) {
        NSLog(@"fail to get this record's title.");
    }
}

- (void)setSingleRecordMoney:(NSNumber *)singleRecordMoney
{
    _singleRecordMoney = singleRecordMoney;
    
    if (!_singleRecordMoney) {
        NSLog(@"fail to get this record's money.");
    }
}

- (void)setSingleRecordDescription:(NSString *)singleRecordDescription
{
    _singleRecordDescription = singleRecordDescription;
    
    if (!_singleRecordDescription) {
        NSLog(@"fail to get this record's detail.");
    }
}

- (void)cannotEditTextField
{
    recordTitle.enabled = NO;
    recordMoney.enabled = NO;
    recordTime.enabled = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self cannotEditTextField];
    
    recordTime.text = [DateOperation convertTime:_singleRecordTime];
    
    double money = [_singleRecordMoney doubleValue];
    
    if ((money > 0.00) || (money == 0.00)) {
        recordMoney.text = [_singleRecordMoney stringValue];
        recordMoney.textColor = [UIColor colorWithRed:39.0f/255.0
                                               green:224.0f/255.0
                                                blue:14.0f/255.0
                                               alpha:1];
    }else
    {
        double positiveMoney = 0.00 - money;

        _singleRecordMoney = [NSNumber numberWithDouble:positiveMoney];
        recordMoney.text = [_singleRecordMoney stringValue];
        recordMoney.textColor = [UIColor colorWithRed:255.0f/255.0
                                               green:72.0f/255.0
                                                blue:1.0f/255.0
                                               alpha:1];
    }
    
    recordTitle.text = _singleRecordTitle;
    description.text = _singleRecordDescription;
    
    description.backgroundColor = [UIColor colorWithRed:255.0f/255.0
                                                  green:255.0f/255.0
                                                   blue:240.0f/255.0
                                                  alpha:1];
    description.font = [UIFont fontWithName:@"System" size:18];
    
    [description.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [description.layer setBorderWidth:0.8];
    [description.layer setCornerRadius:5.0f];
    [description.layer setMasksToBounds:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)automaticallyAdjustsScrollViewInsets
{
    return NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
