//
//  AboutVC.m
//  MyAccount
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()

@end

@implementation AboutVC
@synthesize aboutView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    aboutView.backgroundColor = [UIColor colorWithRed:255.0f/255.0
                                                green:255.0f/255.0
                                                 blue:255.0f/255.0
                                                alpha:1];
    aboutView.font = [UIFont fontWithName:@"System" size:18];
    aboutView.textColor = [UIColor blackColor];
    [aboutView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [aboutView.layer setBorderWidth:0.8];
    [aboutView.layer setCornerRadius:7.0f];
    [aboutView.layer setMasksToBounds:YES];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"American Typewriter" size:17],
      NSFontAttributeName, nil]];
    
# pragma mark set UIView backgroundcolor
    
//    CGRect frame = CGRectMake(0.0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
//    [backgroundView setBackgroundColor:[[UIColor alloc] initWithRed:248./255 green:240./255 blue:193./255 alpha:0.4]];
//    [self.view addSubview:backgroundView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
