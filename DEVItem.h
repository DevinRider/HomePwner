//
//  DEVItem.h
//  RandomItems
//
//  Created by Devin on 5/25/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEVItem : NSObject

@property (nonatomic) NSString *itemName;
@property (nonatomic) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic) NSDate *dateCreated;


+(instancetype)randomItem;

//Designated initializer for DEVItem
-(instancetype)initWithItemName:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *) sNumber;

-(instancetype)initWithItemName:(NSString *)name;

-(instancetype)initWithItemName:(NSString *)name
                   serialNumber:(NSString *)sNumber;

- (NSDate *)dateCreated;


@end
