//
//  TableViewPresenter.h
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableViewPresenter : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSMutableArray<Book *> *dataSource;

@end

NS_ASSUME_NONNULL_END
