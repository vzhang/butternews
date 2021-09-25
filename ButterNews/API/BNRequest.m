//
//  BNRequest.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNRequest.h"
#import "BNErrorModel.h"
#import "BNDataModel.h"
#import <YYKit/YYKit.h>
#import "Third.h"

@implementation BNRequest

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
//    return @{@"apiKey": @"d8a623e7fb1b4befbb922bf32364af7a"};
    return @{@"apiKey": NewsAPIKey};
}

- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure {
    return [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary *result = [request responseJSONObject];
        // if response doesn't contains `status`, return failure
        if (![result.allKeys containsObject:@"status"]) {
            return failure(request);
        }
        // get status value
        
        // if `status` is not a class of NSString, return failure
        if (![result[@"status"] isKindOfClass:[NSString class]]) {
            return failure(request);
        }
        
        NSString *status = result[@"status"];
        if ([status isEqualToString:@"ok"]) {
            return success(request);
        }
        
        return failure(request);
        
    } failure:^(__kindof YTKBaseRequest *request) {
        failure(request);
    }];
}

- (void)startWithData:(Class)responseClass Success:(BNRequestDataBlock)success failure:(BNRequestErrorBlock)failure {
    return [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSDictionary *result = [request responseJSONObject];
        // if response doesn't contains `status`, return failure
        if (![result.allKeys containsObject:@"status"]) {
            BNErrorModel *error = [[BNErrorModel alloc] init];
            error.code = BNRequestInvalidJSONDataError;
            error.request = request;
            return failure(error);
        }
        // get status value
        
        // if `status` is not a class of NSString, return failure
        if (![result[@"status"] isKindOfClass:[NSString class]]) {
            BNErrorModel *error = [[BNErrorModel alloc] init];
            error.code = BNRequestInvalidJSONDataError;
            error.request = request;
            return failure(error);
        }
        
        NSString *status = result[@"status"];
        if ([status isEqualToString:@"ok"]) {
            id data = [responseClass modelWithDictionary:result];
            return success(data);
        }
        
        // business error
        BNErrorModel *error = [BNErrorModel modelWithDictionary:result];
        error.request = request;
        return failure(error);
        
    } failure:^(__kindof YTKBaseRequest *request) {
        BNErrorModel *error = [[BNErrorModel alloc] init];
        error.code = BNRequestNetworkError;
        error.request = request;
        failure(error);
    }];
}



@end
