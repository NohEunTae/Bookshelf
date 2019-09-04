//
//  TableViewPresenter.h
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Book;

NS_ASSUME_NONNULL_BEGIN

@protocol TableViewPresenterDelegate

@required
- (void)tableViewCellSelected:(NSString *)isbn13;

@end

@interface TableViewPresenter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableArray<Book *> *dataSource;
@property (nonatomic, weak) id<TableViewPresenterDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
