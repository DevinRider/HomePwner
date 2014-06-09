//
//  DEVItemStore.m
//  Homepwner
//
//  Created by Devin on 6/9/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVItemStore.h"
#import "DEVItem.h"

@interface DEVItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation DEVItemStore

+ (instancetype)sharedStore
{
    static DEVItemStore *sharedStore;
    
    //check if we need a sharedStore
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

//if [[DEVItemStore alloc ]init] is called, throw an exception to let them know they messed up.

- (instancetype)init
{
    [NSException raise:@"Singleton"
                format:@"Use +[DEVItemStore sharedStore]"];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if(self){
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (DEVItem *)createItem
{
    DEVItem *item = [DEVItem randomItem];
    
    [self.privateItems addObject:item];
    
    return item;
    
}

@end
