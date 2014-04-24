//
//  ChartVC.m
//  MyAccount
//
//  Created by apple on 14-4-18.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//


#import "ChartVC.h"
#import "Record.h"
#import "BarChartView.h"

@interface ChartVC()

@end

@implementation ChartVC
@synthesize chartView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSManagedObjectContext *)context
{
    if (!_context)
    {
        _context = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
    }
    return _context;
}


- (void)viewDidLoad
{
    [super loadView];
    
    NSMutableArray *textIndicators = self.resultDay;
    NSMutableArray *values = self.calculateDayMoney;
    NSNumber *max = [values valueForKeyPath:@"@max.self"];
    float floatMax = [max floatValue];
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    BarChartView *barChartView = [[BarChartView alloc] initWithFrame:frame
                                                          startPoint:CGPointMake(7, 20)
                                                              values:values maxValue:floatMax
                                                      textIndicators:textIndicators
                                                           textColor:[UIColor blackColor]
                                                           barHeight:20
                                                         barMaxWidth:205
                                                            gradient:nil];
    [self.view addSubview:chartView];
    [chartView addSubview:barChartView];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"American Typewriter" size:18],
      NSFontAttributeName, nil]];


}


- (NSMutableArray *)resultDay
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record"
                                              inManagedObjectContext:self.context];
    
    
    NSSortDescriptor *recordsDescriptor = [[NSSortDescriptor alloc] initWithKey:@"daydate"
                                                                      ascending:YES];
    NSArray *sortDescriptiors = @[recordsDescriptor];
    
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    [request setSortDescriptors:sortDescriptiors];
    [request setPropertiesToFetch:[NSArray arrayWithObject:@"daydate"]];

    [request setReturnsDistinctResults:YES];

    
    NSArray *resultsString =[self.context executeFetchRequest:request error:nil];
    NSString *stringDay = [[resultsString valueForKey:@"daydate"] componentsJoinedByString:@","];
    NSArray *stringDayArray = [stringDay componentsSeparatedByString:@","];
    NSMutableArray *resultDay = [NSMutableArray arrayWithArray:stringDayArray];
    
    return resultDay;
}


- (NSMutableArray *)calculateDayMoney
{
    NSExpression *ex = [NSExpression expressionForFunction:@"sum:"
                                                 arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"money"]]];
    
    NSExpressionDescription *ed = [[NSExpressionDescription alloc] init];
    [ed setName:@"result"];
    [ed setExpression:ex];
    [ed setExpressionResultType:NSDoubleAttributeType];
    
    NSArray *properties = [NSArray arrayWithObject:ed];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setPropertiesToFetch:properties];
    [request setResultType:NSDictionaryResultType];
    

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record"
                                              inManagedObjectContext:self.context];
    NSAttributeDescription *dateDescription = [entity.attributesByName objectForKey:@"daydate"];
    [request setEntity:entity];
    [request setPropertiesToGroupBy:[NSArray arrayWithObject:dateDescription]];
    
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    NSMutableArray *resultValueArray = [NSMutableArray array];
    
    
    int countNumber = results.count;
    
    
    for (int i = 0; i < countNumber; i = i + 1) {
        

        
        NSDictionary *resultsDictionary = [results objectAtIndex:i];
        NSNumber *resultValue = [resultsDictionary objectForKey:@"result"];
        
        double resultValueDouble = [resultValue doubleValue];
        
        double positiveResultValue = 0.00 - resultValueDouble;
        NSNumber *resultValueNumber = [NSNumber numberWithDouble:positiveResultValue];
        [resultValueArray addObject:resultValueNumber];
        
    }
    
    
    NSError *error = nil;
    if (error != nil)
    {
        //Deal with failure
        UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"An error happened."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [failAlert show];
    }
    
    return resultValueArray;
}


@end
