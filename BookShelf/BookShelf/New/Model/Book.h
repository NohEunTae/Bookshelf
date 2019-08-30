//
//  Book.h
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coding.h"

NS_ASSUME_NONNULL_BEGIN

@interface Book : Coding

@property (nonatomic) NSString *title, *subtitle, *isbn13, *price, *url, *image;

@end

NS_ASSUME_NONNULL_END
