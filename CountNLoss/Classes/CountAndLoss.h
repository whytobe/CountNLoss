//
//  CountAndLoss.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalorieHistory.h"
@interface CountAndLoss : NSObject
    
@property (nonatomic) float myWeight;
@property (nonatomic) float myHeight;
@property (nonatomic) float myActivity;
@property (nonatomic) BOOL myGender;
@property (nonatomic) NSMutableDictionary *historyWeight;
@property (nonatomic) float myAge;
@property (nonatomic) float myBMI;
@property (nonatomic) float myBMR;


-(float)getBMI;
-(float)getBMR;
-(BOOL)checkCurrentWeight;
-(NSNumber*)getCurrentWeight;
-(BOOL)checkCompleteProfile;
-(void) saveData;
-(CountAndLoss*)initCountAndLoss;
+(CountAndLoss*)initCountAndLoss;
-(NSString*)getDate;
@end
