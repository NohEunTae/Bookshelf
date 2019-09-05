//
//  CachingManager.h
//  BookShelf
//
//  Created by user on 05/09/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CachingManager : NSObject

+ (instancetype)sharedInstance;

- (void)archivedDataWithRootObject:(id)object forKey:(NSString *)key;
- (NSArray *)unarchivedObjectOfClasses:(NSSet *)set forKey:(NSString *)key;
- (id)unarchivedObjectOfClass:(id)class forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
