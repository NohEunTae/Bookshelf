//
//  BookTableViewCell.h
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Book;

NS_ASSUME_NONNULL_BEGIN

@interface BookTableViewCell : UITableViewCell

- (void)configure:(Book *)book;

@end

NS_ASSUME_NONNULL_END
