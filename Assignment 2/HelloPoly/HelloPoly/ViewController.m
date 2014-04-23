//
//  ViewController.m
//  HelloPoly
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ViewController.h"
#import "PolygonView.h"
#import "PolygonShapeFile.h"

@interface ViewController () <PolygonViewDelegate>
@property (weak, nonatomic) IBOutlet PolygonView *polygonView;
@end

@implementation ViewController

- (PolygonShape *)model {
    if (!_model) {
        _model = [PolygonShape new];
    }
    return _model;
}
- (NSArray *)pointsForPolygonInRect:(CGRect)rect{
    return [self.model pointsForPolygonInRect:rect];
}

- (IBAction)decrease:(UIButton *)sender {
    NSLog(@"I'm in the decrease method");
    self.model.numberOfSides = self.model.numberOfSides - 1;
    [self updateUI];
}

- (IBAction)increase:(UIButton *)sender {
    NSLog(@"I'm in the increase method");
    self.model.numberOfSides = self.model.numberOfSides + 1;
    [self updateUI];
}

- (void)viewDidUnload {
    [self setNumberOfSidesLabel:nil];
    [self setModel:nil];
    [super viewDidUnload];
}

- (void)viewDidLoad {
    self.model.numberOfSides = [self.numberOfSidesLabel.text integerValue];
    NSLog(@"My polygon: %@", self.model.name);
    [super viewDidLoad];
    [self updateUI];
}

- (void)updateUI {
    self.displayLabel.text = self.model.description;
    [self.displayLabel sizeToFit];
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.model.numberOfSides];
    [self.polygonView setNeedsDisplay];
}

@end
