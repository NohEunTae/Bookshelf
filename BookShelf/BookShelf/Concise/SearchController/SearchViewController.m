//
//  SearchViewController.m
//  BookShelf
//
//  Created by user on 02/09/2019.
//  Copyright © 2019 user. All rights reserved.
//

#import "SearchViewController.h"
#import "PagingTableViewPresenter.h"
#import "NetworkManager.h"
#import "DetailViewController.h"
#import "Book.h"

@interface SearchViewController () <TableViewPresenterDelegate, PagingTableViewPresenterDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchResultTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic) PagingTableViewPresenter *presenter;
@property (nonatomic) NSString *baseUrl;
@property (nonatomic) NSNumber *currentPage;
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation SearchViewController

- (instancetype)init {
    self = [super initWithNibName:@"SearchViewController" bundle:nil];
    if (self) {
        _presenter = [[PagingTableViewPresenter alloc] init];
        _baseUrl = @"https://api.itbook.store/1.0/search";
        _currentPage = [[NSNumber alloc] initWithInt:1];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResultTableView.dataSource = self.presenter;
    self.searchResultTableView.delegate = self.presenter;
    self.searchResultTableView.prefetchDataSource = self.presenter;
    self.presenter.pagingDelegate = self;
    self.presenter.delegate = self;
    UINib *nibCell = [UINib nibWithNibName:@"BookTableViewCell" bundle:nil];
    [self.searchResultTableView registerNib:nibCell forCellReuseIdentifier:@"BookTableViewCell"];

    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.navigationItem setSearchController:searchController];
    [self setDefinesPresentationContext:YES];
    [self.navigationItem.searchController.searchBar setDelegate:self];
    [self.navigationItem setHidesSearchBarWhenScrolling:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}


- (void)fetchNewBooks:(NSString *)text withCompletionBlock:(nullable void (^)(void))completionBlock {
    NSString *totalUrl = [NSString stringWithFormat:@"%@/%@/%@", self.baseUrl, text, self.currentPage];
    [NetworkManager.sharedInstance requestGetWithUrl:totalUrl with:nil withCompletionBlock:^(NetworkResult result, id  __nullable data) {
        switch (result) {
            case Success: {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data == nil) return;
                    NSArray<NSDictionary *> *bookDic = data[@"books"];
                    for (int i = 0; i < bookDic.count; i++) {
                        [self.presenter.dataSource addObject: [[Book alloc] initWithDictionary:bookDic[i]]];
                    }
                    [self.indicator stopAnimating];
                    [self.searchResultTableView setContentOffset:self.searchResultTableView.contentOffset animated:NO];
                    [self.searchResultTableView reloadData];
                    
                    NSError *error = nil;
                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.presenter.dataSource requiringSecureCoding:YES error:&error];
                    
                    if (error) {
                        NSLog(@"%@", error.localizedDescription);
                    }
                    
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:totalUrl];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    if (completionBlock != nil) completionBlock();
                });
                break;
            }
            case Fail: {
                NSLog(@"[info] ... Network Connect Failed");
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:totalUrl];
                    NSError *error = nil;
                    
                    NSArray<Book *> *object = [NSKeyedUnarchiver unarchivedObjectOfClasses:[[NSSet alloc] initWithObjects:NSArray.self, Book.self, nil] fromData:data error:&error];
                    
                    if (error) {
                        NSLog(@"%@", error.localizedDescription);
                        return;
                    }
                    [self.indicator stopAnimating];
                    [self.presenter.dataSource addObjectsFromArray:object];
                    [self.searchResultTableView reloadData];
                    if (completionBlock != nil) completionBlock();
                });
                break;
            }
        }
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.currentPage = [[NSNumber alloc] initWithInt:1];
        self.presenter.dataSource = [[NSMutableArray alloc] init];
        [self.searchResultTableView reloadData];
    });
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self.timer invalidate];
    self.timer = nil;

    if ([searchText isEqualToString:@""]) {
        [self.indicator stopAnimating];
        return;
    }

    [self.indicator startAnimating];
    self.presenter.dataSource = [[NSMutableArray alloc] init];
    self.currentPage = [[NSNumber alloc] initWithInt:1];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self fetchNewBooks:searchText withCompletionBlock:^{
            [self.navigationItem.searchController.searchBar resignFirstResponder];
        }];
    }];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationItem.searchController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)tableViewCellSelected:(nonnull NSString *)isbn13 { 
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithIsbn13:isbn13];
    [self.navigationController pushViewController:detailViewController animated:true];
}

- (void)requestNextPage {
    self.currentPage = [[NSNumber alloc] initWithInt:(int)self.currentPage.integerValue + 1];
    [self fetchNewBooks:self.navigationItem.searchController.searchBar.text withCompletionBlock:nil];
}

@end
