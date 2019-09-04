//
//  PagingTableViewPresenter.m
//  BookShelf
//
//  Created by user on 03/09/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "PagingTableViewPresenter.h"
#import "Book.h"

@implementation PagingTableViewPresenter

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row ==  (int)(self.dataSource.count / 3)) {
        [self.pagingDelegate requestNextPage];
    }
}

- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {
    for (int i = 0; i < indexPaths.count; i++) {
        if (self.dataSource[indexPaths[i].row].imageData == nil) {
            [self.dataSource[indexPaths[i].row] downloadImageCompletionBlock:^(NetworkResult result) {
                
            }];
        }

    }
}

@end
