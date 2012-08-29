//
//  AddFoodViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/29/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "AddFoodViewController.h"
#import "SelectCategoryViewController.h"
#import "CalorieList.h"

@interface AddFoodViewController ()

@end

@implementation AddFoodViewController
@synthesize selectedCategoryLabel;
@synthesize selectCategoryButton;
@synthesize textFieldFoodName;
@synthesize textFieldFoodCalorie;
@synthesize labels,addFoodName,addFoodType,addFoodCalorie,foodIconArray,foodNameArray,typeIdArray,lockTypeArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         foodIconArray = [NSArray arrayWithObjects:@"icon_chicken",@"icon_pork",@"icon_meat",@"icon_fish",@"icon_vegetable",@"icon_fruit",@"icon_cake",@"icon_beverage",@"icon_fastfood",@"icon_restuarant",@"icon_vine",@"icon_folkspoon",@"icon_platefolkspoon",@"icon_noodle", nil];
        foodNameArray = [NSArray arrayWithObjects:@"ไก่",@"หมู",@"เนื้อ",@"ทะเล",@"ผัก",@"ผลไม้",@"ของหวาน",@"เครื่องดื่ม",@"ฟาสต์ฟู้ด",@"ร้านอาหารชั้นนำ",@"เครื่องดื่มแอลกอฮอลล์",@"รายการที่กินบ่อย",@"อาหารยอดนิยม",@"อาหารตามสั่ง", nil];
        lockTypeArray = [NSArray arrayWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO], nil];
       typeIdArray = [NSArray arrayWithObjects:@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109",@"110",@"111",@"112",@"113",@"114", nil];

        [self setTitle:@"Add Food"];
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        for (UILabel *label in [self labels]){
            [label setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
            [label setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
        }
        [[self textFieldFoodCalorie] setKeyboardType:UIKeyboardTypeDecimalPad];
        
        [[self selectedCategoryLabel]setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:18]];
        float yPos = 36+(((14/4)*72) + ((14/4)*10)) + 20;
        float xPos = 16+((14%4)*72) + 10;
        UIButton *addMenuButton = [[UIButton alloc]initWithFrame:CGRectMake(xPos, yPos, 140, 72)];
        [addMenuButton setTitle:@"เพิ่มอาหาร" forState:UIControlStateNormal];
        [addMenuButton setBackgroundImage:[UIImage imageNamed:@"button_long"] forState:UIControlStateNormal];
        [[addMenuButton titleLabel]setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:30]];
        [[addMenuButton  titleLabel]setTextColor:[UIColor whiteColor]];
        [[self view]addSubview:addMenuButton];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self addFoodType]){
        [[self selectCategoryButton] setTitle:nil forState:UIControlStateNormal];
        [[self selectCategoryButton] setImage:[UIImage imageNamed:[[self foodIconArray]objectAtIndex:[[self addFoodType]intValue]]] forState:UIControlStateNormal];
        [[self selectedCategoryLabel] setText:[[self foodNameArray]objectAtIndex:[[self addFoodType]intValue]]];
         NSLog(@"%@",[self addFoodType]);
    } else {
        [[self selectedCategoryLabel] setText:@"เลือกประเภท"];
        [[self selectCategoryButton]setTitle:@"?" forState:UIControlStateNormal];
    }
    [textFieldFoodCalorie resignFirstResponder];
    [textFieldFoodName resignFirstResponder];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == [self textFieldFoodName]){
        [textFieldFoodCalorie becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    return true;
}

- (void)viewDidUnload
{
    [self setLabels:nil];
    [self setSelectedCategoryLabel:nil];
    [self setTextFieldFoodName:nil];
    [self setTextFieldFoodCalorie:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectCategory:(id)sender {
    SelectCategoryViewController *selectCategoryPage = [[SelectCategoryViewController alloc]initWithCategorySelectDelegate:self NibName:@"SelectCategoryViewController" bundle:nil];
    [[self navigationController]pushViewController:selectCategoryPage animated:YES];
}
@end
