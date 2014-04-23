//
//  BarChartView.h
//  MyAccount
//
//  Created by apple on 14-4-18.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarChartView : UIView

@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic) float maxValue;
@property (nonatomic, strong) NSMutableArray *textIndicators;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic) float barHeight;
@property (nonatomic) float barMaxWidth;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGGradientRef gradient;

- (id)initWithFrame:(CGRect)frame
         startPoint:(CGPoint)startPoint
             values:(NSMutableArray *)values
           maxValue:(float)maxValue
     textIndicators:(NSMutableArray *)textIndicators
          textColor:(UIColor *)textColor
          barHeight:(float)barHeight
        barMaxWidth:(float)barMaxWidth
           gradient:(CGGradientRef)gradient;

- (void)reloadInputViews;

@end
