//
//  BNEverythingRequest.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNEverythingRequest : BNRequest

@property (nonatomic, copy) NSString *q;

//@property (nonatomic, copy) NSString *qInTitle;
//
//@property (nonatomic, strong) NSArray<NSString *> *sources;

@end

NS_ASSUME_NONNULL_END
