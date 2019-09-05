//
//  DetailBookPresenter.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "DetailBookPresenter.h"
#import "BookImageTableViewCell.h"
#import "DetailBookMultipleLineTableViewCell.h"
#import "CollectionTableViewCell.h"
#import "RatingTableViewCell.h"
#import "DescriptionTableViewCell.h"
#import "PurchaseUrlTableViewCell.h"
#import "IsbnTableViewCell.h"

@implementation DetailBookPresenter

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch ((RowType)indexPath.row) {
        case Image:
            return [self cellForImageWithTableView:tableView indexPath:indexPath];
        case Title:
        case Subtitle:
        case Authors:
            return [self cellForRowType:(RowType)indexPath.row tableView:tableView indexPath:indexPath];
        case Isbn:
            return [self cellForIsbn:tableView indexPath:indexPath];
        case Description:
            return [self cellForDescription:tableView indexPath:indexPath];
        case Rating:
            return [self cellForRating:tableView indexPath:indexPath];
        case Collection:
            return [self cellForCollection: tableView indexPath:indexPath];
        case Purchase:
            return [self cellForUrl:tableView indexPath:indexPath];
        default:
            break;
    }
    return [[UITableViewCell alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource == nil ? 0 : 9;
}

- (BookImageTableViewCell *)cellForImageWithTableView:(UITableView *)tableView indexPath: (NSIndexPath *)indexPath {
    BookImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookImageTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[BookImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookTableViewCell"];
    }
    [cell configure: self.dataSource.image];
    return cell;
}

- (DetailBookMultipleLineTableViewCell *)cellForRowType:(RowType)type tableView:(UITableView *)tableView indexPath: (NSIndexPath *)indexPath {
    DetailBookMultipleLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailBookMultipleLineTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[DetailBookMultipleLineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookTableViewCell"];
    }
    
    NSNumber *fontSize;
    NSString *text;
    switch (type) {
        case Title:
            fontSize = [[NSNumber alloc] initWithInt:25];
            text = self.dataSource.title;
            break;
        case Subtitle:
            fontSize = [[NSNumber alloc] initWithInt:17];
            text = self.dataSource.subtitle;
            break;
        case Authors:
            fontSize = [[NSNumber alloc] initWithInt:15];
            text = self.dataSource.authors;
            break;
        default:
            break;
    }
    [cell configure:text size:fontSize];
    return cell;
}

- (CollectionTableViewCell *)cellForCollection:(UITableView *) tableView indexPath:(NSIndexPath *)indexPath {
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionTableViewCell"];
    }
    [cell configure:self.dataSource];
    return cell;
}

- (RatingTableViewCell *)cellForRating:(UITableView *) tableView indexPath:(NSIndexPath *)indexPath {
    RatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RatingTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[RatingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RatingTableViewCell"];
    }
    [cell configure:self.dataSource.rating price:self.dataSource.price];
    return cell;
}

- (DescriptionTableViewCell *)cellForDescription:(UITableView *) tableView indexPath:(NSIndexPath *)indexPath {
    DescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[DescriptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RatingTableViewCell"];
    }
    [cell configure:self.dataSource.desc];
    return cell;
}

- (PurchaseUrlTableViewCell *)cellForUrl:(UITableView *) tableView indexPath:(NSIndexPath *)indexPath {
    PurchaseUrlTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseUrlTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[PurchaseUrlTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PurchaseUrlTableViewCell"];
    }
    UITapGestureRecognizer *tapGestureRecignizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUrlCell:)];

    [cell configure:self.dataSource.url tapGestureRecognizer:tapGestureRecignizer];
    return cell;
}

- (void)tapUrlCell:(UITapGestureRecognizer *)tap {
    
    NSURL *url = [[NSURL alloc] initWithString:self.dataSource.url];
    
    if([UIApplication.sharedApplication canOpenURL: url]) {
        [UIApplication.sharedApplication openURL:url options:@{} completionHandler:nil];
    }
}

- (IsbnTableViewCell *)cellForIsbn:(UITableView *) tableView indexPath:(NSIndexPath *)indexPath {
    IsbnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IsbnTableViewCell" forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[IsbnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IsbnTableViewCell"];
    }
    [cell configure:self.dataSource.isbn10 isbn13:self.dataSource.isbn13];
    return cell;
}

@end
