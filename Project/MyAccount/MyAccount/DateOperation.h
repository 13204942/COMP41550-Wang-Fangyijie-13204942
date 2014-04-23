//
//  DateOperation.h
//  MyAccount
//
//  Created by apple on 14-4-9.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateOperation : NSObject

+ (NSString *)getToday;
+ (NSString *)getCurrentTime;
+ (NSString *)getStartOfWeek;
+ (NSString *)getEndOfWeek;
+ (NSString *)getCurrentMonth;
+ (NSString *)convertTime:(NSDate *)time;

+ (NSDate *)beginningOfDay:(NSDate *)date;
+ (NSDate *)endOfDay:(NSDate *)date;

+ (NSDate *)firstDayOfWeek:(NSDate *)date;
+ (NSDate *)lastDayOfWeek:(NSDate *)date;

+ (NSDate *)firstDayOfMonth:(NSDate *)date;
+ (NSDate *)lastDayOfMonth:(NSDate *)date;

+ (NSDate *)dayOfToday;

//+ (NSDate *)setDayFormat:(NSDate *)date;
@end
