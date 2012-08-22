//
//  HistoryViewController.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"History" image:[UIImage imageNamed:@"history"] tag:0];
        [self.tabBarItem setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"history"]];
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
