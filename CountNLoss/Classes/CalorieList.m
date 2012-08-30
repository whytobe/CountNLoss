//
//  CalorieList.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "CalorieList.h"

static sqlite3 *database = nil;
//static sqlite3_stmt *detailStmt = nil;
//static sqlite3_stmt *updateStmt = nil;

@implementation CalorieList

+(NSString *) getDBPath {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"fooddb.sqlite"];
}
-(void)dealloc{
    
}
+ (NSDictionary*) getAllFoodDataWithCat:(NSString *)catId {
    NSMutableArray *tempFoodIdArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodNameArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodTypeArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodStoreArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodCalorieArray = [[NSMutableArray alloc]init];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
		NSString *sql = [NSString stringWithFormat:@"select food_id,food_name,food_type,food_store,food_calorie from food where food_id != 0 and food_type like '%%%@%%'",catId];
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSNumber *primaryKey = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* tempFoodName = (const char*)sqlite3_column_text(selectstmt, 1);
                const char* tempFoodType = (const char*)sqlite3_column_text(selectstmt, 2);
                const char* tempFoodStore = (const char*)sqlite3_column_text(selectstmt, 3);
                NSNumber *tempFoodCalorie = [NSNumber numberWithDouble:sqlite3_column_double(selectstmt, 4)];
				[tempFoodIdArray addObject:primaryKey];
                [tempFoodNameArray addObject:tempFoodName?[NSString stringWithCString:tempFoodName encoding:NSUTF8StringEncoding]:@""];
				[tempFoodTypeArray addObject:tempFoodType?[NSString stringWithCString:tempFoodType encoding:NSUTF8StringEncoding]:@""];
                [tempFoodStoreArray addObject:tempFoodStore?[NSString stringWithCString:tempFoodStore encoding:NSUTF8StringEncoding]:@""];
                [tempFoodCalorieArray addObject:tempFoodCalorie];
                primaryKey = nil;
                tempFoodName = nil;
                tempFoodType = nil;
                tempFoodStore = nil;
                tempFoodCalorie = nil;

            }
		}
    }
	else{
		sqlite3_close(database); 
    }
    
    //Get custom database from mydb.sqlite.
    if (sqlite3_open([[self getMyDBPath] UTF8String], &database) == SQLITE_OK) {
		NSString *sql = [NSString stringWithFormat:@"select food_id,food_name,food_type,food_store,food_calorie from food where food_id != 0 and food_type like '%%%@%%'",catId];
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, [sql UTF8String], -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSNumber *primaryKey = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* tempFoodName = (const char*)sqlite3_column_text(selectstmt, 1);
                const char* tempFoodType = (const char*)sqlite3_column_text(selectstmt, 2);
                const char* tempFoodStore = (const char*)sqlite3_column_text(selectstmt, 3);
                NSNumber *tempFoodCalorie = [NSNumber numberWithDouble:sqlite3_column_double(selectstmt, 4)];
				[tempFoodIdArray addObject:primaryKey];
                [tempFoodNameArray addObject:tempFoodName?[NSString stringWithCString:tempFoodName encoding:NSUTF8StringEncoding]:@""];
				[tempFoodTypeArray addObject:tempFoodType?[NSString stringWithCString:tempFoodType encoding:NSUTF8StringEncoding]:@""];
                [tempFoodStoreArray addObject:tempFoodStore?[NSString stringWithCString:tempFoodStore encoding:NSUTF8StringEncoding]:@""];
                [tempFoodCalorieArray addObject:tempFoodCalorie];
                primaryKey = nil;
                tempFoodName = nil;
                tempFoodType = nil;
                tempFoodStore = nil;
                tempFoodCalorie = nil;
                
            }
		}
    }
	else{
		sqlite3_close(database); 
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:tempFoodIdArray,@"foodId",tempFoodNameArray,@"foodName",tempFoodTypeArray,@"foodType",tempFoodStoreArray,@"foodStore",tempFoodCalorieArray,@"foodCalorie", nil];
}
+ (NSDictionary*) getAllFoodData {
    NSMutableArray *tempFoodIdArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodNameArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodTypeArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodStoreArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodCalorieArray = [[NSMutableArray alloc]init];
    if (sqlite3_open([[self getDBPath] UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select food_id,food_name,food_type,food_store,food_calorie from food where food_id != 0";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSNumber *primaryKey = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* tempFoodName = (const char*)sqlite3_column_text(selectstmt, 1);
                const char* tempFoodType = (const char*)sqlite3_column_text(selectstmt, 2);
                const char* tempFoodStore = (const char*)sqlite3_column_text(selectstmt, 3);
                NSNumber *tempFoodCalorie = [NSNumber numberWithDouble:sqlite3_column_double(selectstmt, 4)];
				[tempFoodIdArray addObject:primaryKey];
                [tempFoodNameArray addObject:tempFoodName?[NSString stringWithCString:tempFoodName encoding:NSUTF8StringEncoding]:@""];
				[tempFoodTypeArray addObject:tempFoodType?[NSString stringWithCString:tempFoodType encoding:NSUTF8StringEncoding]:@""];
                [tempFoodStoreArray addObject:tempFoodStore?[NSString stringWithCString:tempFoodStore encoding:NSUTF8StringEncoding]:@""];
                [tempFoodCalorieArray addObject:tempFoodCalorie];
                primaryKey = nil;
                tempFoodName = nil;
                tempFoodType = nil;
                tempFoodStore = nil;
                tempFoodCalorie = nil;
            }
		}
    }
	else{
		sqlite3_close(database); 
    }
    
    //Get custom database from mydb.sqlite.
    if (sqlite3_open([[self getMyDBPath] UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select food_id,food_name,food_type,food_store,food_calorie from food";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSNumber *primaryKey = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* tempFoodName = (const char*)sqlite3_column_text(selectstmt, 1);
                const char* tempFoodType = (const char*)sqlite3_column_text(selectstmt, 2);
                const char* tempFoodStore = (const char*)sqlite3_column_text(selectstmt, 3);
                NSNumber *tempFoodCalorie = [NSNumber numberWithDouble:sqlite3_column_double(selectstmt, 4)];
				[tempFoodIdArray addObject:primaryKey];
                [tempFoodNameArray addObject:tempFoodName?[NSString stringWithCString:tempFoodName encoding:NSUTF8StringEncoding]:@""];
				[tempFoodTypeArray addObject:tempFoodType?[NSString stringWithCString:tempFoodType encoding:NSUTF8StringEncoding]:@""];
                [tempFoodStoreArray addObject:tempFoodStore?[NSString stringWithCString:tempFoodStore encoding:NSUTF8StringEncoding]:@""];
                [tempFoodCalorieArray addObject:tempFoodCalorie];
                primaryKey = nil;
                tempFoodName = nil;
                tempFoodType = nil;
                tempFoodStore = nil;
                tempFoodCalorie = nil;
            }
		}
    }
	else{
		sqlite3_close(database); 
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:tempFoodIdArray,@"foodId",tempFoodNameArray,@"foodName",tempFoodTypeArray,@"foodType",tempFoodStoreArray,@"foodStore",tempFoodCalorieArray,@"foodCalorie", nil];
}
+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}

+ (void) addFoodWithName:(NSString*)foodName andFoodType:(NSString*)foodType andFoodCalorie:(NSNumber*)foodCalorie andFoodStoreOrNil:(NSString*)foodStore {
    if ([self openDatabse]) {
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO food(food_name,food_type,food_store,food_calorie) VALUES('%@','%@','%@',%@)", foodName,foodType,foodStore,foodCalorie];
        
        char *error;
        if ( !sqlite3_exec(database, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK) 
            NSAssert1(0, @"Error while inserting data. '%s'", error);
    }
    [self closeDatabase];
}

-(void)removeFood{
    
}
+(BOOL)openDatabse{
    return sqlite3_open([[self getMyDBPath] UTF8String], &database) == SQLITE_OK;
}
+(void)closeDatabase{
    sqlite3_close(database);
}

+(NSString *) getMyDBPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"mydb.sqlite"];
}


@end


