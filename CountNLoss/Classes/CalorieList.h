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
+(void) finalizeStatements;
+(NSString *) getDBPath;
+(NSString *) getMyDBPath;
+ (void) addFoodWithName:(NSString*)foodName andFoodType:(NSString*)foodType andFoodCalorie:(NSNumber*)foodCalorie andFoodStoreOrNil:(NSString*)foodStore;
+(BOOL)openDatabse;
+(void)closeDatabase;
@end
