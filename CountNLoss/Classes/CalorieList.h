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
@interface CalorieList : NSObject{
    NSNumber   *foodId;
    NSString    *foodName;
    NSString    *foodType;
    NSString    *foodStore;
    NSNumber   *foodCalorie;
}

@property (nonatomic, copy) NSNumber *foodId;
@property (nonatomic, copy) NSString *foodName;
@property (nonatomic, copy) NSString *foodType;
@property (nonatomic, copy) NSString *foodStore;
@property (nonatomic, copy) NSNumber *foodCalorie;


+(NSDictionary*) getAllFoodData:(NSString *)dbPath;
+(void) finalizeStatements;

- (id) initWithPrimaryKey:(NSNumber*)pk;
- (void) removeFood;
- (void) addFood;

@end
