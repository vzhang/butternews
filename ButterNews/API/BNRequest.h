//
//  BNRequest.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import <YTKNetwork/YTKNetwork.h>
@class BNDataModel;
@class BNErrorModel;

NS_ASSUME_NONNULL_BEGIN

NSString* const BNRequestInvalidJSONDataError = @"BNRequestInvalidJSONDataError";
NSString *const BNRequestNetworkError = @"BNRequestNetworkError";

typedef void(^BNRequestDataBlock)(__kindof BNDataModel *data);
typedef void(^BNRequestErrorBlock)(__kindof BNErrorModel *error);

@interface BNRequest : YTKRequest

- (void)startWithData:(Class)responseClass Success:(BNRequestDataBlock)success failure:(BNRequestErrorBlock)failure;

@end

NS_ASSUME_NONNULL_END
