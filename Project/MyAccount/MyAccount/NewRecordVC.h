//
//  NewRecordVC.h
//  MyAccount
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NewRecordVC : UIViewController <UITextViewDelegate, UITextFieldDelegate>
{
    IBOutlet UISegmentedControl *choices;
    IBOutlet UITextField *entertitle;
    IBOutlet UITextField *enterprice;
    IBOutlet UILabel *entertime;
    IBOutlet UITextView *enterdescription;
    IBOutlet UIButton *save;
    IBOutlet UITapGestureRecognizer *clickBackground;
//    IBOutlet UITapGestureRecognizer *clickTextVIew;
    
    AppDelegate *myDelegate;
}

@property (strong, nonatomic) UISegmentedControl *choices;
@property (strong, nonatomic) UITextField *entertitle;
@property (strong, nonatomic) UITextField *enterprice;
@property (strong, nonatomic) UILabel *entertime;
@property (strong, nonatomic) UITextView *enterdescription;
@property (strong, nonatomic) AppDelegate *myDelegate;

@property (strong, nonatomic) NSString *scanResult;


- (IBAction)clickedBackground;
- (IBAction)save:(UIButton *)sender;
- (IBAction)clean:(UIButton *)sender;

- (void)createTextView;

@end
