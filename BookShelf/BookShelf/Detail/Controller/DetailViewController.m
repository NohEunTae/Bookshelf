//
//  DetailViewController.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "DetailViewController.h"
#import "NetworkManager.h"
#import "DetailBook.h"
#import "DetailBookPresenter.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *detailBookTableView;
@property(nonatomic) NSString *isbn13;
@property(nonatomic) DetailBookPresenter *presenter;
@property (nonatomic) NSArray<NSString *> *cellReuseIdentifiers;
@end

@implementation DetailViewController

- (instancetype)initWithIsbn13: (NSString *)isbn13 {
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    if (self) {
        _isbn13 = isbn13;
        _presenter = [[DetailBookPresenter alloc] init];
        _cellReuseIdentifiers = [[NSArray alloc] initWithObjects:
                                 @"BookImageTableViewCell", @"DetailBookMultipleLineTableViewCell",
                                 @"RatingTableViewCell", @"CollectionTableViewCell", @"DescriptionTableViewCell",
                                 @"PurchaseUrlTableViewCell", @"IsbnTableViewCell", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailBookTableView.dataSource = self.presenter;
    self.detailBookTableView.delegate = self.presenter;
    
    self.navigationController.navigationBarHidden = NO;
    [self.tabBarController.tabBar setHidden:YES];
    
    for (int i = 0; i < self.cellReuseIdentifiers.count; i++) {
        [self.detailBookTableView
         registerNib:[UINib nibWithNibName:self.cellReuseIdentifiers[i] bundle:nil]
         forCellReuseIdentifier:self.cellReuseIdentifiers[i]];
    }
    
    [self fetchDetailBook];
}

- (void)fetchDetailBook {
    NSString *url = [[NSString alloc] initWithFormat:@"https://api.itbook.store/1.0/books/%@", self.isbn13];
    [NetworkManager.sharedInstance requestGetWithUrl:url with:nil withCompletionBlock:^(NetworkResult result, id  _Nonnull data) {
        switch (result) {
            case Success: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.presenter.dataSource = [[DetailBook alloc] initWithDictionary:data];                    
                    [self.detailBookTableView reloadData];
                });
                break;
            }
            case Fail: {
                NSLog(@"[info] ... Network Connect Failed");
                break;
            }
        }
    }];
}


@end
