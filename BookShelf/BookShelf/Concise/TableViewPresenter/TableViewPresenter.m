//
//  TableViewPresenter.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "TableViewPresenter.h"
#import "BookTableViewCell.h"
#import "Book.h"

@implementation TableViewPresenter

- (instancetype)init {
    self = [super self];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate tableViewCellSelected:self.dataSource[indexPath.row].isbn13];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookTableViewCell"];
    }
    
    Book *book = self.dataSource[indexPath.row];
    [cell configure:book];
    if (book.imageData == nil) {
        [book downloadImageCompletionBlock:^(NetworkResult result) {
            switch (result) {
                case Success: {
                    [cell configure:book];
                    break;
                }
                default:
                    break;
            }
        }];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

@end
