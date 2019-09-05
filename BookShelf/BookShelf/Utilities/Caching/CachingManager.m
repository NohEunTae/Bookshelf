//
//  CachingManager.m
//  BookShelf
//
//  Created by user on 05/09/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "CachingManager.h"

@implementation CachingManager

+ (instancetype)sharedInstance {
    static CachingManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CachingManager alloc] init];
    });
    return sharedInstance;
}

- (void)archivedDataWithRootObject:(id)object forKey:(NSString *)key {
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)unarchivedObjectOfClasses:(NSSet *)set forKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSError *error = nil;
    
    NSArray *object = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }
    return object;
}

- (id)unarchivedObjectOfClass:(id)class forKey:(NSString *)key {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSError *error = nil;

    id object = [NSKeyedUnarchiver unarchivedObjectOfClass:class fromData:data error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return nil;
    }
    
    return object;
}

@end
