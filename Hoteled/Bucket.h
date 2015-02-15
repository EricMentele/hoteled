//
//  Bucket.h
//  Hoteled
//
//  Created by Eric Mentele on 2/14/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bucket : NSObject

@property (strong,nonatomic) Bucket *next;
@property (strong,nonatomic) id data;
@property (strong,nonatomic) NSString *key;
@end
