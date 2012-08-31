//
//  NoticeViewController.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/30/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *noticeTableView;

@end
