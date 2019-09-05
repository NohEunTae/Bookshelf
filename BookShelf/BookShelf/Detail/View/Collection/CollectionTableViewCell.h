//
//  CollectionTableViewCell.h
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DetailBook;

@interface CollectionTableViewCell : UITableViewCell

typedef NS_ENUM(NSInteger, CollectionViewRowType) {
    Year, Language, Pages, Publisher
};

- (void)configure:(DetailBook *)detailBook;

@end

NS_ASSUME_NONNULL_END
