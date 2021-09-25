//
//  UIApplicaton+BN.m
//  ButterNews
//
//  Created by Ming Zhang on 2021/9/25.
//

#import "UIApplicaton+BN.h"

@implementation UIApplication (BN)

- (UIWindow *)bnKeyWindow {
    for (UIWindowScene *scene in [self connectedScenes]) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            for (UIWindow *window in scene.windows) {
                if (window.isKeyWindow) {
                    return window;
                }
            }
        }
    }
    
    return nil;
}
@end
