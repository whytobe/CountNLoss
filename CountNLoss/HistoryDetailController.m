//
//  HistoryDetailController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/27/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "HistoryDetailController.h"
#import "AppDelegate.h"
#import "CalorieHistory.h"
@interface HistoryDetailController ()

@end

@implementation HistoryDetailController
@synthesize calorieProgress;
@synthesize calorieLabel;
@synthesize remainingCalorie;
@synthesize foodTableView;
@synthesize glasses;
@synthesize labels;
@synthesize myFont;
@synthesize todayCalorie,foodArray,totalCalorie,maxCalorie,drinkWater,historyDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inDate:(NSString*)selectedDate
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTotalCalorie:0];
        self.historyDate = selectedDate;
        int maxCal = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).myProfile getBMR];
        [self setMaxCalorie:[NSNumber numberWithInt: maxCal]];
        [self setTitle:selectedDate];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"History" image:[UIImage imageNamed:@"history"] tag:0];
        [[self tabBarItem] setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"history"]];
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
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void)reloadCalorie{
    [self setTodayCalorie:[CalorieHistory getFoodHistoryByDate:[self historyDate]]];
}

- (void)reloadWater{
    [self setDrinkWater:[CalorieHistory waterCountByDate:[self historyDate]]];
    [self showDrinkWater:[[self drinkWater] intValue]];
}

- (void)reloadCalorieProgress{
    [self setTotalCalorie:0];
    [[[self todayCalorie] valueForKey:@"calorieFoodId"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSNumber *calorieId = obj;
        int foodId = [[[self foodArray] valueForKey:@"foodId"] indexOfObject:calorieId] ;
        int foodCal = [[[[self foodArray] valueForKey:@"foodCalorie"] objectAtIndex:foodId] intValue];
        [self setTotalCalorie:[NSNumber numberWithInt:([[self totalCalorie] intValue]+foodCal)]];
    }];
    

    [[self calorieProgress]setFrame:CGRectMake(20, 38, 280, 40)];
    float caloriePercent = [[self totalCalorie]floatValue]/[[self maxCalorie]floatValue];
    [[self calorieProgress] setProgress:caloriePercent];
    if ([self totalCalorie] == nil) [self setTotalCalorie:[NSNumber numberWithInt:0]];
    [[self calorieLabel]setText:[NSString stringWithFormat:@"%@/%@ KCal",[self totalCalorie],[self maxCalorie]]];
    //NSNumber *remainningCalorieNumber = [NSNumber numberWithInt:[[self maxCalorie] intValue]-[[self totalCalorie] intValue]];
    [[self remainingCalorie]setText:[NSString stringWithFormat:@"%@ แคลอรี่", [self totalCalorie]]];
    float progessLeft = (20+(280*caloriePercent)-110 );
    [[self calorieLabel]setFrame:CGRectMake((progessLeft < 20)? 20 : ((progessLeft>190)? 190 : progessLeft),42,100,30)];

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
        
        NSInteger rowIndex = [[foodArray valueForKey:@"foodId"] indexOfObject:rowFoodId ];

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


@end

