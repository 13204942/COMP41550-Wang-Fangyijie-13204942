//
//  Record.h
//  MyAccount
//
//  Created by apple on 14-4-11.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Record : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * money;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * title;

@end
