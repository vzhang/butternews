//
//  BNFailureView.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNFailureView.h"
#import <Masonry/Masonry.h>
#import "BNErrorModel.h"

@interface BNFailureView()

@property (nonatomic, strong) UILabel *errorLabel;

@property (nonatomic, strong) UILabel *reloadLabel;

@end

@implementation BNFailureView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createViews];
        [self createViewLayouts];
        [self configureSelf];
    }
    
    return self;
}

#pragma mark - Layouts
- (void)createViews {
    [self addSubview:self.errorLabel];
    [self addSubview:self.reloadLabel];
}

- (void)createViewLayouts {
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
    }];
    
    [self.reloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
        make.top.equalTo(self.errorLabel.mas_bottom).offset(4);
    }];
}


- (void)configureSelf {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapReloadData)];
    [self.reloadLabel addGestureRecognizer:tap];
}

#pragma mark - Gestures
- (void)didTapReloadData {
    if (self.delegate && [self.delegate respondsToSelector:@selector(failureViewDidTapReloadData:)]) {
        [self.delegate failureViewDidTapReloadData:self];
    }
}

#pragma mark - Public Methods

- (void)bindError:(BNErrorModel *)error {
    NSMutableString *str = [[NSMutableString alloc] init];
    [str appendFormat:@"CODE: %@\n",error.code];
    if (nil != error.message && error.message.length > 0) {
        [str appendFormat:@"MESSAGE: %@\n", error.message];
    }
    
    self.errorLabel.text = [str copy];
}

- (void)clear {
    self.errorLabel.text = @"";
}

#pragma mark - Getters

- (UILabel *)errorLabel {
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] init];
        _errorLabel.textColor = [UIColor lightGrayColor];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.numberOfLines = 0;
    }
    
    return _errorLabel;
}

- (UILabel *)reloadLabel {
    if (!_reloadLabel) {
        _reloadLabel = [[UILabel alloc] init];
        _reloadLabel.text = @"PLEASE PULL TO REFRESH DATA";
        _reloadLabel.textColor = [UIColor lightGrayColor];
        _reloadLabel.textAlignment = NSTextAlignmentCenter;
        _reloadLabel.userInteractionEnabled = YES;
    }
    
    return _reloadLabel;
}


@end
