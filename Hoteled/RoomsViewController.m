//
//  RoomsViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/9/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "RoomsViewController.h"
#import "Room.h"

@interface RoomsViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *roomsTable;
@property (strong,nonatomic) NSArray *selectedRooms;

@end

@implementation RoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.selectedRooms = self.passedHotel.rooms.allObjects;
  self.roomsTable.dataSource = self;
  //allObjects converts to an array.
  
    // Do any additional setup after loading the view.

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.selectedRooms.count;
  //NSLog(@"%@",self.hotel.rooms.count);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roomsCell" forIndexPath:indexPath];
  Room *room = self.selectedRooms[indexPath.row];
  //%@ is wildcard
  NSString *number = [NSString stringWithFormat:@"%@", room.number];
  cell.textLabel.text = number;
  return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([segue.identifier isEqualToString:@""]) {
    
    
  }
}

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
