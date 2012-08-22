//
//  CalorieList.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "CalorieList.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
//static sqlite3_stmt *detailStmt = nil;
//static sqlite3_stmt *updateStmt = nil;

@implementation CalorieList

@synthesize foodId,foodName,foodType,foodStore,foodCalorie;

-(void)dealloc{
    [self setFoodId:nil];
    [self setFoodName:nil];
    [self setFoodType:nil];
    [self setFoodStore:nil];
    [self setFoodCalorie:nil];
    
}
+ (NSDictionary*) getAllFoodData:(NSString *)dbPath {
	
	//CountAndLossAppDelegate *appDelegate = (CountAndLossAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *tempFoodArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodIdArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodNameArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodTypeArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodStoreArray = [[NSMutableArray alloc]init];
    NSMutableArray *tempFoodCalorieArray = [[NSMutableArray alloc]init];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		const char *sql = "select food_id,food_name,food_type,food_store,food_calorie from food where food_id != 0";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				NSNumber *primaryKey = [NSNumber numberWithInt: sqlite3_column_int(selectstmt, 0)];
                const char* tempFoodName = (const char*)sqlite3_column_text(selectstmt, 1);
                const char* tempFoodType = (const char*)sqlite3_column_text(selectstmt, 2);
                const char* tempFoodStore = (const char*)sqlite3_column_text(selectstmt, 3);
                //NSString *tempFoodName = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(selectstmt, 1)];
                ///NSString *tempFoodType = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(selectstmt, 2)];
                //NSString *tempFoodStore = [NSString stringWithFormat:@"%s",(char *)sqlite3_column_text(selectstmt, 3)];
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
				//NSLog(@"Id :%@, %@ %@",calorie.foodId,calorie.foodName,calorie.foodCalorie);
            }
		}
    }
	else{
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
    }

    [tempFoodArray addObjectsFromArray:tempFoodIdArray];
    [tempFoodArray addObjectsFromArray:tempFoodNameArray];
    [tempFoodArray addObjectsFromArray:tempFoodTypeArray];
    [tempFoodArray addObjectsFromArray:tempFoodStoreArray];
    [tempFoodArray addObjectsFromArray:tempFoodCalorieArray];
    
    /*tempFoodIdArray = nil;
    tempFoodNameArray = nil;
    tempFoodTypeArray = nil;
    tempFoodStoreArray = nil;
    tempFoodCalorieArray = nil;*/
    
    return [NSDictionary dictionaryWithObjectsAndKeys:tempFoodIdArray,@"foodId",tempFoodNameArray,@"foodName",tempFoodTypeArray,@"foodType",tempFoodStoreArray,@"foodStore",tempFoodCalorieArray,@"foodCalorie", nil];
}
-(NSString*)description{
    return [NSString stringWithFormat:@"Food id:%@, FoodName:%@, FoodType: %@, FoodCalorie: %@",self.foodId,self.foodName,self.foodType,self.foodCalorie];
}
+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
}

- (id) initWithPrimaryKey:(NSNumber*) pk {
	
	self = [super init];
	foodId = pk;
	return self;
}
- (void) deleteCoffee {
	
	if(deleteStmt == nil) {
		const char *sql = "delete from food where food_id = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1,(int)foodId);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) 
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);
}

- (void) addFood {
	
	if(addStmt == nil) {
		const char *sql = "insert into food(food_name, food_type, food_store, food_calorie) Values(?, ?, ?, ?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_text(addStmt, 1, [foodName UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 2, [foodType UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 3, [foodStore UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_double(addStmt, 4, [foodCalorie doubleValue]);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		foodId = [NSNumber numberWithInt:sqlite3_last_insert_rowid(database)];
	
	//Reset the add statement.
	sqlite3_reset(addStmt);
}

-(void)removeFood{
    
}



@end


