//
//  IbsnTableViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "IsbnTableViewCell.h"

@interface IsbnTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *isbn10;

@property (weak, nonatomic) IBOutlet UILabel *isbn13;

@end

@implementation IsbnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(NSString *)isbn10 isbn13:(NSString *)isbn13 {
    self.isbn10.text = [NSString stringWithFormat:@"ISBN10 : %@", isbn10];
    self.isbn13.text = [NSString stringWithFormat:@"ISBN13 : %@", isbn13];
    [self setNeedsLayout];
}

@end
