//
//  CountAndLoss.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "CountAndLoss.h"

@implementation CountAndLoss
@synthesize myAge,myBMI,myActivity,myBMR,myGender,myHeight,myWeight,historyWeight;

-(float)getBMI{
    self.myBMI = self.myWeight / pow(myHeight/100,2.0);
    return myBMI;
}

-(float)getBMR{
    if (!self.myGender){ //0
        // Male.
        self.myBMR = 66 + (13.7*self.myWeight) + (5*self.myHeight) - (6.8*self.myAge);
    } else { //1
        // Female.
        self.myBMR = 665 + (9.6*self.myWeight) + (1.8*self.myHeight) - (4.7*self.myAge);
    }
    return self.myBMR;
}
-(NSString*)getDate{
    NSDate* now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter* localTime = [[NSDateFormatter alloc] init];
    [localTime setDateFormat:@"yyyy-MM-dd"];
    return [localTime stringFromDate:now];
}
-(NSString *)dataFilePath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myprofile.plist"];
}
-(CountAndLoss*)initCountAndLoss{
    self = [super init];
    if (self){
        
        NSDictionary *myProfile = [[NSDictionary alloc]initWithContentsOfFile:[self dataFilePath]];
        //[self setMyProfile:[NSMutableDictionary dictionaryWithContentsOfFile:[self dataFilePath]]];
        [self setMyHeight:[[myProfile valueForKey:@"height"]floatValue]];
        
        [self setHistoryWeight:[myProfile valueForKey:@"weight"]];
        [self setMyAge:[[myProfile valueForKey:@"age"]intValue]];
        [self setMyGender:[[myProfile valueForKey:@"gender"]boolValue]];
        historyWeight = [NSMutableDictionary dictionaryWithDictionary:[myProfile valueForKey:@"weight"]];
        if (historyWeight.count > 0){
            id aKey = [[historyWeight allKeys] objectAtIndex:0];
            [self setMyWeight:[[[self historyWeight] valueForKey:aKey]floatValue]];
        } else {
            historyWeight = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithFloat:[self myWeight]],[self getDate], nil];
        }
    }
    return self;
}
-(NSNumber*)getCurrentWeight{
    id aKey = [[historyWeight allKeys] objectAtIndex:0];
    return [[self historyWeight] valueForKey:aKey];
}

+(CountAndLoss*)initCountAndLoss{
    return [[CountAndLoss alloc]initCountAndLoss];
}

-(NSString*)description{
    return [NSString stringWithFormat: @"Height :%.2f,Weight :%.2f,Age : %.0f, Sex %d",
          [self myHeight],[self myWeight],[self myAge],[self myGender]];
}

-(void)saveData{
    
    [[self historyWeight] setObject:[NSNumber numberWithFloat:[self myWeight]] forKey:[self getDate]];
    
    NSDictionary *writeMyProfile = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat:[self myHeight]],@"height",
                               [self historyWeight],@"weight",
                               [NSNumber numberWithFloat:[self myAge]],@"age",
                               [NSNumber numberWithBool:[self myGender]],@"gender",
                               nil];
    NSLog(@"%@",writeMyProfile);
    //NSLog(@"Last Object : %@",[[historyWeight allValues]f]);
    [writeMyProfile writeToFile:[self dataFilePath] atomically:YES];
}
@end
