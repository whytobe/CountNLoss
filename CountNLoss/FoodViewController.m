//
//  FoodViewController.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "FoodViewController.h"

@interface FoodViewController ()
    
@end

@implementation FoodViewController
@synthesize calorieProgress;
@synthesize calorieLabel;
@synthesize foodTableView;
@synthesize glasses;
@synthesize labels;
@synthesize myFont;
@synthesize todayCalorie,foodArray,totalCalorie,maxCalorie;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTotalCalorie:0];
        [self setMaxCalorie:[NSNumber numberWithInt:1200]];
        [self setTitle:@"Count&Loss"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Food" image:[UIImage imageNamed:@"food"] tag:0];
        [[self tabBarItem] setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"food"]];
        [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        for (UILabel *label in [self labels]){
            [label setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
            [label setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
            
        }
        [[self calorieLabel]setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:18]];
        [[self calorieLabel]setTextAlignment:UITextAlignmentRight];
        [foodTableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgList"]]];
        [foodTableView setBackgroundColor:nil];
        foodArray = ((AppDelegate*)[[UIApplication sharedApplication]delegate]).foodArray;
        
        //NSLog(@"today Calorie : %@",foodArray);
        //[self setTitle:@"Count&Loss"];
    //foodTableView 
        
        
        /*NSArray *names = [UIFont familyNames];
        NSArray *fontFaces;
        NSLog(@"Font FamilyNames");
        for (NSString *name in names) {
            NSLog(@"Font Family: %@",name);
            fontFaces = [UIFont fontNamesForFamilyName:name];
            for (NSString *fname in fontFaces) {
                NSLog(@" %@",fname);
            }
        }*/
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self getFoodList];
    //[self setDrinkWater:3];
    // Do any additional setup after loading the view from its nib.

}
- (void)reloadCalorie{
    [self setTotalCalorie:0];
    //NSLog(@"%@",self.todayCalorie);
    [[[self todayCalorie] valueForKey:@"calorieFoodId"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *calorieId = obj;
        int foodId = [[[self foodArray] valueForKey:@"foodId"] indexOfObject:calorieId] ;
        //NSLog(@"%@ Calorie =  %d",calorieId,foodId);
        int foodCal = [[[[self foodArray] valueForKey:@"foodCalorie"] objectAtIndex:foodId] intValue];
        [self setTotalCalorie:[NSNumber numberWithInt:([[self totalCalorie] intValue]+foodCal)]];
    }];
    NSLog(@"Today total calorie : %@",totalCalorie);
    
}

- (void)reloadCalorieProgress{
    [[self calorieProgress]setFrame:CGRectMake(20, 42, 280, 30)];
    //CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    //[[self calorieProgress]setTransform:transform];
    float caloriePercent = [[self totalCalorie]floatValue]/[[self maxCalorie]floatValue];
    [[self calorieProgress] setProgress:caloriePercent];
    if ([self totalCalorie] == nil) [self setTotalCalorie:[NSNumber numberWithInt:0]];
    [[self calorieLabel]setText:[NSString stringWithFormat:@"%@/%@ KCal",[self totalCalorie],[self maxCalorie]]];
    
    float progessLeft = (20+(280*caloriePercent)-110 );
    [[self calorieLabel]setFrame:CGRectMake((progessLeft < 20)? 20 : progessLeft,42,100,30)];
    //[[self calorieProgress] setProgress:1];
}

- (void)viewWillAppear:(BOOL)animated{
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]) reloadHistory];
    [self setTodayCalorie:((AppDelegate*)[[UIApplication sharedApplication]delegate]).historyArray];
    [self reloadCalorie];
    [self reloadCalorieProgress];
    [[self foodTableView] reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self todayCalorie] valueForKey:@"calorieId"] count];
}

-(void)setDrinkWater:(int)numberOfGlasses{
    [glasses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *myGlass = obj;
        if ([myGlass tag] < numberOfGlasses) {
            [obj setImage:[UIImage imageNamed:@"glass"] forState:UIControlStateNormal];
        } else {
            *stop = YES;
        }
    }];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle  :UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        NSNumber *rowFoodId = [NSNumber numberWithInteger:[[[[self todayCalorie] valueForKey:@"calorieFoodId"]  objectAtIndex:indexPath.row] integerValue]];
        //NSNumber *rowIndex = [[NSNumber alloc]init ];
        
        NSInteger rowIndex = [[foodArray valueForKey:@"foodId"] indexOfObject:rowFoodId ];
        //NSLog(@"index of %@ from %@ is %d",rowFoodId,[foodArray valueForKey:@"foodId"],rowIndex);
        //NSNumber *rowIndex = [[foodArray objectAtIndex:0]indexOfObject:rowFoodId];
        //NSUInteger indexID = ;
        //NSLog(@"show History ID : %@,Food ID : %@",rowFoodId,rowIndex);
        [[cell textLabel] setText:[[foodArray objectForKey:@"foodName"]objectAtIndex:rowIndex]];
        [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ แคลอรี่",[[foodArray objectForKey:@"foodCalorie"]objectAtIndex:rowIndex ]]];
        
        [[cell textLabel] setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
        [[cell detailTextLabel] setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
        
        [[cell textLabel] setTextColor:[UIColor grayColor]];
        [[cell detailTextLabel] setTextColor:[UIColor grayColor]];

    }
    return cell;
}

- (void)viewDidUnload
{
    [self setLabels:nil];
    [self setFoodTableView:nil];
    [self setGlasses:nil];
    [self setTotalCalorie:nil];
    [self setTotalCalorie:nil];
    [self setFoodArray:nil];
    [self setCalorieProgress:nil];
    [self setCalorieLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backToHome:(id)sender {
    
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    UIViewController *foodCategoryView = [[FoodCategoryViewController alloc] initWithNibName:@"FoodCategoryViewController" bundle:nil ];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: backButton];
    [[self navigationController] pushViewController:foodCategoryView animated:YES];
}

@end
