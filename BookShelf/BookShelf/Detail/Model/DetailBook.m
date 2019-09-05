//
//  DetailBook.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "DetailBook.h"
#import "NetworkManager.h"

@implementation DetailBook

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    DetailBook *newDetailBook = [[[self class] allocWithZone:zone] init];
    newDetailBook.authors = self.authors;
    newDetailBook.publisher = self.publisher;
    newDetailBook.desc = self.desc;
    newDetailBook.isbn10 = self.isbn10;
    newDetailBook.language = self.language;
    newDetailBook.error = self.error;
    newDetailBook.pages = self.pages;
    newDetailBook.rating = self.rating;
    newDetailBook.year = self.year;
    newDetailBook.title = self.title;
    newDetailBook.subtitle = self.subtitle;
    newDetailBook.isbn13 = self.isbn13;
    newDetailBook.price = self.price;
    newDetailBook.url = self.url;
    newDetailBook.image = self.image;
    newDetailBook.imageData = self.imageData;
    return newDetailBook;
}

@end
