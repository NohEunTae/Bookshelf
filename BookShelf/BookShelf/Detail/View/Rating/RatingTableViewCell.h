//
//  RatingTableViewCell.h
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RatingTableViewCell : UITableViewCell

- (void)configure:(NSNumber *)rating price:(NSString *)price;

@end

NS_ASSUME_NONNULL_END
