//
//  ScanCodeVC.m
//  MyAccount
//
//  Created by apple on 14-4-18.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import "ScanCodeVC.h"
#import "NewRecordVC.h"
#define UNWIND_SEGUE_IDENTIFIER @"DoScan"

@interface ScanCodeVC ()

@end

@implementation ScanCodeVC
@synthesize resultImage;
@synthesize resultText;
//@synthesize finishScanning;
@synthesize cancelScan;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    resultText.text = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:UNWIND_SEGUE_IDENTIFIER]) {
        self.scanResult = self.resultText.text;
        if (!self.scanResult) {
            NSLog(@"No results from scanning");
        }
    }
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:UNWIND_SEGUE_IDENTIFIER]) {
        if (![self.resultText.text length]) {
            UIAlertView *scanAlert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"No result scanned."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Try Again"
                                                  otherButtonTitles:nil, nil];
            [scanAlert show];
            return NO;
        }else
        {
            return YES;
        }
    }else
    {
        return [super shouldPerformSegueWithIdentifier:identifier sender:sender];
    }
    
}


- (IBAction)cancel
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark onClickButton

- (IBAction)scanButtonTapped
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    [self presentViewController: reader
                       animated: YES
                     completion: nil];

}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSLog(@"===%@",symbol.data);
    resultText.text = symbol.data;
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    [reader dismissViewControllerAnimated: YES
                               completion: nil];
}


#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"Finish Scan"]) {
        
        NewRecordVC *newRecord = [segue destinationViewController];
        newRecord.scanResult = resultText.text;
    }
}
*/

@end
