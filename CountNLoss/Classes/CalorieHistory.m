//
//  CalorieHistory.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "CalorieHistory.h"
#define HISTORY_ID @"HistoryID"
#define HISTORY_DATE @"HistoryDate"
#define HISTORY_FOOD_ID @"HistoryFoodID"
#define WATER_FOOD_ID 0

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;

@implementation CalorieHistory

@synthesize historyID,historyDate,historyFoodID;
+(NSString *) getDBPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"history.sqlite"];
}
-(void)dealloc{
    [self setHistoryID:nil];
    [self setHistoryDate:nil];
    [self setHistoryFoodID:nil];
}
+(NSNumber*)waterCountToday{
    NSNumber *waterCount = [NSNumber numberWithInt:0];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
        NSString *insertStatement = [NSString stringWithFormat:@"select count(calorie_id) from history where calorie_food_id == 0 and calorie_date between '%@ 00:00:00' and '%@ 23:59:59'", [self getDate],[self getDate]];
        const char *sql = [insertStatement UTF8String];
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				waterCount = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
            } 
		}
    }
	else{
		sqlite3_close(database); 
    }
    return waterCount;
}
+(NSString*)getDateTime{
    NSDate* now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter* localTime = [[NSDateFormatter alloc] init];
    [localTime setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [localTime stringFromDate:now];
}

+(NSString*)getDate{
    NSDate* now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter* localTime = [[NSDateFormatter alloc] init];
    [localTime setDateFormat:@"yyyy-MM-dd"];
    return [localTime stringFromDate:now];
}
+(NSNumber*)waterCountByDate:(NSString*)targetDate{
    NSNumber *waterCount = [NSNumber numberWithInt:0];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
        NSString *insertStatement = [NSString stringWithFormat:@"select count(calorie_id) from history where calorie_food_id == 0 and calorie_date between '%@ 00:00:00' and '%@ 23:59:59'", targetDate,targetDate];
        const char *sql = [insertStatement UTF8String];
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				waterCount = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
            } 
		}
    }
	else{
		sqlite3_close(database); 
    }
    return waterCount;
}
+(void)drinkAWater{
    if ([self openDatabse]) {
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO history(calorie_food_id,calorie_date) VALUES(0,'%@')", [self getDateTime]];
        
        char *error;
        if ( !sqlite3_exec(database, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK) 
            NSAssert1(0, @"Error while inserting data. '%s'", error);
    }
    [self closeDatabase];
}
+(void)dropAWater{
    //Command
}

+(BOOL)openDatabse{
    return sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK;
}
+(void)closeDatabase{
    sqlite3_close(database);
}
+(void)insertCalorie:(int)withFoodId{
    if ([self openDatabse]) {
        NSString *insertStatement = [NSString stringWithFormat:@"insert into history(calorie_food_id,calorie_date) Values(%d,'%@')",withFoodId, [self getDateTime]];
        //NSLog(@"%@",insertStatement);
        char *error;
        if ( !sqlite3_exec(database, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK) 
            NSAssert1(0, @"Error while inserting data. '%s'", error);
    }
    [self closeDatabase];
    
}

+(void)deleteCalorie:(int)withHistoryID{
    const char *sql = "delete from history where calorie_id = ?";
    if ([self openDatabse]) {
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        sqlite3_bind_int(deleteStmt, 1, withHistoryID);
        if (SQLITE_DONE != sqlite3_step(deleteStmt)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        }
    }
	sqlite3_reset(deleteStmt);
    [self closeDatabase];

}
-(NSString*)description{
    return [NSString stringWithFormat:@"History id:%@, History Date:%@, History Food ID: %@",self.historyID,self.historyDate,self.historyFoodID];
}
+(NSDictionary*)getFoodHistory{

    NSMutableArray *tempFood = [[NSMutableArray alloc]init];
    if ([self openDatabse]) {
		const char *sql = "select calorie_id,calorie_date,calorie_food_id from history where calorie_food_id != 0";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				CalorieHistory *history = [[CalorieHistory alloc] init];
				history.historyID = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
				history.historyDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                history.historyFoodID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				[tempFood addObject:history];
            }
		}
    }
	else{
		[self closeDatabase]; 
    }
    return nil;
}
+(NSDictionary*)getFoodHistoryByDate:(NSString*)targetDate{
    NSMutableArray *tempCalorieId  = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieDate = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieFoodId = [[NSMutableArray alloc]init];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
		NSString *insertStatement = [NSString stringWithFormat:@"select calorie_id,calorie_date,calorie_food_id from history where calorie_food_id != 0 and calorie_date between '%@ 00:00:00' and '%@ 23:59:59'", targetDate,targetDate];
        
        const char *sql = [insertStatement UTF8String];
        
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSNumber *calorieId = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* calorieDate = (const char*)sqlite3_column_text(selectstmt, 1);
                NSNumber *calorieFoodId = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 2)];
				[tempCalorieId addObject:calorieId];
                [tempCalorieDate addObject:calorieDate?[NSString stringWithCString:calorieDate encoding:NSUTF8StringEncoding]:@""];
				[tempCalorieFoodId addObject:calorieFoodId];
                
            }
            
            
		}
    }
	else{
		sqlite3_close(database); 
    }
    //NSLog(@"Result in date %@ : %@",targetDate,[NSDictionary dictionaryWithObjectsAndKeys:tempCalorieId,@"calorieId",tempCalorieDate,@"calorieDate",tempCalorieFoodId,@"calorieFoodId", nil]);
    return [NSDictionary dictionaryWithObjectsAndKeys:tempCalorieId,@"calorieId",tempCalorieDate,@"calorieDate",tempCalorieFoodId,@"calorieFoodId", nil];
}
+(NSDictionary*)getFoodHistoryToday{
    NSMutableArray *tempCalorieId  = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieDate = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieFoodId = [[NSMutableArray alloc]init];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
        NSString *insertStatement = [NSString stringWithFormat:@"select calorie_id,calorie_date,calorie_food_id from history where calorie_food_id != 0 and calorie_date between '%@ 00:00:00' and '%@ 23:59:59'", [self getDate],[self getDate]];

        const char *sql = [insertStatement UTF8String];

		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSNumber *calorieId = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* calorieDate = (const char*)sqlite3_column_text(selectstmt, 1);
                NSNumber *calorieFoodId = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 2)];
				[tempCalorieId addObject:calorieId];
                [tempCalorieDate addObject:calorieDate?[NSString stringWithCString:calorieDate encoding:NSUTF8StringEncoding]:@""];
				[tempCalorieFoodId addObject:calorieFoodId];
                
            }
            
            
		}
    }
	else{
		sqlite3_close(database); 
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:tempCalorieId,@"calorieId",tempCalorieDate,@"calorieDate",tempCalorieFoodId,@"calorieFoodId", nil];

}

+(NSDictionary*)getMostFavouriteFood{
    NSMutableArray *tempCalorieCount = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieFoodId = [[NSMutableArray alloc]init];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
        NSString *insertStatement = [NSString stringWithFormat:@"SELECT calorie_food_id,count(calorie_id),max(calorie_date) from history where calorie_food_id != 0 group by calorie_food_id order by count(calorie_id)desc ,max(calorie_date) desc"];
        
        const char *sql = [insertStatement UTF8String];
        
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSNumber *calorieCount = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 1)];
                NSNumber *calorieFoodId = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
				[tempCalorieCount addObject:calorieCount];
				[tempCalorieFoodId addObject:calorieFoodId];
            }
		}
    }
	else{
		sqlite3_close(database); 
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:tempCalorieFoodId,@"calorieFoodId",tempCalorieCount,@"calorieCount",nil];
}


@end
