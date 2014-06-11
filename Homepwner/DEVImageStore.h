//
//  DEVImageStore.h
//  Homepwner
//
//  Created by Devin on 6/11/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEVImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
