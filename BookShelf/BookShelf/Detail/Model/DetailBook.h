//
//  DetailBook.h
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailBook : Book

@property (nonatomic) NSString *authors, *publisher, *desc, *isbn10, *language, *error;
@property (nonatomic) NSNumber *pages, *rating, *year;
@property (nonatomic) NSDictionary *pdf;

@end

NS_ASSUME_NONNULL_END
