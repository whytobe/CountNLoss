//
//  SelectCategoryViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/29/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "SelectCategoryViewController.h"
#import "AddFoodViewController.h"
#import "FoodCategoryButton.h"

@interface SelectCategoryViewController ()

@end

@implementation SelectCategoryViewController
@synthesize selectCatDelegate,iconArray,nameArray,lockArray,categoryArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (id)initWithCategorySelectDelegate:(id)delegate NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //if (self) {
    // Custom initialization
    [self setSelectCatDelegate:delegate];
    [self setTitle:@"Select Category"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"food"] tag:0];
    [[self tabBarItem] setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"food"]];
    [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
    NSArray *tempIconArray = [NSArray arrayWithObjects:@"icon_chicken",@"icon_pork",@"icon_meat",@"icon_fish",@"icon_vegetable",@"icon_fruit",@"icon_cake",@"icon_beverage",@"icon_fastfood",@"icon_restuarant",@"icon_vine",@"icon_folkspoon",@"icon_platefolkspoon",@"icon_noodle", nil];
    NSArray *tempNameArray = [NSArray arrayWithObjects:@"ไก่",@"หมู",@"เนื้อ",@"ทะเล",@"ผัก",@"ผลไม้",@"ของหวาน",@"เครื่องดื่ม",@"ฟาสต์ฟู้ด",@"ร้านอาหารชั้นนำ",@"เครื่องดื่มแอลกอฮอลล์",@"รายการที่กินบ่อย",@"อาหารยอดนิยม",@"อาหารตามสั่ง", nil];
    NSArray *tempLockedArray = [NSArray arrayWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO], nil];
    NSArray *tempCagetoryTypeArray = [NSArray arrayWithObjects:@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109",@"110",@"111",@"112",@"113",@"114", nil];
    self.iconArray = [NSArray arrayWithArray: tempIconArray];
    self.nameArray = [NSArray arrayWithArray: tempNameArray];
    self.lockArray = [NSArray arrayWithArray: tempLockedArray];
    self.categoryArray = [NSArray arrayWithArray:tempCagetoryTypeArray];
    tempIconArray = nil;
    tempNameArray = nil;
    tempLockedArray = nil;
    int arrayCount = [self.iconArray count];
    NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:arrayCount];
    int position = 1;
    for (int i =0; i<arrayCount; ++i) {
        if (![[tempCagetoryTypeArray objectAtIndex:i]isEqualToString:@"112"] && ![[tempCagetoryTypeArray objectAtIndex:i]isEqualToString:@"113"]){
            FoodCategoryButton *myButton= [[FoodCategoryButton alloc]initWithType:[self.iconArray objectAtIndex:i] withCaption:[self.nameArray objectAtIndex:i] isLocked:[(NSNumber*)[self.lockArray objectAtIndex:i] boolValue] atPosition:position++];
            [myButton setTag:i];
            [buttonArray addObject:myButton];
            //if (![(NSNumber*)[self.lockArray objectAtIndex:i] boolValue])
            [myButton addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:myButton];
        }
    }
    
    //Add Button add food.
    //self.categoryButton = buttonArray;
    
    buttonArray = nil;
    //}
    return self;
}

-(void)selectCategory:(UIButton*)sender{
    [((AddFoodViewController*)[self selectCatDelegate]) setAddFoodType:[NSNumber numberWithInt:sender.tag]];
    [[self navigationController]popViewControllerAnimated:YES];
}

@end
