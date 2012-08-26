//
//  CountAndLoss.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/15/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "CountAndLoss.h"

@implementation CountAndLoss
@synthesize myAge,myBMI,myActivity,myBMR,myGender,myHeight,myWeight;

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
-(NSString *)dataFilePath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myprofile.plist"];
}
-(CountAndLoss*)initCountAndLoss{
    self = [super init];
    if (self){
        NSDictionary *myProfile = [[NSDictionary alloc]initWithContentsOfFile:[self dataFilePath]];
        //[self setMyProfile:[NSMutableDictionary dictionaryWithContentsOfFile:[self dataFilePath]]];
        [self setMyHeight:[[myProfile valueForKey:@"height"]floatValue]];
        [self setMyWeight:[[myProfile valueForKey:@"weight"]floatValue]];
        [self setMyAge:[[myProfile valueForKey:@"age"]floatValue]];
        [self setMyGender:[[myProfile valueForKey:@"gender"]boolValue]];
    }
    return self;
}
+(CountAndLoss*)initCountAndLoss{
    return [[CountAndLoss alloc]initCountAndLoss];
}

-(NSString*)description{
    return [NSString stringWithFormat: @"Height :%.2f,Weight :%.2f,Age : %.0f, Sex %d",
          [self myHeight],[self myWeight],[self myAge],[self myGender]];
}

-(void)saveData{
    NSDictionary *writeMyProfile = [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat:[self myHeight]],@"height",
                               [NSNumber numberWithFloat:[self myWeight]],@"weight",
                               [NSNumber numberWithFloat:[self myAge]],@"age",
                               [NSNumber numberWithBool:[self myGender]],@"gender",
                               nil];
    [writeMyProfile writeToFile:[self dataFilePath] atomically:YES];
}
@end
