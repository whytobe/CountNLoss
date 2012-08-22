//
//  FoodCategoryButton.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/17/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FoodCategoryButton;

@interface FoodCategoryButton : UIButton

- (id)initWithType:(NSString*)type withCaption:(NSString*)caption isLocked:(BOOL)locked atPosition:(int)position;
@end
