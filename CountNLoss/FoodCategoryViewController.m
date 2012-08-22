//
//  FoodCategoryViewController.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/16/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "FoodCategoryViewController.h"
#import "FoodCategoryButton.h"
#import "SearchByCategoryViewController.h"

@interface FoodCategoryViewController ()

@end

@implementation FoodCategoryViewController
@synthesize labels = _labels;
@synthesize categoryButton = _categoryButton;
@synthesize allSearchTextField;
@synthesize iconArray,nameArray,lockArray,categoryArray;

- (IBAction)back:(id)sender {
    //CountAndLossAppDelegate *appDelegate = (CountAndLossAppDelegate *)[[UIApplication sharedApplication] delegate];
    [self dismissModalViewControllerAnimated:YES];
    //NSLog(@"%d",appDelegate.tabBarController.viewControllers.count);
}

- (IBAction)startSearch:(id)sender {
    //[sender resignFirstResponder];
    //NSLog(@"Begin Edit");
    SearchByCategoryViewController *nextPage = [[SearchByCategoryViewController alloc]initWithCatName:@"SearchByCategoryViewController" catType:@"1"];
    [[nextPage foodIcon] setBackgroundImage:[UIImage imageNamed:@"button_available"] forState:UIControlStateNormal];
    [[nextPage foodIcon] setImage:[UIImage imageNamed:@"icon_chicken"] forState:UIControlStateNormal];
    [[nextPage categoryName] setText:@"อาหารทุกประเภท"];
    [nextPage setTitle:@"อาหารทุกประเภท"];
    [[nextPage categoryName] setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:24]];
    [[nextPage categoryName] setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
    //nextPage.firstSightResponse = YES;
    nextPage.searchCategory = @"1";
    [[nextPage searchText]becomeFirstResponder];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: backButton];
    [[self navigationController] pushViewController:nextPage animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        NSMutableArray *tempIconArray = [NSMutableArray arrayWithObjects:@"icon_chicken",@"icon_pork",@"icon_meat",@"icon_fish",@"icon_vegetable",@"icon_fruit",@"icon_cake",@"icon_beverage",@"icon_fastfood",@"icon_restuarant",@"icon_vine",@"icon_folkspoon",@"icon_platefolkspoon",@"icon_noodle", nil];
        NSMutableArray *tempNameArray = [NSMutableArray arrayWithObjects:@"ไก่",@"หมู",@"เนื้อ",@"ทะเล",@"ผัก",@"ผลไม้",@"ของหวาน",@"เครื่องดื่ม",@"ฟาสต์ฟู้ด",@"ร้านอาหารชั้นนำ",@"เครื่องดื่มแอลกอฮอลล์",@"รายการที่กินบ่อย",@"อาหารยอดนิยม",@"อาหารตามสั่ง", nil];
        NSMutableArray *tempLockedArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO], nil];
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
        
        for (int i =0; i<arrayCount; ++i) {
            FoodCategoryButton *myButton= [[FoodCategoryButton alloc]initWithType:[self.iconArray objectAtIndex:i] withCaption:[self.nameArray objectAtIndex:i] isLocked:[(NSNumber*)[self.lockArray objectAtIndex:i] boolValue] atPosition:i+1];
            [myButton setTag:i];
            [buttonArray addObject:myButton];
            if (![(NSNumber*)[self.lockArray objectAtIndex:i] boolValue])
                [myButton addTarget:self action:@selector(tester:) forControlEvents:UIControlEventTouchUpInside];
            [[self view] addSubview:myButton];
        }
        self.categoryButton = buttonArray;
        buttonArray = nil;
    }
    return self;
}
-(void)tester:(UIButton*)sender{
    SearchByCategoryViewController *nextPage = [[SearchByCategoryViewController alloc]initWithCatName:@"SearchByCategoryViewController" catType:[[self categoryArray]objectAtIndex:sender.tag]];
    [[nextPage foodIcon] setBackgroundImage:[UIImage imageNamed:@"button_available"] forState:UIControlStateNormal];
    [[nextPage foodIcon] setImage:[UIImage imageNamed:[self.iconArray objectAtIndex:sender.tag]] forState:UIControlStateNormal];
    [[nextPage categoryName] setText:[self.nameArray objectAtIndex:sender.tag]];
    [nextPage setTitle:[self.nameArray objectAtIndex:sender.tag]];
    [[nextPage categoryName] setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:24]];
    [[nextPage categoryName] setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: backButton];
    [[self navigationController] pushViewController:nextPage animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Food Type"];
    for (UILabel *label in [self labels]){
        [label setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
        [label setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
        
    }	
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLabels:nil];
    [self setCategoryArray:nil];
    [self setCategoryButton:nil];
    [self setIconArray:nil];
    [self setLockArray:nil];
    [self setNameArray:nil];
    [self setAllSearchTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
