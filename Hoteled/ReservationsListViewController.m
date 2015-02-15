//
//  ReservationsListViewController.m
//  Hoteled
//
//  Created by Eric Mentele on 2/14/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "ReservationsListViewController.h"
#import "HotelService.h"
#import "AddReservationViewController.h"

@interface ReservationsListViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;

@end


@implementation ReservationsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room == %@", self.selectedRoom];
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:true];
  fetchRequest.predicate = predicate;
  fetchRequest.sortDescriptors = @[sortDescriptor];
  self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
  self.fetchedResultsController.delegate = self;
  self.tableView.dataSource = self;
  NSError *fetchError;
  [self.fetchedResultsController performFetch:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError);
  }//fetch error
}//view did load


-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  
  [self.tableView beginUpdates];
}//controller will change


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  
  [self.tableView endUpdates];
}//controller did change content


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  
  switch (type) {
      
    case NSFetchedResultsChangeInsert:
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeDelete:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeMove:
      [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
    case NSFetchedResultsChangeUpdate:
      [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath: indexPath];
      break;
    default:
      NSLog(@"DEFAULT");
      break;
  }//switch
}//controller


#pragma mark - TABLE VIEW
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
  return [[self.fetchedResultsController sections] count];
}//number of sections


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  NSArray *sections = [self.fetchedResultsController sections];
  id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}//number of rows


-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath {
  
  Reservation *reservation = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@" room:%@",reservation.room.number];
}//configure cell


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reservationCell" forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}//cell for row


#pragma mark - TABLE INTERACTION
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  AddReservationViewController *destinationVC = segue.destinationViewController;
  destinationVC.selectedRoom = self.selectedRoom;
}//prepare for segue


@end
