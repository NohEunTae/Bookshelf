//
//  DetailBookPresenter.h
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailBookPresenter : NSObject <UITableViewDelegate, UITableViewDataSource>

typedef NS_ENUM(NSInteger, RowType) {
    Image, Title, Subtitle, Authors, Rating, Purchase, Collection, Description, Isbn
};

@property (nonatomic) DetailBook *dataSource;

@end

NS_ASSUME_NONNULL_END
