//
//  CalorieHistory.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalorieList.h"

@interface CalorieHistory : NSObject{
    NSNumber *historyId;
    NSString *historyDate;
    NSNumber *historyFoodId;
}

@property ( nonatomic) NSNumber *historyID;
@property ( nonatomic) NSString *historyDate;
@property ( nonatomic) NSNumber *historyFoodID;
//@property (retain, nonatomic) NSDictionary *historyLists;
+(BOOL)openDatabse;
+(void)closeDatabase;
+(NSDictionary*) getFoodHistoryByDate:(NSDate*)targetDate;
+(NSDictionary*) getFoodHistory;
+(NSDictionary*) getFoodHistoryToday;
+(NSString *) getDBPath;
+(void) insertCalorie:(int)withFoodId;
+(void) deleteCalorie:(int)HistoryID;

+(NSNumber*)waterCountToday;
+(NSNumber*)waterCountByDate:(NSDate*)targetDate;
+(void) drinkAWater;
+(void) dropAWater;
@end
