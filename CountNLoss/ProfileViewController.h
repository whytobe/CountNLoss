//
//  ProfileViewController.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/23/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (weak, nonatomic) IBOutlet UILabel *BMILabel;
@property (weak, nonatomic) IBOutlet UILabel *BMRLabel;

@end
