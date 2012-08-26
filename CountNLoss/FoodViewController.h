//
//  FoodViewController.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCategoryViewController.h"

@interface FoodViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate>{
    UIFont *myFont;
}
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic,retain) UIFont *myFont;
@property (nonatomic) NSNumber *maxCalorie;
@property (nonatomic) NSNumber *drinkWater;
@property (nonatomic) NSDictionary *todayCalorie;
@property (nonatomic) NSDictionary *foodArray;
@property (weak, nonatomic) IBOutlet UITableView *foodTableView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *glasses;
@property (nonatomic) NSNumber *totalCalorie;
@property (weak, nonatomic) IBOutlet UIProgressView *calorieProgress;
@property (weak, nonatomic) IBOutlet UILabel *calorieLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingCalorie;

- (IBAction)addButtonTapped:(UIButton *)sender;
- (IBAction)editCalorieHistory:(id)sender;
- (IBAction)drinkAWater:(id)sender;

- (void)reloadCalorie;
@end
