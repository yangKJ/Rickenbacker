//
//  CTMediator+HandyTools.h
//  CTMediator
//
//  Created by casa on 2020/3/10.
//  Copyright © 2020 casa. All rights reserved.
//

#if TARGET_OS_IOS

#import "CTMediator.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (HandyTools)

- (UIViewController * _Nullable)topViewController;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ _Nullable )(void))completion;

@end

NS_ASSUME_NONNULL_END

#endif
