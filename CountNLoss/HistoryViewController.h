//
//  HistoryViewController.h
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "ECCommon.h"
@interface HistoryViewController : UIViewController<TKCalendarMonthViewDataSource,TKCalendarMonthViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) TKCalendarMonthView *calendar;
@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) NSMutableDictionary *dataDictionary;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;

@end
