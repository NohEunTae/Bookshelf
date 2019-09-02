//
//  IbsnTableViewCell.h
//  BookShelf
//
//  Created by user on 31/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IsbnTableViewCell : UITableViewCell

- (void)configure:(NSString *)isbn10 isbn13:(NSString *)isbn13;

@end

NS_ASSUME_NONNULL_END
