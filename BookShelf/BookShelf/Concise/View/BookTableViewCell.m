//
//  BookTableViewCell.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "BookTableViewCell.h"
#import "NetworkManager.h"
#import "Book.h"

@interface BookTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *isbn13;
@property (weak, nonatomic) IBOutlet UILabel *url;


@end

@implementation BookTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configure:(Book *)book {
    self.title.text = book.title;
    self.subtitle.text = book.subtitle;
    self.price.text = book.price;
    self.isbn13.text = book.isbn13;
    self.url.text = book.url;
    if (book.imageData != nil) {
        UIImage *img = [UIImage imageWithData:book.imageData];
        [self.bookImageView setImage:img];
    }
    [self setNeedsLayout];
}

@end
