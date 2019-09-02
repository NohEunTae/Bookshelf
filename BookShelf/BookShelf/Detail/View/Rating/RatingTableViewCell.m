//
//  RatingTableViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "RatingTableViewCell.h"

@interface RatingTableViewCell()

@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *stars;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end


@implementation RatingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(NSNumber *)rating price:(NSString *)price {
    for (int i = 0; i < rating.integerValue; i++) {
        [self.stars[i] setImage:[UIImage imageNamed:@"star_exist"]];
    }
    self.price.text = price;
    [self setNeedsLayout];
}

@end
