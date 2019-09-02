//
//  NewViewController.m
//  BookShelf
//
//  Created by user on 30/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "NewViewController.h"
#import "TableViewPresenter.h"
#import "NetworkManager.h"
#import "DetailViewController.h"

@interface NewViewController () <TableViewPresenterDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bookTableView;
@property (nonatomic) TableViewPresenter *presenter;

@end

@implementation NewViewController

- (instancetype)init {
    self = [super initWithNibName:@"NewViewController" bundle:nil];
    if (self) {
        _presenter = [[TableViewPresenter alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.tabBarItem.title = @"New";
    self.navigationController.navigationBarHidden = YES;
    self.bookTableView.dataSource = self.presenter;
    self.bookTableView.delegate = self.presenter;
    self.presenter.delegate = self;
    UINib *nibCell = [UINib nibWithNibName:@"BookTableViewCell" bundle:nil];
    [self.bookTableView registerNib:nibCell forCellReuseIdentifier:@"BookTableViewCell"];

    [self fetchNewBooks];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)fetchNewBooks {
    [NetworkManager.sharedInstance requestGetWithUrl:@"https://api.itbook.store/1.0/new" with:nil withCompletionBlock:^(NetworkResult result, id  _Nonnull data) {
        
        switch (result) {
            case Success: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray<NSDictionary *> *bookDic = data[@"books"];
                    for (int i = 0; i < bookDic.count; i++) {
                        [self.presenter.dataSource addObject: [[Book alloc] initWithDictionary:bookDic[i]]];
                    }
                    [self.bookTableView reloadData];
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

- (void)tableViewCellSelected:(nonnull NSString *)isbn13 {
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithIsbn13:isbn13];
    [self.navigationController pushViewController:detailViewController animated:true];
}

@end
