//
//  GoalViewController.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "GoalViewController.h"
#import "Goalsgraph.h"

@interface GoalViewController ()

@end

@implementation GoalViewController
@synthesize weightProgress;
@synthesize dateProgress;
@synthesize labels,scroller,blweights,addWeight;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Weight Goals"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Goal" image:[UIImage imageNamed:@"goal"] tag:0];
        [self.tabBarItem setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"goal"]];
        [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        for (UILabel *label in [self labels]){
            [label setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
            [label setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
            
        }
        for (UILabel *blweight in [self blweights]){
            [blweight setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:16]];
            [blweight setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
            
        }
        [[self weightProgress]setFrame:CGRectMake(10, 300, 215, 30)];
        [[self dateProgress]setFrame:CGRectMake(10, 350, 215,30)];
        
        
    }
    return self;
}
- (IBAction)addGoals:(id)sender{
    [[self navigationController]popViewControllerAnimated:YES];
}
- (IBAction)addButtonGoals:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"แก้ไขข้อมูลการลดน้ำหนักของคุณ" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
       [alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
		//NSLog(@"user pressed OK");
        //[CalorieHistory insertCalorie:[[self addCalorieId] intValue]];
        [[self navigationController]popToRootViewControllerAnimated:YES];
	}
	else {
		//NSLog(@"user pressed Cancel");
	}
    //[self setAddCalorieId:nil];
}
- (void) reloadProgress{

}
- (void) loadgraph{
    Goalsgraph *myGraph = [[Goalsgraph alloc]initWithFrame:CGRectMake(0,55, 280, 220)];
    [myGraph setBackgroundColor:[UIColor clearColor]];
    [[self view]addSubview:myGraph];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadgraph];
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

@end
