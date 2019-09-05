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
#import "CachingManager.h"
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
                self.presenter.dataSource = [[DetailBook alloc] initWithDictionary:data];
                [self.detailBookTableView reloadData];
                [CachingManager.sharedInstance archivedDataWithRootObject:self.presenter.dataSource forKey:self.isbn13];
                break;
            }
            case Fail: {
                NSLog(@"[info] ... Network Connect Failed");
                DetailBook *cachedData = [CachingManager.sharedInstance unarchivedObjectOfClass:DetailBook.self forKey:self.isbn13];
                
                if (cachedData != nil) {
                    self.presenter.dataSource = [cachedData copy];
                    
                    NSLog(@"엥 : %@", cachedData.image);
                    [self.detailBookTableView reloadData];
                }
                break;
            }
        }
    }];
}


@end
