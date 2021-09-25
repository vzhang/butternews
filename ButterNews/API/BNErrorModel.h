//
//  BNErrorModel.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNErrorModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) YTKBaseRequest *request;

@end

NS_ASSUME_NONNULL_END
