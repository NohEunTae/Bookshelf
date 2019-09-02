//
//  CollectionViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configure:(NSString *) title content:(NSString *)content {
    self.title.text = title;
    self.content.text = content;
    [self setNeedsLayout];
}

@end
