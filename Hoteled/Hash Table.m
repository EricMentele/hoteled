//
//  Hash Table.m
//  Hoteled
//
//  Created by Eric Mentele on 2/14/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "Hash Table.h"
#import "Bucket.h"


@interface Hash_Table ()
@property (nonatomic) NSInteger size;
@property (strong,nonatomic) NSMutableArray *hashArray;
@end

@implementation Hash_Table

-(instancetype)initWithSize:(NSInteger)size {
  self = [super init];
  if (self) {
    self.size = size;
    self.hashArray = [NSMutableArray new];
    
    for (int i = 0; i <self.size; i++) {
      Bucket *bucket = [Bucket new];
      [self.hashArray addObject:bucket];
    }
  }
  return self;
}


-(NSInteger)hash:(NSString *)key {
  NSInteger total = 0;
  
  for (int i = 0; i < key.length; i++) {
    NSInteger ascii = [key characterAtIndex:i];
    total = total + ascii;
  }
  NSInteger index = total % self.size;
  return index;
}


-(id)objectForKey:(NSString*)key {
  NSInteger index = [self hash:key];
  
  Bucket *bucket = self.hashArray[index];
  
  while (bucket) {
    if ([bucket.key isEqualToString:key]) {
      return bucket.data;
    } else {
      bucket = bucket.next;
    }
  }
  return nil;
}


-(void)removeObjectForKey:(NSString *)key {
  NSInteger index = [self hash:key];
  Bucket *previousBucket;
  Bucket *bucket = self.hashArray[index];
  
  while (bucket) {
    if ([key isEqualToString:bucket.key]) {
      if (!previousBucket) {
        Bucket *nextBucket = bucket.next;
        if (!nextBucket) {
          nextBucket = [Bucket new];
        }
        self.hashArray[index] = nextBucket;
      } else {
        previousBucket.next = bucket.next;
      }
      return;
    }
    previousBucket = bucket;
    bucket = bucket.next;
  }
  return;
}


-(void)setObject:(id)object forKey:(NSString*)key {
  NSInteger index = [self hash:key];
  Bucket *bucket = [Bucket new];
  bucket.key = key;
  bucket.data = object;
  
  [self removeObjectForKey:key];
  Bucket *head = self.hashArray[index];
  if (!head.data) {
    self.hashArray[index] = bucket;
  } else {
    bucket.next = head;
    self.hashArray[index] = bucket;
  }
}
@end
