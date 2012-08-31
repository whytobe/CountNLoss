//
//  ProfileViewController.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/23/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountAndLoss.h"
#import "EPUploader.h"

@interface ProfileViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UILabel *BMILabel;
@property (weak, nonatomic) IBOutlet UILabel *BMRLabel;
@property (nonatomic) CountAndLoss *myProfile;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *widthTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentControl;
@property (nonatomic) int uploadIndicator;
@property (nonatomic) EPUploader *historyUploader;
@property (nonatomic) EPUploader *profileUploader;
@property (nonatomic) EPUploader *customUploader;
@property (nonatomic) UIAlertView *backUpAlertView;
@property (nonatomic) UIAlertView *restoreAlertView;
@property (weak, nonatomic) IBOutlet UIButton *backupButton;
@property (weak, nonatomic) IBOutlet UIButton *restoreButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *uploadAnimator;
- (IBAction)backUpData:(id)sender;
- (IBAction)restoreData:(id)sender;
@end
