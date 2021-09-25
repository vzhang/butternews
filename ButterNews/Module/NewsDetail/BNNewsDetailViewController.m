//
//  BNNewsDetailViewController.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNNewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import <YYKit/YYKit.h>
#import "UIApplicaton+BN.h"

@interface BNNewsDetailViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation BNNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
    [self createViewLayouts];
    [self configureSelf];    
}

#pragma mark - Layouts
- (void)createViews {
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
}

- (void)createViewLayouts {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 获取导航条和状态栏的高度
    CGFloat statusHeight = [UIApplication sharedApplication].bnKeyWindow.safeAreaInsets.top;
//    CGFloat statusHeight = [UIApplication sharedApplication].bnKeyWindow.windowScene.statusBarManager.statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(0));
        make.top.equalTo(self.view).offset(statusHeight+navHeight);
        make.height.equalTo(@2);
    }];
}

- (void)configureSelf {
    self.title = @"Butter News";
    if (nil == self.newsURL || self.newsURL.length == 0) {
        return;
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.newsURL]]];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            @weakify(self);
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                @strongify(self);
                self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                @strongify(self);
                self.progressView.hidden = YES;
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:keyPath change:change context:context];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.progressView.hidden = NO;
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view bringSubviewToFront:self.progressView];
}

#pragma mark - Getters

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.tintColor = [UIColor colorWithHexString:@"#FFCA00"];
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
    
    return _progressView;
}

@end
