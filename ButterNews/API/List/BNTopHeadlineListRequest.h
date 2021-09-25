//
//  BNNewsListRequest.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNTopHeadlineListRequest : BNRequest

@property (nonatomic, copy) NSString *country;

//@property (nonatomic, assign) NSInteger pageSize;
//
//@property (nonatomic, assign) NSInteger page;

@end

NS_ASSUME_NONNULL_END
