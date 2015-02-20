//
//  AddReservationViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/10/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "AddReservationViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "HotelService.h"

@interface AddReservationViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *startDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDate;
@property (weak, nonatomic) IBOutlet UITextField  *firstName;
@property (weak, nonatomic) IBOutlet UITextField  *lastName;

@end



@implementation AddReservationViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.firstName.delegate = self;
  self.lastName.delegate  = self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  
  [textField resignFirstResponder];
  return YES;
}


- (IBAction)bookButton:(id)sender {
  
  Guest *guest            = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[[HotelService sharedService] coreDataStack].managedObjectContext];
  guest.firstName         = self.firstName.text;
  guest.lastName          = self.lastName.text;
  NSLog(@"%@",guest.firstName);
  
  [[HotelService sharedService] bookReservationForGuest:guest ForRoom:self.selectedRoom startDate:self.startDate.date endDate:self.endDate.date];
  [self dismissViewControllerAnimated:true completion:nil];
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
