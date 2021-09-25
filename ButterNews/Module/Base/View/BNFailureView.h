//
//  BNFailureView.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BNFailureView;
@protocol BNFailureViewDelegate<NSObject>

- (void)failureViewDidTapReloadData:(BNFailureView *)view;

@end

@class BNErrorModel;
@interface BNFailureView : UIView

@property (nonatomic, weak) id<BNFailureViewDelegate> delegate;

- (void)bindError:(BNErrorModel *)error;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
