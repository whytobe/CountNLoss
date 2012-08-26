//
//  ProfileViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/23/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "ProfileViewController.h"
#import "CountAndLoss.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize heightTextField;
@synthesize widthTextField;
@synthesize ageTextField;
@synthesize sexSegmentControl;
@synthesize labels,myProfile;
@synthesize BMILabel;
@synthesize BMRLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Profile"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        for (UILabel *label in [self labels]){
            [label setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
            [label setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
        }
        
        //Add save button at right in navigation bar.
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveData:)];
        [saveButton setTitle:@"Save"];
        [[self navigationItem]setRightBarButtonItem:saveButton];
        
        //Set Keyboard type to numeric with decimal point.
        [[self heightTextField]setKeyboardType:UIKeyboardTypeDecimalPad];
        [[self widthTextField]setKeyboardType:UIKeyboardTypeDecimalPad];
        
        //Init profile & chain segment to realtime change BMR.
        [self initMyProfile];
        [[self sexSegmentControl]addTarget:self action:@selector(changeBMR) forControlEvents:UIControlEventValueChanged];
        
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
    [super touchesBegan:touches withEvent:event];
    [[self heightTextField] resignFirstResponder];
    [[self widthTextField] resignFirstResponder];
    [[self ageTextField] resignFirstResponder];
}
-(void)initMyProfile{
    myProfile  = ((AppDelegate*)[[UIApplication sharedApplication]delegate]).myProfile;
    [[self heightTextField]setText:[NSString stringWithFormat:@"%.1f",[[self myProfile]myHeight]]];
    [[self widthTextField]setText:[NSString stringWithFormat:@"%.1f",[[self myProfile]myWeight]]];
    [[self ageTextField]setText:[NSString stringWithFormat:@"%.0f",[[self myProfile]myAge]]];
    [[self sexSegmentControl]setSelectedSegmentIndex:[[self myProfile]myGender]];
    [[self BMILabel]setText:[NSString stringWithFormat:@"%.2f",[[self myProfile] getBMI]]];
    [[self BMRLabel]setText:[NSString stringWithFormat:@"%.0f",[[self myProfile] getBMR]]];
    //NSLog(@"%@",myProfile);
}
-(void) changeBMR{
    [myProfile setMyGender:[[NSNumber numberWithInt:[[self sexSegmentControl]selectedSegmentIndex ]] boolValue]];
[[self BMRLabel]setText:[NSString stringWithFormat:@"%.0f",[[self myProfile] getBMR]]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)saveData:(id)sender{
    [myProfile setMyHeight:[[[self heightTextField]text] floatValue]];
    [myProfile setMyWeight:[[[self widthTextField]text] floatValue]];
    [myProfile setMyAge:[[[self ageTextField]text]floatValue]];
    [myProfile setMyGender:[[NSNumber numberWithInt:[[self sexSegmentControl]selectedSegmentIndex ]] boolValue]];
    //NSLog(@"%@",myProfile);
    [myProfile saveData];
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]) reloadProfile];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(NSString *)dataFilePath{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"myprofile.plist"];
}
- (void)viewDidUnload
{
    [self setLabels:nil];
    [self setBMILabel:nil];
    [self setBMRLabel:nil];
    [self setMyProfile:nil];
    [self setSexSegmentControl:nil];
    [self setHeightTextField:nil];
    [self setWidthTextField:nil];
    [self setAgeTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
