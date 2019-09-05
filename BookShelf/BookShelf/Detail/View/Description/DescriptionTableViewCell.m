
//
//  DescriptionTableViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "DescriptionTableViewCell.h"

@interface DescriptionTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation DescriptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(NSString *)desctiption {
    self.descriptionLabel.text = desctiption;
    [self setNeedsLayout];
}

@end
