//
//  BNTopHeadlinesTableViewCell.h
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import <UIKit/UIKit.h>

#import "BNTopHeadlineListDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNTopHeadlinesTableViewCell : UITableViewCell

- (void)bindModel:(BNTopHeadlineDataModel *)model;

@end

NS_ASSUME_NONNULL_END
