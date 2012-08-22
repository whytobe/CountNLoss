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

-(void)dealloc{
    [self setHistoryID:nil];
    [self setHistoryDate:nil];
    [self setHistoryFoodID:nil];
}
+(void)drinkAWater{
    /*NSMutableArray *tmpHistoryID = [[NSMutableArray alloc]initWithArray:historyID];
    NSMutableArray *tmpHistoryDate = [[NSMutableArray alloc] initWithArray:historyDate];
    NSMutableArray *tmpHistoryFoodID = [[NSMutableArray alloc] initWithArray:historyFoodID];
    
    //NSLog(@"%@",((NSInteger)tmpHistoryID.lastObject));
    [tmpHistoryID addObject:historyID.lastObject];
    [tmpHistoryDate addObject:[NSDate dateWithTimeIntervalSinceNow:0]];
    [tmpHistoryFoodID addObject:[NSNumber numberWithInt:WATER_FOOD_ID]];
    
    
    historyID = [NSArray arrayWithArray:tmpHistoryID];
    historyDate = [NSArray arrayWithArray:tmpHistoryDate];
    historyFoodID = [NSArray arrayWithArray:tmpHistoryFoodID];*/
    
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


+(void)insertCalorie:(int)withFoodId{
    /*NSMutableArray *tmpHistoryID = [[NSMutableArray alloc]initWithArray:historyID];
    NSMutableArray *tmpHistoryDate = [[NSMutableArray alloc] initWithArray:historyDate];
    NSMutableArray *tmpHistoryFoodID = [[NSMutableArray alloc] initWithArray:historyFoodID];*/
    
    const char *sql = "insert into history(calorie_food_id) Values(?)";
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));

	
	//sqlite3_bind_(addStmt, 1, [historyDate UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(addStmt, 1, withFoodId);
    //sqlite3_bind_text(addStmt, 3, [foodStore UTF8String], -1, SQLITE_TRANSIENT);
	//sqlite3_bind_double(addStmt, 4, [foodCalorie doubleValue]);
	NSNumber *returnNumber;
	if(SQLITE_DONE != sqlite3_step(addStmt)) {
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    } else {
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		//foodId = [NSNumber numberWithInt:sqlite3_last_insert_rowid(database)];
         returnNumber = [NSNumber numberWithInt:sqlite3_last_insert_rowid(database)];
    }
    //[tmpHistoryID addObject:[NSNumber numberWithInt:tmpHistoryID.count+1]];
    /*[tmpHistoryDate addObject:[NSDate dateWithTimeIntervalSinceNow:0]];
    [tmpHistoryFoodID addObject:[NSNumber numberWithInt:withFoodId]];
    
    
    historyID = [NSArray arrayWithArray:tmpHistoryID];
    historyDate = [NSArray arrayWithArray:tmpHistoryDate];
    historyFoodID = [NSArray arrayWithArray:tmpHistoryFoodID];*/
    
	//Reset the add statement.
	sqlite3_reset(addStmt);
}

+(void)deleteCalorie:(int)withHistoryID{
    //Create Temp Value;
    /*NSMutableArray *tmpHistoryID = [[NSMutableArray alloc]initWithArray:historyID];
    NSMutableArray *tmpHistoryDate = [[NSMutableArray alloc] initWithArray:historyDate];
    NSMutableArray *tmpHistoryFoodID = [[NSMutableArray alloc] initWithArray:historyFoodID];*/
    
    //if(deleteStmt == nil) {
		const char *sql = "delete from history where calorie_id = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	//}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1,(int)withHistoryID);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) 
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);
    
    //NSNumber *returnNumber = [NSNumber numberWithInt:withHistoryID];
    /*[tmpHistoryID removeObjectAtIndex:indexOfArray ];
    [tmpHistoryDate removeObjectAtIndex:indexOfArray];
    [tmpHistoryFoodID removeObjectAtIndex:indexOfArray];
    
    //Re setting value;
    historyID = [NSArray arrayWithArray:tmpHistoryID];
    historyDate = [NSArray arrayWithArray:tmpHistoryDate];
    historyFoodID = [NSArray arrayWithArray:tmpHistoryFoodID];*/

}
-(NSString*)description{
    return [NSString stringWithFormat:@"History id:%@, History Date:%@, History Food ID: %@",self.historyID,self.historyDate,self.historyFoodID];
}
+(NSArray*)getFoodHistory:(NSString *)dbPath{
    //CountAndLossAppDelegate *appDelegate = (CountAndLossAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *tempFood = [[NSMutableArray alloc]init];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
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
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
    }
    return tempFood;
}

+(NSArray*)getFoodHistoryTodayWithDB:(NSString *)dbPath{
    //CountAndLossAppDelegate *appDelegate = (CountAndLossAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *tempFood = [[NSMutableArray alloc]init];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
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
    return tempFood;

}

+(NSArray*)getFoodHistoryByDate:(NSDate *)targetDate withDB:(NSString *)dbPath{
    return nil;
}


@end
