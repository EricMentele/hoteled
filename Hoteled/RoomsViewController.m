//
//  RoomsViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/9/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "RoomsViewController.h"

@interface RoomsViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *roomsTable;

@end

@implementation RoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.roomsTable.dataSource = self;
    // Do any additional setup after loading the view.
  
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.hotel.rooms.count;
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
