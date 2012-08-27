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
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [[cell textLabel]setText:@"ประวัติการรับประทานอาหาร : x - x สิงหาคม 2555"];
            [[cell textLabel] setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
            [[cell textLabel] setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
            [[cell textLabel] setTextAlignment:UITextAlignmentCenter];

        }
            break;
        case 2 :
        {
            cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];
            calendar = 	[[TKCalendarMonthView alloc] init];
            calendar.delegate = self;
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
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"History" image:[UIImage imageNamed:@"history"] tag:0];
        [self.tabBarItem setFinishedSelectedImage:nil withFinishedUnselectedImage:[UIImage imageNamed:@"history"]];
        [[self tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil] forState:UIControlStateNormal];
        
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        [[self historyTableView]setBackgroundColor:[UIColor clearColor]];
        
        
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [calendar reload];
    [historyTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
	[self generateRandomDataForStartDate:startDate endDate:lastDate];
	return dataArray;
}

-(void)calendarMonthView:(TKCalendarMonthView *)monthView monthWillChange:(NSDate *)month animated:(BOOL)animated{
    NSLog(@"Will Change Month");
}
- (void) calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date{
	
	// CHANGE THE DATE TO YOUR TIMEZONE
	//TKDateInformation info = [date dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	//NSDate *myTimeZoneDay = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone systemTimeZone]];
	//[calendar selectDate:date];
	NSLog(@"Date Selected: %@",date);
	
	//[self.tableView reloadData];
}

- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
	
	NSLog(@"Delegate Range: %@ %@ %d",start,end,[start daysBetweenDate:end]);
	
	self.dataArray = [NSMutableArray array];
	//self.dataDictionary = [NSMutableDictionary dictionary];
	
	NSDate *d = start;
	while(YES){
		
		int r = arc4random();
		if(r % 3==1){
			//[self.dataDictionary setObject:[NSArray arrayWithObjects:@"Item one",@"Item two",nil] forKey:d];
			[self.dataArray addObject:[NSNumber numberWithBool:YES]];
			
		}else if(r%4==1){
			//[self.dataDictionary setObject:[NSArray arrayWithObjects:@"Item one",nil] forKey:d];
			[self.dataArray addObject:[NSNumber numberWithBool:YES]];
			
		}else
			[self.dataArray addObject:[NSNumber numberWithBool:NO]];
		
		
		TKDateInformation info = [d dateInformationWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		info.day++;
		d = [NSDate dateFromDateInformation:info timeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
		if([d compare:end]==NSOrderedDescending) break;
	}
	
}

- (void)viewDidUnload
{
    [self setHistoryTableView:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
