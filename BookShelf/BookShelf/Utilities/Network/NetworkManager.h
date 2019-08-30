//
//  NetworkManager.h
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

typedef NS_ENUM(NSInteger, NetworkResult) {
    Success,
    Fail
};

+ (instancetype)sharedInstance;

- (void)requestGetWithUrl:(NSString *)url with:(NSArray * __nullable)param withCompletionBlock:(void (^)(NetworkResult result, id __nullable data))completionBlock;

- (void)downloadImageWithUrl:(NSString *)url withCompletionBlock:(void (^)(NetworkResult result, id __nullable data))completionBlock;

@end

NS_ASSUME_NONNULL_END
