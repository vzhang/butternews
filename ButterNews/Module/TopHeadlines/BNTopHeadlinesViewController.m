//
//  BNTopHeadlinesViewController.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNTopHeadlinesViewController.h"
#import "BNTopHeadlineListRequest.h"
#import "BNTopHeadlineListDataModel.h"
#import "BNTopHeadlinesTableViewCell.h"
#import <YYKit/YYKit.h>
#import "BNNewsDetailViewController.h"
#import "Color.h"
#import "BNEverythingRequest.h"

NSString* const BNTopHeadlinesTableViewCellReuseIdentifier = @"BNTopHeadlinesTableViewCell";

@interface BNTopHeadlinesViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<BNTopHeadlineDataModel *> *newsList;
@property (nonatomic, strong) NSMutableArray<BNTopHeadlineDataModel *> *searchNewsList;
@property (nonatomic, strong) BNTopHeadlineListRequest *topHeadlineListRequest;
@property (nonatomic, strong) BNEverythingRequest *searchNewsListRequest;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation BNTopHeadlinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
    [self createViewLayouts];
    [self configureSelf];
    
    [self loadData];
//    [self loadTestData];
}

#pragma mark - Layouts
- (void)createViews {
    [self.view addSubview:self.tableView];
}

- (void)createViewLayouts {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)configureSelf {
    self.title = @"ButterNews";
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = kBNPrimaryColor;
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"pull to refresh"];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.refreshControl = refreshControl;
    [self.tableView registerClass:[BNTopHeadlinesTableViewCell class] forCellReuseIdentifier:BNTopHeadlinesTableViewCellReuseIdentifier];
    
    self.definesPresentationContext = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Load Data
- (void)loadData {
    [self.newsList removeAllObjects];
    
    [self showLoading];
    @weakify(self);
    [self.topHeadlineListRequest startWithData:[BNTopHeadlineListDataModel class] Success:^(__kindof BNTopHeadlineListDataModel * _Nonnull data) {
        @strongify(self);
        if (nil == data) {
            return;
        }
        
        [self.newsList addObjectsFromArray:data.articles];
        [self.tableView reloadData];
        [self.tableView.refreshControl endRefreshing];
        [self hideLoading];
    } failure:^(__kindof BNErrorModel * _Nonnull error) {
        @strongify(self);
        [self.tableView.refreshControl endRefreshing];
        [self showFailure:error];
        [self hideLoading];
    }];
}

- (void)reloadData {
    [self hideFailure];
    [self loadData];
}

- (void)SearchNewsData {
    [self.searchNewsList removeAllObjects];
    [self showLoading];
    @weakify(self);
    [self.searchNewsListRequest startWithData:[BNTopHeadlineListDataModel class] Success:^(__kindof BNTopHeadlineListDataModel * _Nonnull data) {
        @strongify(self);
        if (nil == data) {
            return;
        }
        
        [self.searchNewsList addObjectsFromArray:data.articles];
        [self.tableView reloadData];
        [self hideLoading];
        } failure:^(__kindof BNErrorModel * _Nonnull error) {
            @strongify(self);
            [self showFailure:error];
            [self hideLoading];
        }];
}

#pragma mark - Test Data
- (void)loadTestData {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSString *str = [[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:NULL];
    BNTopHeadlineListDataModel *data = [BNTopHeadlineListDataModel modelWithJSON:str];
    [self.newsList addObjectsFromArray:data.articles];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return self.searchNewsList.count;
    }
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BNTopHeadlinesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BNTopHeadlinesTableViewCellReuseIdentifier forIndexPath:indexPath];
    NSMutableArray *newsList = self.newsList;
    
    if (self.searchController.active) {
        newsList = self.searchNewsList;
    }
    
    if (indexPath.row >= 0 && indexPath.row < newsList.count) {
        BNTopHeadlineDataModel *data = newsList[indexPath.row];
        [cell bindModel:data];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *newsList = self.newsList;
    
    if (self.searchController.active) {
        newsList = self.searchNewsList;
    }
    
    if (indexPath.row < 0 && indexPath.row >= newsList.count) {
        return;
    }
    
    BNTopHeadlineDataModel *data = newsList[indexPath.row];
    if (nil == data.url || data.url.length == 0) {
        // TODO alert
        return;
    }

    BNNewsDetailViewController *detailViewController = [[BNNewsDetailViewController alloc] init];
    detailViewController.newsURL = data.url;
    [self.navigationController pushViewController:detailViewController animated:YES];
}


#pragma mark - UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // search text
    self.searchNewsListRequest.q = searchBar.text;
    if (!self.searchController.active) {
        return ;
    }
    if (nil == self.searchNewsListRequest.q || self.searchNewsListRequest.q.length == 0) {
        return;
    }
    [self SearchNewsData];
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    if (!searchController.active) {
        [self.tableView reloadData];
    }
}


#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (NSMutableArray<BNTopHeadlineDataModel *> *)newsList {
    if (!_newsList) {
        _newsList = [[NSMutableArray<BNTopHeadlineDataModel *> alloc] init];
    }
    
    return _newsList;
}

- (NSMutableArray<BNTopHeadlineDataModel *> *)searchNewsList {
    if (!_searchNewsList) {
        _searchNewsList = [[NSMutableArray<BNTopHeadlineDataModel *> alloc] init];
    }
    
    return _searchNewsList;
}

- (BNTopHeadlineListRequest *)topHeadlineListRequest {
    if (!_topHeadlineListRequest) {
        _topHeadlineListRequest = [[BNTopHeadlineListRequest alloc] init];
    }
    
    return _topHeadlineListRequest;
}

- (BNEverythingRequest *)searchNewsListRequest {
    if (!_searchNewsListRequest) {
        _searchNewsListRequest = [[BNEverythingRequest alloc] init];
    }
    
    return _searchNewsListRequest;
}


- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        _searchController.obscuresBackgroundDuringPresentation = NO;
        _searchController.searchBar.placeholder = @"Please input...";
    }
    
    return _searchController;
}

@end
