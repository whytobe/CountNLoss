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
static sqlite3_stmt *addStmt = nil;

@implementation CalorieHistory

@synthesize historyID,historyDate,historyFoodID;
+(NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
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
		const char *sql = "select count(calorie_id) from history where calorie_food_id == 0 and calorie_date between strftime('%Y-%m-%d 00:00:00') and strftime('%Y-%m-%d 23:59:59')";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				waterCount = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
            } 
		}
    }
	else{
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
    }
    return waterCount;
}

+(NSNumber*)waterCountByDate:(NSDate *)targetDate{
    return nil;
}
+(void)drinkAWater{
    const char *sql = "insert into history(calorie_food_id,calorie_date) Values(0,strftime('%Y-%m-%d %H:%M:%S'))";
    if ([self openDatabse]) {
        if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        //sqlite3_bind_int(addStmt, 1, withFoodId);
        if (SQLITE_DONE != sqlite3_step(addStmt)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        }
    }
	//Reset the add statement.
	sqlite3_reset(addStmt);
    [self closeDatabase];
    NSLog(@"Drink a water");
    
}
+(void)dropAWater{
    /*NSMutableArray *tmpHistoryID = [[NSMutableArray alloc]initWithArray:historyID];
    NSMutableArray *tmpHistoryDate = [[NSMutableArray alloc] initWithArray:historyDate];
    NSMutableArray *tmpHistoryFoodID = [[NSMutableArray alloc] initWithArray:historyFoodID];
    
    NSUInteger indexOfArray = [tmpHistoryFoodID indexOfObject:[NSNumber numberWithInt:WATER_FOOD_ID]];
    [tmpHistoryID removeObjectAtIndex:indexOfArray];
    [tmpHistoryDate removeObjectAtIndex:indexOfArray];
    [tmpHistoryFoodID removeObjectAtIndex:indexOfArray];
    
    historyID = [NSArray arrayWithArray:tmpHistoryID];
    historyDate = [NSArray arrayWithArray:tmpHistoryDate];
    historyFoodID = [NSArray arrayWithArray:tmpHistoryFoodID];*/
    
}

+(BOOL)openDatabse{
    return sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK;
}
+(void)closeDatabase{
    sqlite3_close(database);
}
+(void)insertCalorie:(int)withFoodId{
    
    const char *sql = "insert into history(calorie_food_id,calorie_date) Values(?,strftime('%Y-%m-%d %H:%M:%S'))";
     if ([self openDatabse]) {
         if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
             NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));

         sqlite3_bind_int(addStmt, 1, withFoodId);
        if (SQLITE_DONE != sqlite3_step(addStmt)) {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        }
     }
	//Reset the add statement.
	sqlite3_reset(addStmt);
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
	//Reset the add statement.
	sqlite3_reset(deleteStmt);
    [self closeDatabase];

}
-(NSString*)description{
    return [NSString stringWithFormat:@"History id:%@, History Date:%@, History Food ID: %@",self.historyID,self.historyDate,self.historyFoodID];
}
+(NSDictionary*)getFoodHistory{
    //CountAndLossAppDelegate *appDelegate = (CountAndLossAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *tempFood = [[NSMutableArray alloc]init];
    if ([self openDatabse]) {
		const char *sql = "select calorie_id,calorie_date,calorie_food_id from history where calorie_food_id != 0";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				//NSNumber *primaryKey = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
				CalorieHistory *history = [[CalorieHistory alloc] init];
				history.historyID = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];//[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				history.historyDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                history.historyFoodID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                //calorie.foodCalorie = [NSNumber numberWithFloat:sqlite3_column_double(selectstmt, 4)];
				//calorie.isDirty = NO;
				//NSLog(@"Id :%@, %@ %@",calorie.foodId,calorie.foodName,calorie.foodCalorie);
                
				[tempFood addObject:history];
            }
		}
    }
	else{
		[self closeDatabase]; //Even though the open call failed, close the database connection to release all the memory.
    }
    return nil;
}
+(NSDictionary*)getFoodHistoryByDate:(NSDate *)targetDate{
    NSMutableArray *tempFood = [[NSMutableArray alloc]init];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select calorie_id,calorie_date,calorie_food_id from history where calorie_food_id != 0 and calorie_date between strftime('%Y-%m-%d 00:00:00') and strftime('%Y-%m-%d 23:59:59')";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				//NSNumber *primaryKey = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
				CalorieHistory *history = [[CalorieHistory alloc] init];
				history.historyID = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];//[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				history.historyDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                history.historyFoodID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                //calorie.foodCalorie = [NSNumber numberWithFloat:sqlite3_column_double(selectstmt, 4)];
				//calorie.isDirty = NO;
				//NSLog(@"Id :%@, %@ %@",calorie.foodId,calorie.foodName,calorie.foodCalorie);
                
				[tempFood addObject:history];
            }
		}
    }
	else{
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
    }
    return nil;
}
+(NSDictionary*)getFoodHistoryToday{

    //NSMutableArray *tempFood = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieId  = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieDate = [[NSMutableArray alloc]init];
    NSMutableArray *tempCalorieFoodId = [[NSMutableArray alloc]init];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select calorie_id,calorie_date,calorie_food_id from history where calorie_food_id != 0 and calorie_date between strftime('%Y-%m-%d 00:00:00') and strftime('%Y-%m-%d 23:59:59')";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSNumber *calorieId = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* calorieDate = (const char*)sqlite3_column_text(selectstmt, 1);
                NSNumber *calorieFoodId = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 2)];
				[tempCalorieId addObject:calorieId];
                [tempCalorieDate addObject:calorieDate?[NSString stringWithCString:calorieDate encoding:NSUTF8StringEncoding]:@""];
				[tempCalorieFoodId addObject:calorieFoodId];
                
				//tempCalorieId = nil;
                //tempCalorieDate = nil;
                //tempCalorieFoodId = nil;
            }
            
            
		}
    }
	else{
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
    }
    /*
    [tempFood addObject:tempCalorieId];
    [tempFood addObject:tempCalorieDate];
    [tempFood addObject:tempCalorieFoodId];
    */
    return [NSDictionary dictionaryWithObjectsAndKeys:tempCalorieId,@"calorieId",tempCalorieDate,@"calorieDate",tempCalorieFoodId,@"calorieFoodId", nil];

}


@end
