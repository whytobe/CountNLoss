//
//  CalorieList.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface CalorieList : NSObject

+(NSDictionary*) getAllFoodData;
+(NSDictionary*) getAllFoodDataWithCat:(NSString *)catId;
+(NSDictionary*) getCustomFoodData;
+(void) finalizeStatements;
+(NSString *) getDBPath;
+(NSString *) getMyDBPath;
+ (void) addFoodWithName:(NSString*)foodName andFoodType:(NSString*)foodType andFoodCalorie:(NSNumber*)foodCalorie andFoodStoreOrNil:(NSString*)foodStore;
+ (void) removeCustomFoodWithId:(NSNumber*)customFoodId;
+(BOOL)openDatabse;
+(void)closeDatabase;
+(BOOL)openMainDatabase;
+(void)closeMainDatabase;
@end
