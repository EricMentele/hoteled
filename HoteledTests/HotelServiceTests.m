//
//  HotelServiceTests.m
//  Hoteled
//
//  Created by Eric Mentele on 2/11/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "HotelService.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"

@interface HotelServiceTests : XCTestCase

@property (strong,nonatomic) HotelService *hotelService;
@property (strong,nonatomic) Room *room;
@property (strong,nonatomic) Guest *guest;
@property (strong,nonatomic) Hotel *hotel;

@end

@implementation HotelServiceTests

- (void)setUp {
  [super setUp];
  
  self.hotelService = [[HotelService alloc] initForTesting];
  self.hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
  self.hotel.name = @"Fake Hotel";
  self.hotel.location = @"Fake Location";
  self.hotel.rating = @1;
  
  self.room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
  self.room.number = @101;
  self.room.rate = @1;
  self.room.beds = @2;
  self.room.hotel = self.hotel;
  
  self.guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.hotelService.coreDataStack.managedObjectContext];
  self.guest.firstName = @"Testy";
  self.guest.lastName = @"McTestorson";
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  self.hotelService = nil;
  self.hotel = nil;
  self.guest = nil;
  self.room = nil;
  [super tearDown];
}

- (void)testBookReservation {
  NSDate *startDate = [NSDate date];
  
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [[NSDateComponents alloc] init];
  components.day = 2;
  NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
  
  
  Reservation *reservation = [self.hotelService bookReservationForGuest:self.guest ForRoom:self.room startDate:startDate endDate:endDate];
  XCTAssertNotNil(reservation,@"reservation should not be nil for valid dates");
}

-(void)testBookReservationWithStartDateAfterEndDate {
  
}

@end
