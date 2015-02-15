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
#import "AvailabilityDetailViewController.h"

@interface AvailabilityViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelSelector;
@property (strong, nonatomic) NSArray *vacantRooms;
@property (strong, nonatomic) NSString *selectedHotel;

@end

@implementation AvailabilityViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}//view did load


- (IBAction)checkButton:(id)sender {
  
  NSInteger selectedHotelIndex = self.hotelSelector.selectedSegmentIndex;
  self.selectedHotel = [self.hotelSelector titleForSegmentAtIndex:selectedHotelIndex];
  //NSLog(@"%@",self.selectedHotel);
  
  self.vacantRooms = [[HotelService sharedService] checkAvailability:self.selectedHotel startDate:self.startDate.date endDate:self.endDate.date];
  
  
}//check button


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([segue.identifier isEqualToString:@"availabilityDetailVC"]) {
    
    AvailabilityDetailViewController *detailVC = segue.destinationViewController;
    detailVC.passedRooms = self.vacantRooms;
    detailVC.passedHotel = self.selectedHotel;
  }
}

@end
