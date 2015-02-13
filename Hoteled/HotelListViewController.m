//
//  HotelListViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/9/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "HotelListViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomsViewController.h"
#import "HotelService.h"

@interface HotelListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *hotelTable;
@property (strong, nonatomic) NSArray *hotels;

@end

@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.hotelTable.dataSource = self;
  
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]
                                  initWithEntityName:@"Hotel"];
  //this is where you would create a pedicate if desired.
  NSError *fetchError;
  NSArray *results = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
  NSAssert(!fetchError, @"FETCH ERROR!");
 if (!fetchError) {
  
    self.hotels = results;
    [self.hotelTable reloadData];
    
  }
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  if (self.hotels) {
    
    return self.hotels.count;
  } else {
    
    return 0;
  }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotelCell" forIndexPath:indexPath];
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([segue.identifier isEqualToString:@"roomsVC"]) {
    
    RoomsViewController *roomsVC = (RoomsViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = self.hotelTable.indexPathForSelectedRow;
    Hotel *hotelToPass = self.hotels[indexPath.row];
    roomsVC.passedHotel = hotelToPass;
    NSAssert(hotelToPass != nil, @"Hotel to pass is nil");
  }
}


@end

