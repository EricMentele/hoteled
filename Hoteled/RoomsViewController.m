//
//  RoomsViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/9/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "RoomsViewController.h"
#import "Room.h"
#import "AddReservationViewController.h"
#import "ReservationsListViewController.h"

@interface RoomsViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *roomsTable;
@property (strong,nonatomic) NSArray *selectedRooms;

@end

@implementation RoomsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
  NSAssert(self.passedHotel != nil, @"Passed hotel is nil");
  self.selectedRooms = self.passedHotel.rooms.allObjects;
  self.roomsTable.dataSource = self;
  //allObjects converts to an array.
}//view did load


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  NSLog(@"%lu",(unsigned long)_selectedRooms.count);
  return self.selectedRooms.count;
}//table view rows


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roomsCell" forIndexPath:indexPath];
//  NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"number"
//                                                               ascending:YES];
//  NSArray *sortedRooms = [self.selectedRooms sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
  Room *room = self.selectedRooms[indexPath.row];
  //%@ is wildcard
  NSString *number = [NSString stringWithFormat:@"%@", room.number];
  cell.textLabel.text = number;
  return cell;
}//table view cell


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.identifier isEqualToString:@"reservationsListVC"]) {
      ReservationsListViewController *destinationVC = segue.destinationViewController;
      NSIndexPath *indexPath = self.roomsTable.indexPathForSelectedRow;
      Room *room = self.selectedRooms[indexPath.row];
      destinationVC.selectedRoom = room;
    }//if identifier
}//prepare for segue
@end
