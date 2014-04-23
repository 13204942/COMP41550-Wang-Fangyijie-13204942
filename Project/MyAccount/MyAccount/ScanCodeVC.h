//
//  ScanCodeVC.h
//  MyAccount
//
//  Created by apple on 14-4-18.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ScanCodeVC : UIViewController <ZBarReaderDelegate>
{
    UIImageView *resultImage;
    UITextView *resultText;
    
    UIButton *finishScanning;
    UIButton *cancelScan;
}

@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
//@property (nonatomic, strong) IBOutlet UIButton *finishScanning;
@property (nonatomic, strong) IBOutlet UIButton *cancelScan;

@property (strong, nonatomic) NSString *scanResult;

- (IBAction)scanButtonTapped;

@end
