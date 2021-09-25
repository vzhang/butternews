//
//  BNNewsListRequest.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNTopHeadlineListRequest.h"

@implementation BNTopHeadlineListRequest

- (NSString *)requestUrl {
    return @"/v2/top-headlines";
}

- (NSString *)country {
    if (nil == _country || _country.length == 0) {
        return @"us";
    }
    
    return _country;
}

- (id)requestArgument {
    id superArgument = [super requestArgument];
    if (![superArgument isKindOfClass:[NSDictionary class]]) {
        NSAssert(NO, @"super argument is not a dictionary. Please check it.");
    }
    
    NSMutableDictionary *dict = [[super requestArgument] mutableCopy];
    [dict setObject:self.country forKey:@"country"];
    
    return [dict copy];
}


@end
