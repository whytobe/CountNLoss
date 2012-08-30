//
//  AddFoodViewController.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/29/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFoodViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic) NSString *addFoodName;
@property (nonatomic) NSNumber *addFoodCalorie;
@property (nonatomic) NSNumber *addFoodType;
@property (nonatomic) NSArray *foodIconArray,*foodNameArray,*typeIdArray,*lockTypeArray;
- (IBAction)selectCategory:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *selectedCategoryLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectCategoryButton;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFoodName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFoodCalorie;
@end
