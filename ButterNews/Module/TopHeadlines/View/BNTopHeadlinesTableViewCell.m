//
//  BNTopHeadlinesTableViewCell.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNTopHeadlinesTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import <YYKit/YYKit.h>

@interface BNTopHeadlinesTableViewCell ()

@property (nonatomic, strong) UIImageView *thumbImageView;
@property (nonatomic, strong) UILabel *newsTitleLabel;
@property (nonatomic, strong) UILabel *newsDescLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *publishDateLabel;

@end

@implementation BNTopHeadlinesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createViews];
        [self createViewLayouts];
        [self configureSelf];
    }
    
    return self;
}

- (void)createViews {
    [self.contentView addSubview:self.thumbImageView];
    [self.contentView addSubview:self.newsTitleLabel];
    [self.contentView addSubview:self.newsDescLabel];
    [self.contentView addSubview:self.authorLabel];
//    [self.contentView addSubview:self.publishDateLabel];
}

- (void)createViewLayouts {
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(-15));
        make.top.equalTo(@(10));
        make.height.equalTo(self.thumbImageView.mas_width).multipliedBy(365.0/650.0);
    }];
    
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumbImageView);
        make.right.equalTo(self.thumbImageView);
        make.top.equalTo(self.thumbImageView.mas_bottom).offset(10);
    }];

    [self.newsDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.newsTitleLabel);
        make.right.equalTo(self.newsTitleLabel);
        make.top.equalTo(self.newsTitleLabel.mas_bottom).offset(4);
    }];

    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.newsDescLabel);
        make.top.equalTo(self.newsDescLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-4);
    }];

//    [self.publishDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.newsDescLabel);
//        make.top.equalTo(self.authorLabel);
//    }];
}

- (void)configureSelf {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma  mark - Public Methods
- (void)bindModel:(BNTopHeadlineDataModel *)model {
    if (nil != model.urlToImage && model.urlToImage.length > 0) {
        [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:model.urlToImage] placeholderImage:nil];
    }
    
    self.newsTitleLabel.text = model.title;
    self.newsDescLabel.text = model.desc;
    self.authorLabel.text = model.author;
//    self.publishDateLabel.text = [model.publishedAt stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    
//    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (UIImageView *)thumbImageView {
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
    }
    
    return _thumbImageView;
}

- (UILabel *)newsTitleLabel {
    if (!_newsTitleLabel) {
        _newsTitleLabel = [[UILabel alloc] init];
        _newsTitleLabel.font = [UIFont  boldSystemFontOfSize:17.0];
        _newsTitleLabel.numberOfLines = 0;
    }
    
    return _newsTitleLabel;
}

- (UILabel *)newsDescLabel {
    if (!_newsDescLabel) {
        _newsDescLabel = [[UILabel alloc] init];
        _newsDescLabel.font = [UIFont systemFontOfSize:14.0];
        _newsDescLabel.textColor = [UIColor lightGrayColor];
        _newsDescLabel.numberOfLines = 0;
    }
    
    return _newsDescLabel;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:14.0];
        _authorLabel.textColor = [UIColor lightGrayColor];
    }
    
    return _authorLabel;
}

- (UILabel *)publishDateLabel {
    if (!_publishDateLabel) {
        _publishDateLabel = [[UILabel alloc] init];
        _publishDateLabel.textAlignment = NSTextAlignmentRight;
        _publishDateLabel.font = [UIFont systemFontOfSize:14.0];
        _publishDateLabel.textColor = [UIColor lightGrayColor];
    }
    
    return _publishDateLabel;
}

@end
