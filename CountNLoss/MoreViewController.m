//
//  MoreViewController.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize moreMenu,moreSection;
@synthesize moreTableView = _moreTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setMoreMenu:[[NSArray alloc] initWithObjects:
                           [NSArray arrayWithObjects:@"Profile", nil],
                           [NSArray arrayWithObjects:@"Upgrade to PRO",@"Notice", nil],
                           [NSArray arrayWithObjects:@"Notifications",@"Tell a friend",@"Help",@"About Count & Loss", nil]
                           , nil]];
        [self setMoreSection:[[NSArray alloc] initWithObjects:@"Setting",@"Upgrade",@"Other", nil]];
        // Custom initialization
        [self setTitle:@"More"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        [[self moreTableView]setBackgroundColor:nil];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"More" image:[UIImage imageNamed:@"more"] tag:0];
        [self.tabBarItem setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"more"]];
        [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    }
    NSLog(@"%@ : %@",[self moreSection],[self moreMenu]);
    return self;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //[[cell textLabel]setText:@"TEST"];
    [[cell textLabel]setText:[[moreMenu objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    [[cell textLabel] setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:28]];
    [[cell textLabel] setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 3;
    return [[[self moreMenu] objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return 3;
    return [[self moreSection]count];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setMoreSection:nil];
    [self setMoreMenu:nil];
    [self setMoreTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
