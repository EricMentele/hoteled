//
//  Reservation.h
//  Hoteled
//
//  Created by Eric Mentele on 2/13/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) Guest  *guest;
@property (nonatomic, retain) Room   *room;

@end
