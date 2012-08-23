//
//  AboutCountAndLossViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/23/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "AboutCountAndLossViewController.h"

@interface AboutCountAndLossViewController ()

@end

@implementation AboutCountAndLossViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismissPage];
}
- (void)dismissPage{
    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self dismissModalViewControllerAnimated:YES];
    [self viewDidUnload];
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
