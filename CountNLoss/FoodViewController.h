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
@property (nonatomic) NSArray *todayCalorie;
@property (nonatomic) NSDictionary *foodArray;
@property (weak, nonatomic) IBOutlet UITableView *foodTableView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *glasses;
- (IBAction)backToHome:(id)sender;

- (IBAction)addButtonTapped:(UIButton *)sender;

@end
