//
//  BNEverythingRequest.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "BNEverythingRequest.h"

@implementation BNEverythingRequest

- (NSString *)requestUrl {
    return @"/v2/everything";
}


- (id)requestArgument {
    id superArgument = [super requestArgument];
    if (![superArgument isKindOfClass:[NSDictionary class]]) {
        NSAssert(NO, @"super argument is not a dictionary. Please check it.");
    }
    
    NSMutableDictionary *dict = [[super requestArgument] mutableCopy];
    [dict setObject:self.q forKey:@"q"];
    
    return [dict copy];
}

@end
