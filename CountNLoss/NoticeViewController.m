//
//  NoticeViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/30/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeDetailViewController.h"
@interface NoticeViewController ()

@end

@implementation NoticeViewController
@synthesize noticeTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle:@"Notices"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        [[self noticeTableView]setBackgroundColor:nil];
    }
    return self;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Notice Tap");
    NoticeDetailViewController *detailPage = [[NoticeDetailViewController alloc]initWithNibName:@"NoticeDetailViewController" bundle:nil];
    [detailPage.noticeTitleText setText:@"Title For Notice"];
    [detailPage setTitle:@"Title for notice"];
    [detailPage.noticeDetailText setText:@"Description for notice"];
    [self.navigationController pushViewController:detailPage animated:YES];
    detailPage = nil;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    [cell.textLabel setText:@"Title"];
    [cell.detailTextLabel setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque elementum dolor ac quam tincidunt non pharetra massa placerat. Morbi lectus purus, pretium in iaculis ac, condimentum ut lectus. Morbi euismod ultrices nibh in viverra. Cras interdum viverra lectus vel pretium. Integer ornare arcu mattis dui semper et convallis libero sollicitudin. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a metus vitae augue lacinia eleifend a ut neque. Maecenas sed metus et quam malesuada blandit. Mauris quis mauris ut ligula facilisis accumsan.\nNam tincidunt convallis libero eu convallis. Vestibulum porttitor mauris non magna tincidunt et varius purus adipiscing. Aliquam erat volutpat. In accumsan eros in diam elementum lacinia. Nullam at ante nunc, ac auctor turpis. Phasellus nec sem sit amet est cursus varius. Donec elementum luctus orci, non scelerisque enim elementum non. Nullam nunc ante, imperdiet sit amet aliquet a, laoreet vel turpis. Nullam mollis volutpat hendrerit. Pellentesque vitae nunc arcu. In ullamcorper leo mollis enim vulputate malesuada. Phasellus eget ipsum sem, quis scelerisque lectus."];
    
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNoticeTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
