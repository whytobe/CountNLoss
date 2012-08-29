//
//  SelectCategoryViewController.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/29/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddFoodViewController.h"
@interface SelectCategoryViewController : UIViewController
@property (nonatomic) AddFoodViewController *selectCatDelegate;
@property (nonatomic) NSArray *iconArray;
@property (nonatomic) NSArray *nameArray;
@property (nonatomic) NSArray *lockArray;
@property (nonatomic) NSArray *categoryArray;
- (id)initWithCategorySelectDelegate:(id)delegate NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
@end
