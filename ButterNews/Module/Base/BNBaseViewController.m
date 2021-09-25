//
//  BNBaseViewController.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNBaseViewController.h"
#import "BNFailureView.h"
#import <RealReachability/RealReachability.h>

@interface BNBaseViewController ()<BNFailureViewDelegate>

@property (nonatomic, strong) BNFailureView *failureView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;


@end

@implementation BNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self configureSelf];
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (void)reloadData{
    
}
//
//- (void)configureSelf {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(networkChanged:)
//                                                     name:kRealReachabilityChangedNotification
//                                                   object:nil];
//}

//#pragma mark - Notification
//
//- (void)networkChanged:(NSNotification *)notification {
//    RealReachability *reachability = (RealReachability *)notification.object;
//    ReachabilityStatus status = [reachability currentReachabilityStatus];
//    NSLog(@"currentStatus:%@",@(status));
//}

#pragma mark - Public Methods
- (void)showFailure:(BNErrorModel *)error {
    if (nil == self.failureView.superview) {
        [self.view addSubview:self.failureView];
        [self.failureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    self.failureView.hidden = NO;
    [self.view bringSubviewToFront:self.failureView];
    [self.failureView bindError:error];
}

- (void)hideFailure {
    self.failureView.hidden = YES;
    [self.view sendSubviewToBack:self.failureView];
    [self.failureView clear];
}

- (void)showLoading {
    if (nil == self.indicatorView.superview) {
        [self.view addSubview:self.indicatorView];
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    
    self.indicatorView.hidden = NO;
    [self.indicatorView startAnimating];
    [self.view bringSubviewToFront:self.indicatorView];
}

- (void)hideLoading {
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden = YES;
    [self.view sendSubviewToBack:self.indicatorView];
}

#pragma mark - BNFailureViewDelegate

- (void)failureViewDidTapReloadData:(BNFailureView *)view {
    [self reloadData];
}

#pragma mark - Getters
- (BNFailureView *)failureView {
    if (!_failureView) {
        _failureView = [[BNFailureView alloc] init];
        _failureView.delegate = self;
        _failureView.userInteractionEnabled = YES;
        _failureView.hidden = YES;
        _failureView.backgroundColor = [UIColor whiteColor];
    }
    
    return _failureView;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    }
    
    return _indicatorView;
}

@end
