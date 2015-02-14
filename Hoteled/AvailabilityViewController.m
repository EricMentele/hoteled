//
//  AvailabilityViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/10/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"

@interface AvailabilityViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSelector;
@property (strong,nonatomic) NSManagedObjectContext *context;
@end

@implementation AvailabilityViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}//view did load


- (IBAction)checkButton:(id)sender {
  
  //Set up fetch requests
  //Hotel Rooms
  NSFetchRequest *fetchHotelRooms = [[NSFetchRequest alloc]initWithEntityName:@"Room"];
  NSString *selectedHotel = [self.hotelSelector titleForSegmentAtIndex:self.hotelSelector.selectedSegmentIndex];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@", selectedHotel];
  fetchHotelRooms.predicate = predicate;
  //Reservations
  NSFetchRequest *fetchReservations = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *reservationsPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ AND startDate <= %@ AND endDate >= %@", selectedHotel, self.startDate.date, self.endDate.date];
  fetchReservations.predicate = reservationsPredicate;
  //Execution of reservations fetch
  NSError *fetchError;
  NSArray *results = [self.context executeFetchRequest:fetchReservations error:&fetchError];
  NSMutableArray *rooms = [NSMutableArray new];
  for (Reservation *reservation in results) {
    
    [rooms addObject:reservation.room];
  }//for to populate reservations
  //Room info
  NSFetchRequest *fetchRoomsInfo = [[NSFetchRequest alloc] initWithEntityName:@"Room"];
  NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)",selectedHotel, rooms];
  fetchRoomsInfo.predicate = roomsPredicate;
  NSArray *finalResults = [self.context executeFetchRequest:fetchRoomsInfo error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
  }//if error
  
  NSLog(@"results : %lu",(unsigned long)finalResults.count);
  
  
}//check button

@end
