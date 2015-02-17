//
//  HotelService.m
//  Hoteled
//
//  Created by Eric Mentele on 2/11/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "HotelService.h"
#import "Room.h"

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


-(void)checkAvailability:(NSString *)hotelSelected startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  //Set up fetch requests
  //Hotel Rooms
  NSFetchRequest *fetchHotelRooms = [[NSFetchRequest alloc]initWithEntityName:@"Room"];
  NSString *selectedHotel = hotelSelected;
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@", selectedHotel];
  fetchHotelRooms.predicate = predicate;
  //Reservations
  NSFetchRequest *fetchReservations = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *reservationsPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ AND startDate <= %@ AND endDate >= %@", selectedHotel, startDate, endDate];
  fetchReservations.predicate = reservationsPredicate;
  //Execution of reservations fetch
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:fetchReservations error:&fetchError];
  NSMutableArray *rooms = [NSMutableArray new];
  for (Reservation *reservation in results) {
    
    [rooms addObject:reservation.room];
  }//for to populate reservations
  //Room info
  NSLog(@"%lu",rooms.count);
  NSFetchRequest *fetchRoomsInfo = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)",hotelSelected, rooms];
  fetchRoomsInfo.predicate = roomsPredicate;
  NSMutableArray *roomsToUse = [[NSMutableArray alloc]init];
  NSArray *finalResults = [self.coreDataStack.managedObjectContext executeFetchRequest:fetchRoomsInfo error:&fetchError];
 
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
      for (Room *room in finalResults) {
      [roomsToUse addObject:room];
    }//for room
  }//if error
  
  

  
  
  
  
  

  NSLog(@"results : %lu",(unsigned long)finalResults.count);
  self.vacantRooms = finalResults;
  }

@end
