//
//  SearchByCategoryViewController.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/19/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SearchByCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *resultTableView;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *foodIcon;
@property (weak, nonatomic) IBOutlet UILabel *searchDetail;
@property (nonatomic) NSDictionary *foodArray;
@property (nonatomic,copy) NSArray *filteredFoodArray;
@property (nonatomic) NSString *searchCategory;
@property (nonatomic) NSNumber *addCalorieId;
-(void)predicateFoodArrayWithString:(NSString *)string;
- (IBAction)pushBack:(id)sender;
- (id)initWithCatName:(NSString *)nibNameOrNil catType:(NSString*)catTypeValue;
@end
