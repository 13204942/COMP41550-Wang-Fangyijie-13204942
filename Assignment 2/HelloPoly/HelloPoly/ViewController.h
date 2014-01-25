//
//  ViewController.h
//  HelloPoly
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShapeFile.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *numberOfSidesLabel;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property (strong, nonatomic) PolygonShape *model;
@property (assign, nonatomic) NSUInteger numberOfSides;
- (IBAction)decrease:(UIButton *)sender;
- (IBAction)increase:(UIButton *)sender;

@end
