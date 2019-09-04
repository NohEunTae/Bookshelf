//
//  Book.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)downloadImageCompletionBlock:(void (^)(NetworkResult result))completionBlock {
    [NetworkManager.sharedInstance downloadImageWithUrl:self.image withCompletionBlock:^(NetworkResult result, id  _Nullable data) {
        switch (result) {
            case Success: {
                self.imageData = data;
                completionBlock(Success);
                break;
            }
            case Fail:
                completionBlock(Fail);
                break;
        }
    }];
}

@end
