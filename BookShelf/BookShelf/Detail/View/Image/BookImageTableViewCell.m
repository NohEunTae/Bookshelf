//
//  BookImageTableViewCell.m
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "BookImageTableViewCell.h"
#import "NetworkManager.h"

@interface BookImageTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;

@end

@implementation BookImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure:(NSString *)url {
    [NetworkManager.sharedInstance downloadImageWithUrl:url withCompletionBlock:^(NetworkResult result, id  _Nullable data) {
        switch (result) {
            case Success: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *img = [UIImage imageWithData:data];
                    [self.bookImageView setImage:img];
                    [self setNeedsLayout];
                });
                break;
            }
            case Fail:
                break;
        }
    }];

}

@end
