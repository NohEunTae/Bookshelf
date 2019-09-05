//
//  DetailBookMultipleLineTableViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "DetailBookMultipleLineTableViewCell.h"

@interface DetailBookMultipleLineTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *multipleLineLabel;

@end

@implementation DetailBookMultipleLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(NSString *)text size:(NSNumber *)fontSize {
    self.multipleLineLabel.text = text;
    self.multipleLineLabel.font = [UIFont systemFontOfSize:fontSize.doubleValue];
}

@end
