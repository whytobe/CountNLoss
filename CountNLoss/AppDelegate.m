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
@synthesize moreNavigationController = _moreNavigationController;
@synthesize historyNavigationController = _historyNavigationController;
@synthesize todayNavigationController = _todayNavigationController;
@synthesize foodArray,historyArray,myProfile;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self copyDatabaseIfNeeded];
    myProfile = [CountAndLoss initCountAndLoss];
    //NSLog(@"%@",myProfile);
    UIImage *navigationBG = [[UIImage imageNamed:@"header"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,0,0)];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[UIColor grayColor],UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 0)],UITextAttributeTextShadowOffset,[UIFont fontWithName:@"BerlinSansFBDemi-Bold" size:24],UITextAttributeFont , nil]];
    [[UINavigationBar appearance] setBackgroundImage:navigationBG forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:0.42 green:0.72  blue:.05 alpha:1]];
    //Add Comment to master1.
    self.foodArray = [NSDictionary dictionaryWithDictionary:[CalorieList getAllFoodData]];
    //[self reloadHistory];
    //NSLog(@"%@",self.foodArray);
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *foodViewController = [[FoodCategoryViewController alloc] initWithNibName:@"FoodCategoryViewController" bundle:nil];
    UIViewController *goalViewController = [[GoalViewController alloc] initWithNibName:@"GoalViewController" bundle:nil];
    UIViewController *historyViewController = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    UIViewController *moreViewController = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    UIViewController *todayViewController = [[FoodViewController alloc] initWithNibName:@"FoodViewController" bundle:nil];

    self.tabBarController = [[UITabBarController alloc] init];
    [[self.tabBarController tabBar] setBackgroundImage:[UIImage imageNamed:@"bgTab"]];
    [[self.tabBarController tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"indicator"]];
    [[self.tabBarController tabBar] setSelectedImageTintColor:[UIColor whiteColor]];
    [[self.tabBarController tabBar] setTintColor:[UIColor colorWithRed:0.09 green:0.17 blue:0.015 alpha:1]];
    
    self.foodNavigationController = [[UINavigationController alloc]initWithRootViewController:foodViewController];    
    self.moreNavigationController = [[UINavigationController alloc]initWithRootViewController:moreViewController];
    self.historyNavigationController = [[UINavigationController alloc]initWithRootViewController:historyViewController];
    self.todayNavigationController = [[UINavigationController alloc]initWithRootViewController:todayViewController];

    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:[self foodNavigationController], [self todayNavigationController],[self historyNavigationController],goalViewController,[self moreNavigationController], nil];
    self.window.rootViewController = self.tabBarController;
    
    self.tabBarController.selectedIndex = 1;
    
    [self.window makeKeyAndVisible];
    
    

    //NSLog(@"Food Array : %@",self.foodArray);
    //NSLog(@"History Array : %@",self.historyArray);
    
    return YES;
}

- (void)reloadHistory{
    self.historyArray = [CalorieHistory getFoodHistoryToday];
    //NSLog(@"%@",[self historyArray]);
}

- (void)reloadProfile{
    self.myProfile = [CountAndLoss initCountAndLoss];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
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
	return [documentsDir stringByAppendingPathComponent:@"fooddb.sqlite"];
}

- (NSString *) getHistoryDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"history.sqlite"];
}

- (NSString *) getMyDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"mydb.sqlite"];
}

- (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
    //Create Food Database if doesn't exist.
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"fooddb.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) {
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            NSLog(@"Failed to create writable database file with message '%@'.",dbPath);
        } else {
             NSLog(@"Copied : '%@'.",dbPath);
        }
        
	}
    //Create History Database if doesn't exist.
    dbPath = [self getHistoryDBPath];
    success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"history.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) {
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            NSLog(@"Failed to create writable database file with message '%@'.",dbPath);
        } else {
            NSLog(@"Copied : '%@'.",dbPath);
        }
        
	}
    
    
    //Create Custom Food Database if doesn't exist.
    dbPath = [self getMyDBPath];
    success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"mydb.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) {
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            NSLog(@"Failed to create writable database file with message '%@'.",dbPath);
        } else {
            NSLog(@"Copied : '%@'.",dbPath);
        }
        
	}
    
}



@end
