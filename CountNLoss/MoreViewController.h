//
//  MoreViewController.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDataSource,UITableViewDataSource>

@property (nonatomic) NSArray *moreMenu;
@property (nonatomic) NSArray *moreSection;
@property (weak, nonatomic) IBOutlet UITableView *moreTableView;

@end
