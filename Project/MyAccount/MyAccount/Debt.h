//
//  Debt.h
//  MyAccount
//
//  Created by apple on 14-4-11.
//  Copyright (c) 2014年 Fangyijie Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Debt : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * money;
@property (nonatomic, retain) NSData * thimnail;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * title;

@end
