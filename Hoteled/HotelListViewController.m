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

@interface HotelListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *hotelTable;
@property (strong, nonatomic) NSArray *hotels;

@end

@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.hotelTable.dataSource = self;
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]
                                  initWithEntityName:@"Hotel"];
  //this is where you would create a pedicate if desired.
  NSError *fetchError;
  
  NSArray *results = [context executeFetchRequest:fetchRequest error:&fetchError];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
