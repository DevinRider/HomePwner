//
//  DEVImageStore.m
//  Homepwner
//
//  Created by Devin on 6/11/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVImageStore.h"

@interface DEVImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end


@implementation DEVImageStore

+ (instancetype)sharedStore
{
    static DEVImageStore *sharedStore;
    
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init
{
    [NSException raise:@"Singleton"
                format:@"Use +[DEVImageStore sharedStore"];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if(self){
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if(!key){
        return;
    }
    [self.dictionary removeObjectForKey:key];
}

@end
