//
//  PurchaseUrlTableViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "PurchaseUrlTableViewCell.h"

@interface PurchaseUrlTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *purchaseUrl;

@end

@implementation PurchaseUrlTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(NSString *)url tapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
    self.purchaseUrl.text = url;
    [self.purchaseUrl addGestureRecognizer:tapGestureRecognizer];
}

@end
