//
//  DEVItem.m
//  RandomItems
//
//  Created by Devin on 5/25/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVItem.h"

@implementation DEVItem

+(instancetype)randomItem
{
    //create an immutable array of three adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    //create an immutable array of three nouns
    NSArray *randomNounList = @[@"Couch", @"Carpet", @"Table"];
    
    NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            randomAdjectiveList[adjectiveIndex],
                            randomNounList[nounIndex]];
    
    int randomValue = arc4random() %100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() %10,
                                    'A' + arc4random() %26,
                                    '0' + arc4random() %10,
                                    'A' + arc4random() %26,
                                    '0' + arc4random() %10];
    
    DEVItem *newItem = [[DEVItem alloc] initWithItemName:randomName
                                          valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}


-(instancetype)initWithItemName:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber
{
    //Call the Superclass' designated initializer
    self = [super init];
    
    //Did the superclass' designated initializer succeed?
    if(self) {
        //Give the instance variables initial values
        self.itemName = name;
        self.valueInDollars = value;
        self.serialNumber = sNumber;
        //Set _dateCreated to the current date and time
        self.dateCreated = [[NSDate alloc] init];
    }
    //return the address of the newly initialized object
    return self;
}

-(instancetype)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:@""];
}

-(instancetype)initWithItemName:(NSString *)name
                   serialNumber:(NSString *)sNumber
{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:sNumber];
}

-(instancetype)init
{
    return [self initWithItemName:@"Item"];
}

-(NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                                   self.itemName,
                                   self.serialNumber,
                                   self.valueInDollars,
                                   self.dateCreated];
    return descriptionString;
}

@end
