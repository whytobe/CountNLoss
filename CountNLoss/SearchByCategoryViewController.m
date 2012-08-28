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
        if (catTypeValue == @"1"){
            [[self foodIcon]setHidden:YES];
            [[self categoryName] setText:@"ค้นหาอาหารจากทุกประเภท"];
            [[self categoryName] setFrame:CGRectMake(20, 30, 280, 30)];
            [[self searchText] setFrame:CGRectMake(20, 65, 260, 20)];
        }
        
        UITapGestureRecognizer *tapTableView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignAllTextField)];
    
        [resultTableView addGestureRecognizer:tapTableView];
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
    if ([self searchCategory] == @"112"){ 
        //NSLog(@"Most : %@",[CalorieHistory getMostFavouriteFood]);
        self.filteredFoodArray = [[CalorieHistory getMostFavouriteFood] valueForKey:@"calorieFoodId"];
    } else {
        if ([string length] == 0) string = @"^";
        NSIndexSet *indexFilteredFood = [[self.foodArray objectForKey:@"foodName"] indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
            NSString *s = (NSString*)obj;
            NSRange range = [s rangeOfString: string options:NSStringEnumerationLocalized];
            return range.location != NSNotFound;
        }];
        NSMutableArray *tempFilterArray = [[NSMutableArray alloc]init];
        [indexFilteredFood enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [tempFilterArray addObject:[NSNumber numberWithInteger:idx]];
        }];
        //Intersect Filter
        NSMutableSet *intersection = [NSMutableSet setWithArray:tempFilterArray];
        
        NSIndexSet *indexFilteredCategory = [[self.foodArray objectForKey:@"foodType"] indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
            NSString *s = (NSString*)obj;
            NSRange range = [s rangeOfString: self.searchCategory options:NSStringEnumerationLocalized];
            return range.location != NSNotFound;
        }];
        
        NSMutableArray *tempFilterCategory = [[NSMutableArray alloc]init];
        [indexFilteredCategory enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [tempFilterCategory addObject:[NSNumber numberWithInteger:idx]];
        }];
        
        [intersection intersectSet:[NSMutableSet setWithArray:tempFilterCategory]];
        
        self.filteredFoodArray = [intersection allObjects];
        
        tempFilterCategory = nil;
        indexFilteredCategory = nil;
        tempFilterArray = nil;
        indexFilteredFood = nil;
        intersection = nil;
    }
    NSMutableArray *zeroDebug = [NSMutableArray arrayWithArray: self.filteredFoodArray];
    [zeroDebug removeObjectIdenticalTo:[NSNumber numberWithInt:0]];
    self.filteredFoodArray = [NSArray arrayWithArray:zeroDebug];
    zeroDebug = nil;
    //NSLog(@"Intersec %@ with %@ result : %@",[NSMutableSet setWithArray:tempFilterArray],[NSMutableSet setWithArray:tempFilterCategory],[intersection allObjects]);
    //NSLog(@"Filter Food Array from category %@ : %@",self.searchCategory,self.filteredFoodArray);
    
    
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
    
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

        [[cell textLabel]setText:[NSString stringWithFormat:@"%@",[[self.foodArray valueForKey:@"foodName"]objectAtIndex:rowIndex]]];
        [[cell textLabel]setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
        [[cell textLabel]setTextColor:[UIColor grayColor]];
        
        [[cell detailTextLabel]setText:[NSString stringWithFormat:@"%@ แคลอรี่", [[self.foodArray valueForKey:@"foodCalorie"]objectAtIndex:rowIndex]]];
        [[cell detailTextLabel]setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
        [[cell detailTextLabel]setTextColor:[UIColor grayColor]];
    } else {
        [[cell textLabel]setText:[NSString stringWithFormat:@"%@",[[self.foodArray valueForKey:@"foodName"]objectAtIndex:rowIndex]]];
        [[cell detailTextLabel]setText:[NSString stringWithFormat:@"%@ แคลอรี่", [[self.foodArray valueForKey:@"foodCalorie"]objectAtIndex:rowIndex]]];

    }
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
