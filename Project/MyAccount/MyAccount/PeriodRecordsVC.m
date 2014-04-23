//
//  PeriodRecordsVC.m
//  MyAccount
//
//  Created by apple on 14-4-8.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import "PeriodRecordsVC.h"

@interface PeriodRecordsVC ()

@end

@implementation PeriodRecordsVC
@synthesize tableView;
@synthesize periodRecords;

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

- (void)setSelectedTime:(NSString *)selectedTime
{
    _selectedTime = selectedTime;
    
    if (!_selectedTime) {
        NSLog(@"Fail to set Time");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self fetchRecords];
    
    NSError *error;
    if (![[self fetchRecords] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self showTopLabel];
    [self editTextField];
    

    NSString *balanceString = [NSString stringWithFormat:@"%.2f", [self calculateCurrentBalance]];
    balanceText.text = balanceString;
    
    if ([self calculateCurrentBalance] < 0.00) {

        balanceText.textColor = [UIColor colorWithRed:255.0f/255.0
                                                green:72.0f/255.0
                                                 blue:1.0f/255.0
                                                alpha:1];
    }else
    {
        balanceText.textColor = [UIColor colorWithRed:39.0f/255.0
                                                green:224.0f/255.0
                                                 blue:14.0f/255.0
                                                alpha:1];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editTextField
{
    balanceText.enabled = NO;
}



- (void)showTopLabel
{
    if ([_selectedTime isEqual: @"Today"])
    {
        NSString *labelToday = [DateOperation getToday];
        [self.topLabel setText:labelToday];
        
    }else if ([_selectedTime isEqual:@"Week"])
    {
        NSString *startWeek = [DateOperation getStartOfWeek];
        NSString *endWeek = [DateOperation getEndOfWeek];
        NSString *currentWeek = [startWeek stringByAppendingFormat:@" ~ %@", endWeek];
        [self.topLabel setText:currentWeek];
        
    }else
    {
        NSString *labelMonth = [DateOperation getCurrentMonth];
        [self.topLabel setText:labelMonth];
    }
}

#pragma mark Fetch records according _selectedTime

- (NSFetchedResultsController *)fetchRecords
{
    NSDate *today = [NSDate date];
    
    if (_fetchRecords != nil) {
        return _fetchRecords;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Record"];
    request.predicate = nil;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record"
                                              inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    if ([_selectedTime isEqual:@"Today"]) {
        
        NSDate *startOfToday = [DateOperation beginningOfDay:today];
        NSDate *endOfToday = [DateOperation endOfDay:today];
        
        [request setPredicate:[NSPredicate predicateWithFormat:@"time >= %@ AND time < %@", startOfToday, endOfToday]];
        
    }else if ([_selectedTime isEqual:@"Week"])
    {
        NSDate *firstDay = [DateOperation firstDayOfWeek:today];
        NSDate *lastDay = [DateOperation lastDayOfWeek:today];
        
        [request setPredicate:[NSPredicate predicateWithFormat:@"time >= %@ AND time < %@", firstDay, lastDay]];

    }else
    {
        NSDate *firstDayMonth = [DateOperation firstDayOfMonth:today];
        NSDate *lastDayMonth = [DateOperation lastDayOfMonth:today];
        
        [request setPredicate:[NSPredicate predicateWithFormat:@"time >= %@ AND time < %@", firstDayMonth, lastDayMonth]];
    }
    
    
    //NSArray *todayRecord = [self.context executeFetchRequest:request error:nil];
    
    
    NSSortDescriptor *recordsDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time"
                                                                      ascending:YES];
    NSArray *sortDescriptiors = @[recordsDescriptor];
    [request setSortDescriptors:sortDescriptiors];
    
    self.fetchRecords = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                 managedObjectContext:self.context
                                                                   sectionNameKeyPath:nil
                                                                            cacheName:nil];
    _fetchRecords.delegate = self;
    
    return _fetchRecords;
}



#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchRecords sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchRecords sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PeriodCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    Record *record = [self.fetchRecords objectAtIndexPath:indexPath];
    cell.textLabel.text = record.title;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd, MMM yyyy HH:mm"];
    NSString *recordTime = [dateFormat stringFromDate:record.time];
    
    cell.detailTextLabel.text = recordTime;
    
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



#pragma mark Show currentBalance

- (double)calculateCurrentBalance
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

    [request setEntity:entity];
    
    NSArray *results = [self.context executeFetchRequest:request error:nil];
    

        
    NSDictionary *resultsDictionary = [results objectAtIndex:0];
    NSNumber *resultValue = [resultsDictionary objectForKey:@"result"];
        
    double resultValueDouble = [resultValue doubleValue];
        
//    NSNumber *resultValueNumber = [NSNumber numberWithDouble:resultValueDouble];
    
    
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
    
    return resultValueDouble;
}



#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.destinationViewController isKindOfClass:[ViewDetailVC class]])
    {
        ViewDetailVC *viewDetailVC = (ViewDetailVC *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Record *record = [self.fetchRecords objectAtIndexPath:indexPath];

        viewDetailVC.singleRecordTime = record.time;
        viewDetailVC.singleRecordMoney = record.money;
        viewDetailVC.singleRecordTitle = record.title;
        viewDetailVC.singleRecordDescription = record.detail;
        
    }
}


@end
