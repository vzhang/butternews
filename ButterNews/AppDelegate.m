//
//  AppDelegate.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "AppDelegate.h"
#import <YTKNetwork/YTKNetwork.h>
#import "UIApplicaton+BN.h"
#import <RealReachability/RealReachability.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"https://newsapi.org";
    
    [GLobalRealReachability startNotifier];
    GLobalRealReachability.hostForPing = @"www.google.com";
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
}


@end
