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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"More" image:[UIImage imageNamed:@"more"] tag:0];
        [self.tabBarItem setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"more"]];
        [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
