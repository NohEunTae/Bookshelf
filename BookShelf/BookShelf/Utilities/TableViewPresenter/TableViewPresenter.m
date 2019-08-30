//
//  TableViewPresenter.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "TableViewPresenter.h"
#import "BookTableViewCell.h"

@implementation TableViewPresenter

- (instancetype)init {
    self = [super self];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookTableViewCell"];
    }
    [cell configure: self.dataSource[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

@end
