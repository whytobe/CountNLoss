//
//  FoodViewController.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "FoodViewController.h"
#import "AppDelegate.h"
@interface FoodViewController ()
    
@end

@implementation FoodViewController
@synthesize calorieProgress;
@synthesize calorieLabel;
@synthesize remainingCalorie;
@synthesize foodTableView;
@synthesize glasses;
@synthesize labels;
@synthesize myFont;
@synthesize todayCalorie,foodArray,totalCalorie,maxCalorie,drinkWater;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTotalCalorie:0];
        int maxCal = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).myProfile getBMR];
        [self setMaxCalorie:[NSNumber numberWithInt: maxCal]];
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
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]) reloadHistory];
    [self setTodayCalorie:((AppDelegate*)[[UIApplication sharedApplication]delegate]).historyArray];
}

- (void)reloadWater{
    [self setDrinkWater:[CalorieHistory waterCountToday]];
    [self showDrinkWater:[[self drinkWater] intValue]];
}

- (void)reloadCalorieProgress{
    [self setTotalCalorie:0];
    //NSLog(@"%@",self.todayCalorie);
    [[[self todayCalorie] valueForKey:@"calorieFoodId"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *calorieId = obj;
        int foodId = [[[self foodArray] valueForKey:@"foodId"] indexOfObject:calorieId] ;
        //NSLog(@"%@ Calorie =  %d",calorieId,foodId);
        int foodCal = [[[[self foodArray] valueForKey:@"foodCalorie"] objectAtIndex:foodId] intValue];
        [self setTotalCalorie:[NSNumber numberWithInt:([[self totalCalorie] intValue]+foodCal)]];
    }];
    
    //NSLog(@"Today total calorie : %@",totalCalorie);

    [[self calorieProgress]setFrame:CGRectMake(20, 38, 280, 40)];
    //CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 3.0f);
    //[[self calorieProgress]setTransform:transform];
    float caloriePercent = [[self totalCalorie]floatValue]/[[self maxCalorie]floatValue];
    [[self calorieProgress] setProgress:caloriePercent];
    if ([self totalCalorie] == nil) [self setTotalCalorie:[NSNumber numberWithInt:0]];
    [[self calorieLabel]setText:[NSString stringWithFormat:@"%@/%@ KCal",[self totalCalorie],[self maxCalorie]]];
    NSNumber *remainningCalorieNumber = [NSNumber numberWithInt:[[self maxCalorie] intValue]-[[self totalCalorie] intValue]];
    [[self remainingCalorie]setText:[NSString stringWithFormat:@"%@ แคลอรี่", remainningCalorieNumber]];
    float progessLeft = (20+(280*caloriePercent)-110 );
    [[self calorieLabel]setFrame:CGRectMake((progessLeft < 20)? 20 : ((progessLeft>190)? 190 : progessLeft),42,100,30)];
    //[[self calorieProgress] setProgress:1];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self reloadCalorie];
    [self reloadWater];
    [self reloadCalorieProgress];
    [[self foodTableView] reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self todayCalorie] valueForKey:@"calorieId"] count];
}

-(void)showDrinkWater:(int)numberOfGlasses{
    [glasses enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *myGlass = obj;
        if ([myGlass tag] < numberOfGlasses) {
            [obj setImage:[UIImage imageNamed:@"glass"] forState:UIControlStateNormal];
        } else {
            [obj setImage:[UIImage imageNamed:@"emptyGlass"] forState:UIControlStateNormal];
        }
    }];
    //NSLog(@"drink water : %@",[self drinkWater]);
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     [foodTableView setEditing:NO animated:YES];
}

- (void)viewDidUnload
{
    [self setLabels:nil];
    [self setFoodTableView:nil];
    [self setGlasses:nil];
    [self setTotalCalorie:nil];
    [self setTodayCalorie:nil];
    [self setFoodArray:nil];
    [self setCalorieProgress:nil];
    [self setCalorieLabel:nil];
    [self setRemainingCalorie:nil];
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //NSLog(@"Delete row %d : %@",indexPath.row,[[[self todayCalorie] valueForKey:@"calorieId"]objectAtIndex:indexPath.row]);
        [CalorieHistory deleteCalorie:[[[[self todayCalorie] valueForKey:@"calorieId"]objectAtIndex:indexPath.row] intValue]];
        [self reloadCalorie];
        [self reloadCalorieProgress];
        //[[self foodTableView] reloadData];
        //NSLog(@"row count : %d",[[[self todayCalorie] valueForKey:@"calorieId"] count]);
        //[[self todayCalorie] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    UIViewController *foodCategoryView = [[FoodCategoryViewController alloc] initWithNibName:@"FoodCategoryViewController" bundle:nil ];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle: @"Back" style: UIBarButtonItemStyleBordered target: nil action: nil];
    [[self navigationItem] setBackBarButtonItem: backButton];
    [[self navigationController] pushViewController:foodCategoryView animated:YES];
}

- (IBAction)editCalorieHistory:(id)sender {
    [foodTableView setEditing:![foodTableView isEditing] animated:YES];
}

- (IBAction)drinkAWater:(id)sender {
    [CalorieHistory drinkAWater];
    [self reloadWater];
}

@end
