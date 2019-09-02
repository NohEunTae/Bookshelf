//
//  CollectionTableViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "DetailBook.h"
#import "CollectionViewCell.h"

@interface CollectionTableViewCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) DetailBook* dataSource;

@end

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(DetailBook *)detailBook {
    self.dataSource = detailBook;
    [self.collectionView reloadData];
}


//- collectionViews

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize textSize;
    NSString *title, *content;
    switch ((CollectionViewRowType)indexPath.row) {
        case Year:
            title = @"Year";
            content = [[NSString alloc] initWithFormat:@"%ld", self.dataSource.year.integerValue];
            break;
        case Language:
            title = @"Language";
            content = [[NSString alloc] initWithFormat:@"%@", self.dataSource.language];
            break;
        case Pages:
            title = @"Pages";
            content = [[NSString alloc] initWithFormat:@"%ldp", self.dataSource.pages.integerValue];
            break;
        case Publisher:
            title = @"Publisher";
            content = [[NSString alloc] initWithFormat:@"%@", self.dataSource.publisher];
            break;
    }
    
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]}];
    CGSize contentSize = [content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]}];
    
    NSLog(@"%lf, %lf", titleSize.width, contentSize.width);
    textSize = titleSize.width > contentSize.width ? titleSize : contentSize;
    return CGSizeMake(textSize.width * 1.3, 80);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSString *title, *content;
    switch ((CollectionViewRowType)indexPath.row) {
        case Year:
            title = @"Year";
            content = [[NSString alloc] initWithFormat:@"%ld", self.dataSource.year.integerValue];
            break;
        case Language:
            title = @"Language";
            content = [[NSString alloc] initWithFormat:@"%@", self.dataSource.language];
            break;
        case Pages:
            title = @"Pages";
            content = [[NSString alloc] initWithFormat:@"%ldp", self.dataSource.pages.integerValue];
            break;
        case Publisher:
            title = @"Publisher";
            content = [[NSString alloc] initWithFormat:@"%@", self.dataSource.publisher];
            break;
    }
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    [cell configure:title content:content];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource == nil ? 0 : 4;
}

@end
