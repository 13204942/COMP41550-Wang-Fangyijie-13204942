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

#define kOFFSET_FOR_KEYBOARD 80.0

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
    
    entertitle.placeholder = NSLocalizedString(@"Title", @" ");
    enterprice.placeholder = NSLocalizedString(@"00.00", @" ");
    
    [self createTextView];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"American Typewriter" size:18],
      NSFontAttributeName, nil]];
    

}




#pragma mark set UITextView

- (void)createTextView
{
    enterdescription.textColor = [UIColor lightGrayColor];
    enterdescription.text = @"Record's description";
    
    [enterdescription.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [enterdescription.layer setBorderWidth:0.8];
    [enterdescription.layer setCornerRadius:7.0f];
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
    
    
    if (!self.myDelegate) {
        UIAlertView *saveFailed = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                             message:@"Fail to save."
                                                            delegate:nil
                                                   cancelButtonTitle:@"Try again"
                                                   otherButtonTitles:nil, nil];
        [saveFailed show];
        
    }else if (![stringenterprice isEqual:midstring])
    {
        myDelegate.managedObjectContext = nil;
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




#pragma mark set UITextView without being hidden when keyboard up

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextView *)sender
{
    if ([sender isEqual:enterdescription])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
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
