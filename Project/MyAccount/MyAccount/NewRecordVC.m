//
//  NewRecordVC.m
//  MyAccount
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import "NewRecordVC.h"
#import "DateOperation.h"
#import "ScanCodeVC.h"

@interface NewRecordVC ()

@end

@implementation NewRecordVC

@synthesize choices;
@synthesize enterprice;
@synthesize entertime;
@synthesize entertitle;
@synthesize enterdescription;
@synthesize myDelegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
    return YES;
}



#pragma mark initialize scanResult

- (void)setScanResult:(NSString *)scanResult
{
    _scanResult = scanResult;
    
    if (!_scanResult) {
        NSLog(@"Fail to get result after scanning!");
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [entertime setText:[DateOperation getCurrentTime]];
    
    enterprice.textColor = [UIColor colorWithRed:255.0f/255.0
                                           green:72.0f/255.0
                                            blue:1.0f/255.0
                                           alpha:1];
    
    enterprice.keyboardType = UIKeyboardTypeDecimalPad;
    
//    if (_scanResult) {
//        entertitle.text = _scanResult;
//    }else
//    {
        entertitle.placeholder = NSLocalizedString(@"title", @" ");
//    }

    enterprice.placeholder = NSLocalizedString(@"00.00", @" ");
    
    [self createTextView];

}

#pragma mark set UITextView

- (void)createTextView
{
    enterdescription.textColor = [UIColor lightGrayColor];
    enterdescription.text = @"Record's description";
    
    [enterdescription.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [enterdescription.layer setBorderWidth:0.8];
    [enterdescription.layer setCornerRadius:5.0f];
    [enterdescription.layer setMasksToBounds:YES];
}




- (IBAction)addTitle:(UIStoryboardSegue *)segue
{
    if ([segue.sourceViewController isKindOfClass:[ScanCodeVC class]]) {
        ScanCodeVC *scancode = (ScanCodeVC *)segue.sourceViewController;
        NSString *scanString = scancode.scanResult;
        if (scanString) {
            entertitle.text = scanString;
        }else
        {
            NSLog(@"ScanCodeVC cannot work successfully");
        }
    }
}




#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    enterdescription.text = @"";
    enterdescription.textColor = [UIColor blackColor];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (enterdescription.text.length == 0) {
        enterdescription.textColor = [UIColor lightGrayColor];
        enterdescription.text = @"Record's description";
        [enterdescription resignFirstResponder];
    }
}



- (IBAction)clickedBackground
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(UIButton *)sender
{
    UIAlertView *saveAlert = [[UIAlertView alloc] initWithTitle:@"Save"
                                                        message:@"Save Successfully."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.myDelegate.managedObjectContext];
    
    [object setValue:entertitle.text forKey:@"title"];
    [object setValue:[NSDate date] forKey:@"time"];
    [object setValue:[DateOperation dayOfToday] forKey:@"daydate"];
   
//    NSNumberFormatter *priceFormatter = [[NSNumberFormatter alloc] init];
//    [priceFormatter setPositiveFormat:@"%.02f%%"];
//    [priceFormatter setPositiveFormat:@"#,##0.00"];
    
    
    NSString *stringenterprice = enterprice.text;
    double enterpricedouble = (double)[stringenterprice doubleValue];
    
    NSString *midstring = [NSString stringWithFormat:@"%.02f",enterpricedouble];
//    NSString *midstring = [priceFormatter stringFromNumber:[NSNumber numberWithDouble:enterpricedouble]];
    
    
    if (![stringenterprice isEqual:midstring]) {
        UIAlertView *changePriceFormat = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                    message:@"Your price is not with the correct format."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Back"
                                                          otherButtonTitles:nil, nil];
        [changePriceFormat show];
    }else
    {
        
        double correctenterpricedouble = (double)[midstring doubleValue];
        
        
        if (choices.selectedSegmentIndex == 0) {
            [object setValue:[NSNumber numberWithDouble: correctenterpricedouble] forKey:@"money"];
        }else
        {
            double correctenterprice = 0.0 - correctenterpricedouble;
            [object setValue:[NSNumber numberWithDouble: correctenterprice] forKey:@"money"];
        }
        
        
        [object setValue:enterdescription.text forKey:@"detail"];
        
        [self.myDelegate saveContext];
        
        [saveAlert show];
        
        save.hidden = YES;
    }

}

- (IBAction)clean:(UIButton *)sender
{
    enterprice.text = nil;
    enterdescription.text = nil;
    entertitle.text = nil;
    entertime.text = nil;
    
}

- (IBAction)choose:(UISegmentedControl *)sender
{
    if (choices.selectedSegmentIndex == 0) {
        enterprice.textColor = [UIColor colorWithRed:39.0f/255.0
                                               green:224.0f/255.0
                                                blue:14.0f/255.0
                                               alpha:1];
    }else
    {
        enterprice.textColor = [UIColor colorWithRed:255.0f/255.0
                                               green:72.0f/255.0
                                                blue:1.0f/255.0
                                               alpha:1];
    }
}




#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
