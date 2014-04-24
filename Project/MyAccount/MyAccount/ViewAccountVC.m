//
//  ViewAccountVC.m
//  MyAccount
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import "ViewAccountVC.h"
#import "PeriodRecordsVC.h"
#import "DateOperation.h"
#import "AllRecordsVC.h"

@interface ViewAccountVC ()

@end

@implementation ViewAccountVC
@synthesize todayWeekMonth;
@synthesize tableView;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Today",@"Week",@"Month", nil];
    self.todayWeekMonth = array;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"American Typewriter" size:18],
      NSFontAttributeName, nil]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todayWeekMonth count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MainTableCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    cell.textLabel.text = [todayWeekMonth objectAtIndex:row];
    
    if ([cell.textLabel.text isEqual: @"Today"])
    {
        cell.detailTextLabel.text = [DateOperation getToday];
    }else if ([cell.textLabel.text isEqual:@"Week"])
    {
        NSString *startWeek = [DateOperation getStartOfWeek];
        NSString *endWeek = [DateOperation getEndOfWeek];
        NSString *currentWeek = [startWeek stringByAppendingFormat:@" ~ %@", endWeek];
        cell.detailTextLabel.text = currentWeek;
    }else
    {
        cell.detailTextLabel.text = [DateOperation getCurrentMonth];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"American Typewriter" size:15];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[PeriodRecordsVC class]])
    {
        PeriodRecordsVC *periodRecordsVC = (PeriodRecordsVC *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        periodRecordsVC.selectedTime = cell.textLabel.text;

    }
    
}


@end
