//
//  CoreDataStack.m
//  Hoteled
//
//  Created by Eric Mentele on 2/11/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotel.h"
#import "Room.h"

@interface CoreDataStack()

@property (nonatomic) BOOL isTesting;

@end


@implementation CoreDataStack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(instancetype)initForTesting {
  
  self = [super init];
  if (self) {
    self.isTesting = true;
  }//if self
  return self;
}//init for testing

-(instancetype)init{
  self = [super init];
  if (self){
    [self dataBaseSeed];
  }
  return self;
}
- (void) dataBaseSeed {
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  NSError *fetchError;
  
  NSInteger results = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
  NSLog(@" %ld", (long)results);
  if (results == 0) {
    //this is where we seed our hotel if empty.
    NSURL *seedURL = [[NSBundle mainBundle]URLForResource:@"seed" withExtension:@"json" ];
    NSData *seedData = [[NSData alloc] initWithContentsOfURL:seedURL];
    NSError *jsonError;
    NSDictionary *rootDictionary = [NSJSONSerialization JSONObjectWithData:seedData options:0 error:&jsonError];
    if (!jsonError) {
      
      NSArray *jsonArray = rootDictionary[@"Hotels"];
      NSAssert(jsonArray.count != 0, @"Hotels array is not populating!");
      
      for (NSDictionary *hotelDictionary in jsonArray) {
        
        Hotel *hotel = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Hotel"
                        inManagedObjectContext:self.managedObjectContext];
        hotel.name = hotelDictionary[@"name"];
        hotel.rating = hotelDictionary[@"stars"];
        hotel.location = hotelDictionary[@"location"];
        
        NSArray *roomsArray = hotelDictionary[@"rooms"];
        for (NSDictionary *roomDictionary in roomsArray) {
          Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
          room.number = roomDictionary[@"number"];
          room.beds = roomDictionary[@"beds"];
          room.rate = roomDictionary[@"rate"];
          room.hotel = hotel;
        }//for room dictionary
      }//for hotel dictionary
      
      
      NSError *saveError;
      [self.managedObjectContext save:&saveError];
      
      if (saveError) {
        NSLog(@"%@",saveError.localizedDescription);
      }//if save error
    }//if json error
  }//if results 0
}//seed data if needed


- (NSURL *)applicationDocumentsDirectory {
  // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ericmentele.Hoteled" in the application's documents directory.
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}//applicationsDocDIr


//MOM file
- (NSManagedObjectModel *)managedObjectModel {
  // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
  if (_managedObjectModel != nil) {
    
    return _managedObjectModel;
  }//if mom
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Hoteled" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Hoteled.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"Saved data failure during creation or loading.";
  NSString *storeType;
  if (self.isTesting) {
    
    storeType = NSInMemoryStoreType;
  } else {
    
    storeType = NSSQLiteStoreType;
  }//if is testing
  
  
  if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report error if present.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Saved data initialization failure";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }//if error
  
  return _persistentStoreCoordinator;
}//persistant store cooridinator


- (NSManagedObjectContext *)managedObjectContext {
  
  if (_managedObjectContext != nil) {
    
    return _managedObjectContext;
  }//managed object context
  
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    
    return nil;
  }//coordinator
  _managedObjectContext = [[NSManagedObjectContext alloc] init];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  return _managedObjectContext;
}//object context


#pragma mark - Core Data Saving support

- (void)saveContext {
  
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      
      NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
      abort();
    }//if save success
  }//if managed object
}//save context

@end

