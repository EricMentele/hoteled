//
//  CoreDataStack.h
//  Hoteled
//
//  Created by Eric Mentele on 2/11/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext       *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel         *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (instancetype)initForTesting;

@end
