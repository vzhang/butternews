//
//  BNTopHeadlinesDataModel.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNTopHeadlineListDataModel.h"

@implementation BNArticleSourceModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"sourceID" : @"id"};
}

@end


@implementation BNTopHeadlineDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"source" : [BNArticleSourceModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}

@end


@implementation BNTopHeadlineListDataModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"articles" : [BNTopHeadlineDataModel class]};
}

@end
