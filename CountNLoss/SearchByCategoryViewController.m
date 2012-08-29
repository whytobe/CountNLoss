//
//  SearchByCategoryViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/19/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "SearchByCategoryViewController.h"

@interface SearchByCategoryViewController ()

@end

@implementation SearchByCategoryViewController
@synthesize resultTableView;
@synthesize categoryName;
@synthesize searchText;
@synthesize searchButton;
@synthesize foodIcon;
@synthesize searchDetail;
@synthesize foodArray,filteredFoodArray;
@synthesize searchCategory,addCalorieId;

- (id)initWithCatName:(NSString *)nibNameOrNil catType:(NSString*)catTypeValue{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
    // Custom initialization
        self.searchCategory = catTypeValue;
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        [resultTableView setBackgroundColor:nil];
        [resultTableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"catBG"]]];
        self.foodArray = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).foodArray;
        [self predicateFoodArrayWithString:@""];
        [[self categoryName] setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:24]];
        [[self categoryName] setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
        [[self searchDetail] setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:16]];
        [[self searchDetail] setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:.7]];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self resignAllTextField];
}
    

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    //NSString *searchString = self.searchDisplayController.searchBar.text;
   
    
}
-(void) resignAllTextField{
    [[self searchText]resignFirstResponder];
}
-(void)predicateFoodArrayWithString:(NSString *)string{
    
    if ([string length] == 0) string = @"^";
    NSIndexSet *indexFilteredFood = [[self.foodArray objectForKey:@"foodName"] indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
        NSString *s = (NSString*)obj;
        NSRange range = [s rangeOfString: string options:NSStringEnumerationLocalized];
        return range.location != NSNotFound;
    }];
    NSMutableArray *tempFilterArray = [[NSMutableArray alloc]init];
    [indexFilteredFood enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [tempFilterArray addObject:[[self.foodArray valueForKey:@"foodId"]objectAtIndex:idx]];
    }];
    //Intersect Filter
    NSMutableSet *intersection = [NSMutableSet setWithArray:tempFilterArray];
    NSMutableArray *tempFilterCategory = [[NSMutableArray alloc]init];
    if ([self searchCategory] == @"112"){ 
        //NSLog(@"Most : %@",[CalorieHistory getMostFavouriteFood]);
        [tempFilterCategory addObjectsFromArray:[[CalorieHistory getMostFavouriteFood] valueForKey:@"calorieFoodId"]];
    } else {
        [tempFilterCategory addObjectsFromArray:[[CalorieList getAllFoodDataWithCat:self.searchCategory] valueForKey:@"foodId"]];
    }
    [intersection intersectSet:[NSMutableSet setWithArray:tempFilterCategory]];

    NSMutableDictionary *allWhole = [[NSMutableDictionary alloc]init];
    [[intersection allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [allWhole setValue:[[self.foodArray valueForKey:@"foodName"] objectAtIndex:[[self.foodArray valueForKey:@"foodId"] indexOfObject:obj]] forKey:obj];
    }];

    NSArray* sortedKeys = [allWhole keysSortedByValueUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //NSLog(@"sorted : %@",sortedKeys);
    self.filteredFoodArray = sortedKeys;
    [searchDetail setText:[NSString stringWithFormat:@"พบ %d รายการ",[[self filteredFoodArray]count]]];
    [resultTableView reloadData];
    
}

- (IBAction)pushBack:(id)sender {
    [[self navigationController]popViewControllerAnimated:YES];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *myMatch = [NSMutableString stringWithFormat:@"%@",textField.text];
    if ([string length] == 0 && range.length > 0){
        [myMatch deleteCharactersInRange:NSMakeRange(myMatch.length-1, 1)];
    } else {
        [myMatch appendString:string];
    }
    [self predicateFoodArrayWithString:myMatch];   
    myMatch = nil;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.filteredFoodArray count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSNumber *foodId = [filteredFoodArray objectAtIndex:indexPath.row];
    int rowIndex = [[self.foodArray valueForKey:@"foodId"] indexOfObject:foodId];
    //NSLog(@"Filter : %@",self.filteredFoodArray);
    

        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

        [[cell textLabel]setText:[NSString stringWithFormat:@"%@",[[self.foodArray valueForKey:@"foodName"]objectAtIndex:rowIndex]]];
        [[cell textLabel]setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
        [[cell textLabel]setTextColor:[UIColor grayColor]];
        
        [[cell detailTextLabel]setText:[NSString stringWithFormat:@"%@ แคลอรี่", [[self.foodArray valueForKey:@"foodCalorie"]objectAtIndex:rowIndex]]];
        [[cell detailTextLabel]setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
        [[cell detailTextLabel]setTextColor:[UIColor grayColor]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *foodId = [filteredFoodArray objectAtIndex:indexPath.row];
    int rowIndex = [[self.foodArray valueForKey:@"foodId"] indexOfObject:foodId];
    NSString *message = [NSString stringWithFormat:@"เพิ่ม '%@' ลงในรายการ\nอาหารที่ทานในวันนี้?",[[self.foodArray valueForKey:@"foodName"] objectAtIndex:rowIndex]];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [self setAddCalorieId:[self.filteredFoodArray objectAtIndex:indexPath.row]];
    [alertView show];
    //alertView = nil;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self searchText]resignFirstResponder];
    [super touchesBegan:touches withEvent:event];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
		//NSLog(@"user pressed OK");
        [CalorieHistory insertCalorie:[[self addCalorieId] intValue]];
        [[self navigationController]popToRootViewControllerAnimated:YES];
	}
	else {
		//NSLog(@"user pressed Cancel");
	}
    [self setAddCalorieId:nil];
}
- (void)viewDidUnload
{
    [self setResultTableView:nil];
    [self setCategoryName:nil];
    [self setSearchText:nil];
    [self setSearchButton:nil];
    [self setFoodIcon:nil];
    [self setFoodArray:nil];
    [self setFilteredFoodArray:nil];
    [self setSearchCategory:nil];
    [self setSearchDetail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
