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
-(void) dealloc{
    
}
-(void)setActivity:(float)activity{
    self.myActivity = activity;
}

-(void)setAge:(float)age{
    self.myAge = myAge;
}

-(void)setWeight:(float)weight{
    self.myWeight = weight;
}

-(void)setHeight:(float)height{
    self.myHeight = height;
}

-(void)setGender:(BOOL)gender{
    self.myGender = gender;
}

-(float)getBMI{
    self.myBMI = self.myWeight / pow(myHeight/100,2.0);
    return myBMI;
}

-(float)getBMR{
    if (self.myGender){
        // Male.
        self.myBMR = 66 + (6.3*self.myWeight/2.2) + (12.9*self.myHeight/2.54) - (6.8*self.myAge);
    } else {
        // Female.
        self.myBMR = 665 + (4.3*self.myWeight/2.2) + (4.7*self.myHeight/2.54) - (4.7*self.myAge);
    }
    return self.myBMR;
}

@end
