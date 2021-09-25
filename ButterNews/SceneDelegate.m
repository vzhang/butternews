//
//  SceneDelegate.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "SceneDelegate.h"
#import "BNTopHeadlinesViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface SceneDelegate ()

@property (nonatomic, assign) NSInteger networkStatus;

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    BNTopHeadlinesViewController *topHeadlinesViewController = [[BNTopHeadlinesViewController alloc] init];
    UINavigationController *topHeadlinesNavController = [[UINavigationController alloc] initWithRootViewController:topHeadlinesViewController];
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    tabBarController.viewControllers = @[topHeadlinesNavController];
//    self.window.rootViewController = tabBarController;
    
//    self.networkStatus = -1;
    
//    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
//    reach.reachableBlock = ^(Reachability *reach) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.networkStatus == -1 || self.networkStatus == 1) {
//                return;
//            }
//
//            self.networkStatus = 1;
//
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.detailsLabel.text = @"Reconnected Intenet";
//            [hud hideAnimated:YES afterDelay:1.0];
//        });
//    };
//
//    reach.unreachableBlock = ^(Reachability *reach) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (self.networkStatus == 0) {
//                return;
//            }
//            self.networkStatus = 0;
//
//            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//            hud.mode = MBProgressHUDModeText;
//            hud.detailsLabel.text = @"No Intenet";
//            [hud hideAnimated:YES afterDelay:1.0];
//        });
//    };
//    [reach startNotifier];
    
    self.window.rootViewController = topHeadlinesNavController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
