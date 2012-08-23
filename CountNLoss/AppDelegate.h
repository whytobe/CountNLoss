//
//  AppDelegate.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/17/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *foodNavigationController;
@property ( nonatomic) NSDictionary *foodArray;
@property ( nonatomic) NSArray *historyArray;

- (void)reloadHistory;
@end
