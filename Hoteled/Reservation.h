//
//  Reservation.h
//  Hoteled
//
//  Created by Eric Mentele on 2/9/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSNumber * startDate;
@property (nonatomic, retain) NSNumber * endDate;
@property (nonatomic, retain) Room *room;
@property (nonatomic, retain) Guest *guest;

@end
