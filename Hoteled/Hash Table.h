//
//  Hash Table.h
//  Hoteled
//
//  Created by Eric Mentele on 2/14/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hash_Table : NSObject

-(void)setObject:(id)object forKey:(NSString*)key;
-(void)removeObjectForKey:(NSString *)key;
-(id)objectForKey:(NSString*)key;
-(instancetype)initWithSize:(NSInteger)size;


@end
