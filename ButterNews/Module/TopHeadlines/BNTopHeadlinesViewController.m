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

NSString* const BNTopHeadlinesTableViewCellReuseIdentifier = @"BNTopHeadlinesTableViewCell";

@interface BNTopHeadlinesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<BNTopHeadlineDataModel *> *newsList;
@property (nonatomic, strong) BNTopHeadlineListRequest *topHeadlineListRequest;

@end

@implementation BNTopHeadlinesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
    [self createViewLayouts];
    [self configureSelf];
    [self.tableView.refreshControl beginRefreshing];
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
    refreshControl.tintColor = [UIColor colorWithHexString:@"#FFCA00"];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"pull to refresh"];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshControl;
    [self.tableView registerClass:[BNTopHeadlinesTableViewCell class] forCellReuseIdentifier:BNTopHeadlinesTableViewCellReuseIdentifier];
}

#pragma mark - Load Data
- (void)loadData {
    [self.newsList removeAllObjects];
    
    @weakify(self);
    [self.topHeadlineListRequest startWithData:[BNTopHeadlineListDataModel class] Success:^(__kindof BNTopHeadlineListDataModel * _Nonnull data) {
        @strongify(self);
        if (data == nil) {
            return;
        }
        
        [self.newsList addObjectsFromArray:data.articles];
        [self.tableView reloadData];
        [self.tableView.refreshControl endRefreshing];
    } failure:^(__kindof BNErrorModel * _Nonnull error) {
        @strongify(self);
        [self.tableView.refreshControl endRefreshing];
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
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BNTopHeadlinesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BNTopHeadlinesTableViewCellReuseIdentifier forIndexPath:indexPath];
    if (indexPath.row >= 0 && indexPath.row < self.newsList.count) {
        BNTopHeadlineDataModel *data = self.newsList[indexPath.row];
        [cell bindModel:data];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < 0 && indexPath.row >= self.newsList.count) {
        return;
    }
    
    BNTopHeadlineDataModel *data = self.newsList[indexPath.row];
    if (nil == data.url || data.url.length == 0) {
        // TODO alert
        return;
    }

    BNNewsDetailViewController *detailViewController = [[BNNewsDetailViewController alloc] init];
    detailViewController.newsURL = data.url;
    [self.navigationController pushViewController:detailViewController animated:YES];
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

- (BNTopHeadlineListRequest *)topHeadlineListRequest {
    if (!_topHeadlineListRequest) {
        _topHeadlineListRequest = [[BNTopHeadlineListRequest alloc] init];
    }
    
    return _topHeadlineListRequest;
}

@end
