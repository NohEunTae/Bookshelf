//
//  PagingTableViewPresenter.h
//  BookShelf
//
//  Created by user on 03/09/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "TableViewPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PagingTableViewPresenterDelegate

@required
- (void)requestNextPage;

@end


@interface PagingTableViewPresenter : TableViewPresenter <UITableViewDataSourcePrefetching>

@property (nonatomic, weak) id<PagingTableViewPresenterDelegate> pagingDelegate;

@end

NS_ASSUME_NONNULL_END
