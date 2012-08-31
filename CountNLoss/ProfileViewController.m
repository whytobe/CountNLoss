//
//  ProfileViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/23/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "ProfileViewController.h"
#import "CountAndLoss.h"
#import "EPUploader.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize backupButton;
@synthesize restoreButton;
@synthesize uploadAnimator;
@synthesize heightTextField;
@synthesize widthTextField;
@synthesize ageTextField;
@synthesize sexSegmentControl;
@synthesize labels,myProfile;
@synthesize BMILabel;
@synthesize BMRLabel;
@synthesize backUpAlertView,restoreAlertView,historyUploader,profileUploader,customUploader,uploadIndicator;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Profile"];
        uploadIndicator = 0;
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == heightTextField) {
        [widthTextField becomeFirstResponder];
    } else if (textField == widthTextField){
        [ageTextField becomeFirstResponder];
    }
    return true;
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
    [self setUploadAnimator:nil];
    [self setBackupButton:nil];
    [self setRestoreButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(NSString *) getHistoryPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"history.sqlite"];
}
-(NSString *) getProfilePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"myprofile.plist"];
}
-(NSString *) getMyDBPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"mydb.sqlite"];
}

-(void)uploadComplete:(id)sender{
    
    if (sender == historyUploader){
        NSLog(@"Upload history.sqlite Complete");
        historyUploader = nil;
    } else if (sender == customUploader){
        NSLog(@"Upload mydb.sqlite Complete");
        customUploader = nil;
    } else if (sender == profileUploader){
        NSLog(@"Upload profile.plist Complete");
        profileUploader = nil;
    }
    if (++uploadIndicator == 3){
        NSLog(@"Upload All Complete.");
        [uploadAnimator stopAnimating];
        [self enableButton];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1){
        if (alertView == backUpAlertView){
            NSString *filename = [NSString stringWithFormat:@"%@%@",[[alertView textFieldAtIndex:0] text],[[alertView textFieldAtIndex:1] text]];
            uploadIndicator = 0;
            [uploadAnimator startAnimating];
            historyUploader = [[EPUploader alloc] initWithURL:[NSURL URLWithString:@"http://grasp.asia/countnloss/upload.php"]
                                                     filePath:[self getHistoryPath]
                                                     fileName:[NSString stringWithFormat:@"%@_history.sqlite",filename]
                                                     delegate:self
                                                 doneSelector:@selector(uploadComplete:)
                                                errorSelector:@selector(onUploadError:)];
            customUploader = [[EPUploader alloc] initWithURL:[NSURL URLWithString:@"http://grasp.asia/countnloss/upload.php"]
                                                    filePath:[self getMyDBPath]
                                                    fileName:[NSString stringWithFormat:@"%@_mydb.sqlite",filename]
                                                    delegate:self
                                                doneSelector:@selector(uploadComplete:)
                                               errorSelector:@selector(onUploadError:)];
            profileUploader = [[EPUploader alloc] initWithURL:[NSURL URLWithString:@"http://grasp.asia/countnloss/upload.php"]
                                                     filePath:[self getProfilePath]
                                                     fileName:[NSString stringWithFormat:@"%@_myprofile.plist",filename]
                                                     delegate:self
                                                 doneSelector:@selector(uploadComplete:)
                                                errorSelector:@selector(onUploadError:)];
            filename = nil;
            
        } else if (alertView == restoreAlertView){
            NSString *filename = [NSString stringWithFormat:@"%@%@",[[alertView textFieldAtIndex:0] text],[[alertView textFieldAtIndex:1] text]];
            NSURL *historyURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://grasp.asia/countnloss/%@_history.sqlite",filename]];
            NSURL *profileURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://grasp.asia/countnloss/%@_mydb.sqlite",filename]];
            NSURL *customDBURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://grasp.asia/countnloss/%@_myprofile.plist",filename]];
            
            
            NSData *historyFile = [NSData dataWithContentsOfURL:historyURL];
            NSData *profileFile = [NSData dataWithContentsOfURL:profileURL];
            NSData *customFoodFile = [NSData dataWithContentsOfURL:customDBURL];
            
            [self restoreFile:[self getProfilePath] withData:profileFile];
            [self restoreFile:[self getMyDBPath] withData:customFoodFile];
            [self restoreFile:[self getHistoryPath] withData:historyFile];
            
            historyFile = nil;
            profileFile = nil;
            customFoodFile = nil;
            historyURL = nil;
            profileURL = nil;
            customDBURL = nil;
        }

    } else {
        [self enableButton];
    }
    alertView = nil;
}
- (void)restoreFile:(NSString*)filePath withData:(NSData*)dataFile{
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    [dataFile writeToFile:filePath atomically:YES];
    if (error){
        NSLog(@"Error while restore file %@ : %@",filePath,error);
    }
}
- (void)disableButton{
    [backupButton setEnabled:NO];
    [restoreButton setEnabled:NO];
    [backupButton setBackgroundColor:[UIColor lightGrayColor]];
    [restoreButton setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)enableButton{
    [backupButton setEnabled:YES];
    [restoreButton setEnabled:YES];
    [backupButton setBackgroundColor:nil];
    [restoreButton setBackgroundColor:nil];
}
- (IBAction)backUpData:(id)sender {
    [self disableButton];
    backUpAlertView = [[UIAlertView alloc]initWithTitle:@"Authentication" message:@"ยืนยันการสำรองฐานข้อมูล \n กรุณากรอกชื่อผู้ใช้และรหัสผ่าน" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Backup", nil];
    [backUpAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [backUpAlertView show];
}

- (IBAction)restoreData:(id)sender {
    [self disableButton];
    restoreAlertView = [[UIAlertView alloc]initWithTitle:@"Authentication" message:@"การกู้คืนฐานข้อมูลจะทำการย้อนข้อมูลไปยังวันที่ล่าสุดที่คุณได้สำรองไว้ \nกรุณากรอกข้อมูลชื่อผู้ใช้และรหัสผ่านของท่าน" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Restore", nil];
    [restoreAlertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [restoreAlertView show];
}

- (void)onUploadDone:(id)result{
    NSLog(@"Done with : %@",result);
}
- (void)onUploadError:(id)result{
    NSLog(@"Error with : %@",result);
}
@end
