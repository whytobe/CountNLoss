//
//  FoodCategoryViewController.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/16/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodCategoryViewController;

@interface FoodCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic) NSArray *iconArray;
@property (nonatomic) NSArray *nameArray;
@property (nonatomic) NSArray *lockArray;
@property (nonatomic) NSArray *categoryArray;
@property (nonatomic) NSArray *categoryButton;
@property (weak, nonatomic) IBOutlet UITextField *allSearchTextField;
- (IBAction)back:(id)sender;
- (IBAction)startSearch:(id)sender;

@end
