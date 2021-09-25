//
//  BNTopHeadlinesDataModel.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNArticleSourceModel : NSObject

@property (nonatomic, copy) NSString *sourceID;
@property (nonatomic, copy) NSString *name;

@end

@interface BNTopHeadlineDataModel : NSObject

@property (nonatomic, strong) BNArticleSourceModel *source;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *urlToImage;
@property (nonatomic, strong) NSDate *publishedAt;
@property (nonatomic, copy) NSString *content;


@end


@interface BNTopHeadlineListDataModel : BNDataModel

@property (nonatomic, assign) NSInteger totalResults;

@property (nonatomic, strong) NSArray<BNTopHeadlineDataModel *> *articles;

@end

NS_ASSUME_NONNULL_END
