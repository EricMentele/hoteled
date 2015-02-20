//
//  Room.h
//  Hoteled
//
//  Created by Eric Mentele on 2/9/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSNumber *number;
@property (nonatomic, retain) NSNumber *rate;
@property (nonatomic, retain) NSNumber *beds;
@property (nonatomic, retain) Hotel    *hotel;
@property (nonatomic, retain) NSSet    *reservations;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(Reservation *)value;
- (void)removeReservationsObject:(Reservation *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
