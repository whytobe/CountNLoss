//
//  AddFoodViewController.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/29/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "AddFoodViewController.h"
#import "SelectCategoryViewController.h"
#import "CalorieList.h"
#import "AppDelegate.h"
@interface AddFoodViewController ()

@end

@implementation AddFoodViewController
@synthesize customFoodTableView;
@synthesize selectedCategoryLabel;
@synthesize selectCategoryButton;
@synthesize textFieldFoodName;
@synthesize textFieldFoodCalorie;
@synthesize labels,addFoodName,addFoodType,addFoodCalorie,foodIconArray,foodNameArray,typeIdArray,lockTypeArray,myCustomFoodDictionary,removeCustomFoodId;
@synthesize confirmInsertAlertView,confirmRemoveAlertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         foodIconArray = [NSArray arrayWithObjects:@"icon_chicken",@"icon_pork",@"icon_meat",@"icon_fish",@"icon_vegetable",@"icon_fruit",@"icon_cake",@"icon_beverage",@"icon_fastfood",@"icon_restuarant",@"icon_vine",@"icon_folkspoon",@"icon_platefolkspoon",@"icon_noodle", nil];
        foodNameArray = [NSArray arrayWithObjects:@"ไก่",@"หมู",@"เนื้อ",@"ทะเล",@"ผัก",@"ผลไม้",@"ของหวาน",@"เครื่องดื่ม",@"ฟาสต์ฟู้ด",@"ร้านอาหารชั้นนำ",@"เครื่องดื่มแอลกอฮอลล์",@"รายการที่กินบ่อย",@"อาหารยอดนิยม",@"อาหารตามสั่ง", nil];
        lockTypeArray = [NSArray arrayWithObjects:[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:NO], nil];
       typeIdArray = [NSArray arrayWithObjects:@"101",@"102",@"103",@"104",@"105",@"106",@"107",@"108",@"109",@"110",@"111",@"112",@"113",@"114", nil];

        [self setTitle:@"Add Food"];
        [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
        for (UILabel *label in [self labels]){
            [label setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:22]];
            [label setTextColor:[UIColor colorWithRed:0.521 green:0.533 blue:0.51 alpha:1]];
        }
        [[self textFieldFoodCalorie] setKeyboardType:UIKeyboardTypeDecimalPad];
        
        [customFoodTableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgList"]]];
        [customFoodTableView setBackgroundColor:nil];
        
        [[self selectedCategoryLabel]setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:18]];
        float yPos = 36+(((14/4)*72) + ((14/4)*10)) -200;
        float xPos = 16+((14%4)*72) + 10;
        UIButton *addMenuButton = [[UIButton alloc]initWithFrame:CGRectMake(xPos, yPos, 140, 72)];
        [addMenuButton setTitle:@"เพิ่ม" forState:UIControlStateNormal];
        [addMenuButton setBackgroundImage:[UIImage imageNamed:@"button_long"] forState:UIControlStateNormal];
        [[addMenuButton titleLabel]setFont:[UIFont fontWithName:@"THSarabunPSK-Bold" size:30]];
        [[addMenuButton  titleLabel]setTextColor:[UIColor whiteColor]];
        [addMenuButton addTarget:self action:@selector(insertButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        [[self view]addSubview:addMenuButton];
    }
    return self;
}
-(void)insertButtonTapped{
    [self setAddFoodName:[textFieldFoodName text]];
    [self setAddFoodCalorie:(NSNumber*)[textFieldFoodCalorie text]];
    if ([[textFieldFoodName text] length] > 0 && [[textFieldFoodCalorie text] length] > 0 && ![[[self selectedCategoryLabel ]text] isEqualToString:@"เลือกประเภท"] ){
        NSLog(@"Insert Food Name : %@, Calorie : %@, Type Id : %@",[self addFoodName],[self addFoodCalorie],[[self typeIdArray] objectAtIndex:[[self addFoodType] intValue]]);
        confirmInsertAlertView = [[UIAlertView alloc]initWithTitle:@"แจ้งเตือน" message:@"ยืนยันการเพิ่มข้อมูล" delegate:self cancelButtonTitle:@"ยกเลิก" otherButtonTitles:@"ยืนยัน", nil];
        [confirmInsertAlertView show];

    } else {
        NSLog(@"กรอกข้อมูลไม่ครบอะ");
        NSMutableString *messageAlert = [NSMutableString stringWithFormat:@"คุณยังไม่ได้"];
        if (![[textFieldFoodName text] length] > 0) [messageAlert appendString:@" กรอกชื่ออาหาร"];
        if (![[textFieldFoodCalorie text] length] > 0) [messageAlert appendString:@" กรอกปริมาณแคลอรี่"];
        if ([[selectedCategoryLabel text] isEqualToString:@"เลือกประเภท"]) [messageAlert appendString:@" เลือกประเภท"];
        confirmInsertAlertView = [[UIAlertView alloc]initWithTitle:@"แจ้งเตือน" message:messageAlert delegate:self cancelButtonTitle:@"ตกลง" otherButtonTitles:nil, nil];
        [confirmInsertAlertView show];
        messageAlert = nil;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == confirmInsertAlertView){
        if (buttonIndex == 1){
            [CalorieList addFoodWithName:[self addFoodName] andFoodType:[[self typeIdArray] objectAtIndex:[[self addFoodType] intValue]] andFoodCalorie:[self addFoodCalorie] andFoodStoreOrNil:nil];
             ((AppDelegate*)[[UIApplication sharedApplication]delegate]).foodArray = [NSDictionary dictionaryWithDictionary:[CalorieList getAllFoodData]];
            [[self textFieldFoodCalorie]setText:nil] ;
            [[self textFieldFoodName]setText:nil];
            [self.textFieldFoodName resignFirstResponder];
            [self.textFieldFoodCalorie resignFirstResponder];
            [self reloadCustomFood];
            
            //[[self navigationController] popViewControllerAnimated:YES];
        }
    } else if (alertView == confirmRemoveAlertView) {
        if (buttonIndex == 1){
            [CalorieList removeCustomFoodWithId:[[myCustomFoodDictionary valueForKey:@"foodId"] objectAtIndex:removeCustomFoodId]];
            [self setMyCustomFoodDictionary:[CalorieList getCustomFoodData]];
            [customFoodTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:removeCustomFoodId inSection:0]] withRowAnimation:UITableViewRowAnimationFade];  
            //[[self navigationController] popViewControllerAnimated:YES];
        }
    }
    alertView = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    if ([self addFoodType]){
        [[self selectCategoryButton] setTitle:nil forState:UIControlStateNormal];
        [[self selectCategoryButton] setImage:[UIImage imageNamed:[[self foodIconArray]objectAtIndex:[[self addFoodType]intValue]]] forState:UIControlStateNormal];
        [[self selectedCategoryLabel] setText:[[self foodNameArray]objectAtIndex:[[self addFoodType]intValue]]];
         //NSLog(@"%@",[self addFoodType]);
        
    } else {
        [[self selectedCategoryLabel] setText:@"เลือกประเภท"];
        [[self selectCategoryButton]setTitle:@"?" forState:UIControlStateNormal];
    }
    [self reloadCustomFood];
    [textFieldFoodCalorie resignFirstResponder];
    [textFieldFoodName resignFirstResponder];
   
}
- (void)reloadCustomFood{
    [self setMyCustomFoodDictionary:[CalorieList getCustomFoodData]];
    [customFoodTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == [self textFieldFoodName]){
        [textFieldFoodCalorie becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    return true;
}

- (void)viewDidUnload
{
    [self setLabels:nil];
    [self setSelectedCategoryLabel:nil];
    [self setTextFieldFoodName:nil];
    [self setTextFieldFoodCalorie:nil];
    [self setCustomFoodTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectCategory:(id)sender {
    SelectCategoryViewController *selectCategoryPage = [[SelectCategoryViewController alloc]initWithCategorySelectDelegate:self NibName:@"SelectCategoryViewController" bundle:nil];
    [[self navigationController]pushViewController:selectCategoryPage animated:YES];
}

- (IBAction)editButton:(id)sender {
    [customFoodTableView setEditing:![customFoodTableView isEditing] animated:YES];
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //NSLog(@"Delete row %d : %@",indexPath.row,[[[self todayCalorie] valueForKey:@"calorieId"]objectAtIndex:indexPath.row]);
        [self setRemoveCustomFoodId:indexPath.row];
        confirmRemoveAlertView = [[UIAlertView alloc]initWithTitle:@"แจ้งเตือน" message:@"การลบอาหารจะมีผลทำให้อาหารที่เคยเพิ่มไว้ในรายการที่ทานแล้วถูกลบไปด้วย \nยืนยันการลบ?" delegate:self cancelButtonTitle:@"ยกเลิก" otherButtonTitles:@"ยืนยัน", nil];
        [confirmRemoveAlertView show];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil){
    cell = [[UITableViewCell alloc]initWithStyle  :UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    [[cell textLabel] setText:[[[self myCustomFoodDictionary] objectForKey:@"foodName"]objectAtIndex:indexPath.row]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ แคลอรี่",[[[self myCustomFoodDictionary] objectForKey:@"foodCalorie"]objectAtIndex:indexPath.row ]]];
    
    [[cell textLabel] setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
    [[cell detailTextLabel] setFont:[UIFont fontWithName:@"TH SarabunPSK" size:20]];
    
    [[cell textLabel] setTextColor:[UIColor grayColor]];
    [[cell detailTextLabel] setTextColor:[UIColor grayColor]];
    
    //}
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self myCustomFoodDictionary] valueForKey:@"foodId"]count ];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [textFieldFoodName resignFirstResponder];
    [textFieldFoodCalorie resignFirstResponder];
    [customFoodTableView setEditing:NO animated:YES];
}
@end
