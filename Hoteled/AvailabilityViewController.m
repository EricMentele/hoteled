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
#import "HotelService.h"

@interface AvailabilityViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSelector;

@end

@implementation AvailabilityViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}//view did load


- (IBAction)checkButton:(id)sender {
  
  NSInteger selectedHotelIndex = self.hotelSelector.selectedSegmentIndex;
  NSString *selectedHotel = [self.hotelSelector titleForSegmentAtIndex:selectedHotelIndex];
  
  [[HotelService sharedService] checkAvailability:selectedHotel startDate:self.startDate.date endDate:self.endDate.date];
  
  
}//check button

@end
