//
//  HotelService.m
//  Hoteled
//
//  Created by Eric Mentele on 2/11/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "HotelService.h"

@implementation HotelService

+(id)sharedService {
  
  static HotelService *mySharedService = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    mySharedService = [[self alloc] init];
  });
  return mySharedService;
}//sharedService


-(instancetype)init {
  
  self = [super init];
  if (self) {
    
    self.coreDataStack = [[CoreDataStack alloc] init];
  }//if self
  return self;
}//init


-(instancetype)initForTesting {
  
  self = [super init];
  if (self) {
    
    self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  }//if
  return self;
}//init for testing


-(Reservation *)bookReservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  reservation.room = room;
  reservation.guest = guest;
  
  NSError *saveError;
  [self.coreDataStack.managedObjectContext save:&saveError];
  if (!saveError) {
    
    return reservation;
  } else {
    
    return nil;
  }//if else save error
}//book reservation for guest
@end
