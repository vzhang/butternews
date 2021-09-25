//
//  BNBaseViewController.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "BNErrorModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNBaseViewController : UIViewController

- (void)hideFailure;
- (void)showFailure:(BNErrorModel *)error;

- (void)showLoading;
- (void)hideLoading;

// if tap reload data
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
