//
//  AvailabilityDetailViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/14/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "AvailabilityDetailViewController.h"
#import "Room.h"

@interface AvailabilityDetailViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView           *tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem      *hotelName;

@end

@implementation AvailabilityDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  //NSLog(@"%@",self.passedHotel);
  //NSLog(@"%lu",(unsigned long)self.passedRooms.count);
  self.hotelName.title      = self.passedHotel;
  self.tableView.dataSource = self;
}//view did load


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.passedRooms.count;
}//number of rows


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
  Room *room                = self.passedRooms[indexPath.row];
  //%@ is wildcard
  NSString *number          = [NSString stringWithFormat:@"%@", room.number];
  cell.textLabel.text       = number;
  return cell;
}//cell for row


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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
