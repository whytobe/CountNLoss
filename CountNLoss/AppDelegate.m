//
//  AppDelegate.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/17/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "AppDelegate.h"

#import "FoodViewController.h"
#import "GoalViewController.h"
#import "HistoryViewController.h"
#import "MoreViewController.h"
#import "TodayViewController.h"

#import "CalorieList.h"
#import "CalorieHistory.h"
@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize foodNavigationController = _foodNavigationController;
@synthesize foodArray,historyArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self copyDatabaseIfNeeded];
    //Add Comment to master1.
    self.foodArray = [NSDictionary dictionaryWithDictionary:[CalorieList getAllFoodData:[self getDBPath]]];
    self.historyArray = [NSArray arrayWithArray:[CalorieHistory getFoodHistory:[self getDBPath]]];
    //NSLog(@"%@",self.foodArray);
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *foodViewController = [[FoodViewController alloc] initWithNibName:@"FoodViewController" bundle:nil];
    UIViewController *goalViewController = [[GoalViewController alloc] initWithNibName:@"GoalViewController" bundle:nil];
    UIViewController *historyViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    UIViewController *moreViewController = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    UIViewController *todayViewController = [[TodayViewController alloc] initWithNibName:@"TodayViewController" bundle:nil];

    self.tabBarController = [[UITabBarController alloc] init];
    [[self.tabBarController tabBar] setBackgroundImage:[UIImage imageNamed:@"bgTab"]];
    [[self.tabBarController tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"indicator"]];
    [[self.tabBarController tabBar] setSelectedImageTintColor:[UIColor whiteColor]];
    [[self.tabBarController tabBar] setTintColor:[UIColor colorWithRed:0.09 green:0.17 blue:0.015 alpha:1]];
    
    self.foodNavigationController = [[UINavigationController alloc]initWithRootViewController:foodViewController];
    UIImage *navigationBG = [[UIImage imageNamed:@"header"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,0)];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIColor grayColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"BerlinSansFBDemi-Bold" size:24],UITextAttributeFont , nil]];
    [[UINavigationBar appearance] setBackgroundImage:navigationBG forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:0.42 green:0.72  blue:.05 alpha:1]];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:self.foodNavigationController, todayViewController,historyViewController,goalViewController,moreViewController, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
    
    //NSLog(@"Food Array : %@",self.foodArray);
    //NSLog(@"History Array : %@",self.historyArray);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

- (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"countnlose.sqlite"];
}
- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"countnlose.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
    
}



@end
