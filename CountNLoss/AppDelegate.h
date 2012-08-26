//
//  AppDelegate.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/17/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountAndLoss.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *foodNavigationController;
@property (strong, nonatomic) UINavigationController *moreNavigationController;
@property ( nonatomic) NSDictionary *foodArray;
@property ( nonatomic) NSDictionary *historyArray;
@property (nonatomic) CountAndLoss *myProfile;
- (void)reloadHistory;
- (void)reloadProfile;
@end
