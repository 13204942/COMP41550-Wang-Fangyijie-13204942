//
//  DateOperation.m
//  MyAccount
//
//  Created by apple on 14-4-9.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import "DateOperation.h"

@implementation DateOperation

+ (NSString *)getToday
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd, MMM"];
    NSString *today = [dateFormat stringFromDate:now];
    
    return today;
}

+ (NSString *)getCurrentTime
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd, MMM HH:mm:ss"];
    NSString *currentTime = [dateFormat stringFromDate:now];

    return currentTime;
}

+ (NSString *)getStartOfWeek
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDate *startOfTheWeek;
    NSTimeInterval interval;
    
    [cal rangeOfUnit:NSWeekCalendarUnit
           startDate:&startOfTheWeek
            interval:&interval
             forDate:now];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd, MMM yyyy"];
    NSString *getStartOfWeek = [dateFormat stringFromDate:startOfTheWeek];
    
    return getStartOfWeek;
}

+ (NSString *)getEndOfWeek
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDate *startOfTheWeek;
    NSDate *endOfWeek;
    NSTimeInterval interval;
    
    [cal rangeOfUnit:NSWeekCalendarUnit
       startDate:&startOfTheWeek
        interval:&interval
         forDate:now];
//startOfWeek holds now the first day of the week, according to locale (monday vs. sunday)

    endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
// holds 23:59:59 of last day in week.
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd, MMM yyyy"];
    NSString *getEndOfWeek = [dateFormat stringFromDate:endOfWeek];
    
    return getEndOfWeek;
}

+ (NSString *)getCurrentMonth
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM yyyy"];
    NSString *currentMonth = [dateFormat stringFromDate:now];
    
    return currentMonth;
}

+ (NSString *)convertTime:(NSDate *)time
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd, MMM yyyy HH:mm"];
    
    NSString *convertTimeToString = [dateFormat stringFromDate:time];
    
    return convertTimeToString;
}


+ (NSDate *)beginningOfDay:(NSDate *)date;

{
    
    NSDate *dat = date;
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:dat];
    
    [components setHour:0];
    
    [components setMinute:0];
    
    [components setSecond:0];
    
    return [cal dateFromComponents:components];
}

+ (NSDate *)endOfDay:(NSDate *)date;

{
    
    NSDate *dat = date;
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [cal components:( NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:dat];
    
    [components setHour:23];
    
    [components setMinute:59];
    
    [components setSecond:59];
    
    return [cal dateFromComponents:components];
    
}


+ (NSDate *)firstDayOfWeek:(NSDate *)date;
{
    NSDate *today = date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumber =  [[calendar components: NSWeekCalendarUnit fromDate:today] week];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comp = [gregorian components:NSYearCalendarUnit fromDate:today];
    [comp setWeek:weekNumber];  //Week number.
    [comp setWeekday:1]; //First day of the week. Change it to 7 to get the last date of the week
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:comp];
    
    return beginningOfWeek;

}



+ (NSDate *)lastDayOfWeek:(NSDate *)date
{
    
    NSDate *today = date;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNumber =  [[calendar components: NSWeekCalendarUnit fromDate:today] week];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comp = [gregorian components:NSYearCalendarUnit fromDate:today];
    [comp setWeek:weekNumber];  //Week number.
    [comp setWeekday:7]; //First day of the week. Change it to 7 to get the last date of the week
    [comp setHour:23];    
    [comp setMinute:59];
    [comp setSecond:59];
    
    NSDate *endOfWeek = [gregorian dateFromComponents:comp];
    
    return endOfWeek;
}


+ (NSDate *)firstDayOfMonth:(NSDate *)date
{

    NSDate *today = date;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    [comp setDay:1];

    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    return firstDayOfMonthDate;
}



+ (NSDate *)lastDayOfMonth:(NSDate *)date
{
    
    NSDate *today = date;
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:today options:0];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:newDate];
    [comp setDay:1];
    
    NSDate *lastDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    return lastDayOfMonthDate;
}


+ (NSString *)dayOfToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MM yyyy"];
    NSString *dayOfToday = [dateFormat stringFromDate:now];
    
    return dayOfToday;
}


//+ (NSDate *)setDayFormat:(NSDate *)date
//{
//
//    NSLocale *formatterLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    [dateFormatter setLocale:formatterLocale];
//    [dateFormatter setDateFormat:@"dd'-'MM'-'yyyy'T'HH':'mm':'ss'Z'"];
//    
//    NSDate *dat = [dateFormatter stringFromDate:date];
//    
//    NSCalendar *cal = [NSCalendar currentCalendar];
//    
//    NSDateComponents *components = [cal components:( NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:dat];
//    
//    return [cal dateFromComponents:components];
//}



@end
