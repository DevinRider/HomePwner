//
//  DEVItemStore.h
//  Homepwner
//
//  Created by Devin on 6/9/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DEVItem;

@interface DEVItemStore : NSObject

+ (instancetype)sharedStore;

@property (nonatomic, readonly, copy) NSArray *allItems;

- (DEVItem *)createItem;
- (void)removeItem:(DEVItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;

@end
