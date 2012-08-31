//
//  GoalViewController.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GoalViewController : UIViewController<UIApplicationDelegate,UIAlertViewDelegate>{
    UIFont *myFont;
}
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *blweights;
@property (weak, nonatomic) IBOutlet UIProgressView *weightProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *dateProgress;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIButton *addWeight;

- (void)reloadProgress;
- (void) loadgraph;
- (IBAction)addGoals:(id)sender;
- (IBAction)addButtonGoals:(UIButton *)sender;
@end