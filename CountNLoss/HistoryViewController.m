//
//  HistoryViewController.m
//  CountAndLoss
//
//  Created by MacBookPro MacBookPro on 8/10/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "HistoryViewController.h"
#import "ECCommon.h"
#import "ECGraphPoint.h"
#import "ECGraphLine.h"
#import "ECGraphItem.h"
#import "graphView.h"
#import "HistoryDetailController.h"
@interface HistoryViewController ()

@end

@implementation HistoryViewController
@synthesize historyTableView;
@synthesize calendar,dataArray,dataDictionary;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight = 0.0;
    switch (indexPath.row) {
        case 0:
        {
            rowHeight = 40;
        }
            break;
        case 1:
        {
            rowHeight = 300;
        }
            break;
        case 2 :
        {
            rowHeight = 310;
        }
        default:
            break;
    }
    return rowHeight;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    switch (indexPath.row) {
        case 0:
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [[cell textLabel]setText:@"ประวัติการรับประทานอาหาร : x - x สิงหาคม 2555"];
            [[cell textLabel] setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
            [[cell textLabel] setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
            [[cell textLabel] setTextAlignment:UITextAlignmentCenter];

        }
            break;
        case 1:
        {
            cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
            UIView *myGraphView = [[graphView alloc] initWithFrame:CGRectMake(0,0, 300, 300)];
            [myGraphView setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:myGraphView];
        }
            break;
        case 2 :
        {
            cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
            calendar = 	[[TKCalendarMonthView alloc] init];
            calendar.dataSource = self;
            calendar.frame = CGRectMake(0, 0, self.calendar.frame.size.width, self.calendar.frame.size.height);

            [cell.contentView addSubview:calendar];
            
        }
        default:
            break;
    }
    return cell;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"History"];
        [self setDataArray:[[NSMutableArray alloc]init]];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"History" image:[UIImage imageNamed:@"history"] tag:0];
        [self.tabBarItem setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"history"]];
        [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        [[self historyTableView]setBackgroundColor:[UIColor clearColor]];
        
        
        
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    calendar.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [calendar reload];
    [historyTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
	return dataArray;
}

-(void)calendarMonthView:(TKCalendarMonthView *)monthView monthWillChange:(NSDate *)month animated:(BOOL)animated{
    NSLog(@"Will Change Month");
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
    NSDateFormatter* localTime = [[NSDateFormatter alloc] init];
    [localTime setDateFormat:@"yyyy-MM-dd"];
     UIViewController *historyDetail = [[HistoryDetailController alloc] initWithNibName:@"HistoryDetailController" bundle:nil inDate:[localTime stringFromDate:date]];
    [calendar setDelegate:nil];
    [[self navigationController]pushViewController:historyDetail animated:YES];
	NSLog(@"Date Selected: %@",[localTime stringFromDate:date]);

}


- (void)viewDidUnload
{
    [self setHistoryTableView:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
