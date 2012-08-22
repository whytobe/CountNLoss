//
//  FoodCategoryButton.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/17/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "FoodCategoryButton.h"
#define BUTTON_WIDTH 72
#define BUTTON_HEIGHT 72
#define PADDING_TOP 36
#define PADDING_LEFT 16
#define PADDING_BOTTOM 10
#define COLUMNS 4
@implementation FoodCategoryButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (id)initWithType:(NSString*)type withCaption:(NSString*)caption isLocked:(BOOL)locked atPosition:(int)position{
    position = position-1;
    float yPos = PADDING_TOP+(((position/COLUMNS)*BUTTON_WIDTH) + ((position/COLUMNS)*PADDING_BOTTOM));
    float xPos = PADDING_LEFT+((position%COLUMNS)*BUTTON_WIDTH);
    self = [super initWithFrame:CGRectMake(xPos, yPos, BUTTON_WIDTH, BUTTON_HEIGHT)];
    [self setTitle:type forState:UIControlStateNormal];
    [self setBackgroundImage:locked?[UIImage imageNamed:@"button_unavailable"]:[UIImage imageNamed:@"button_available"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:type ] forState:UIControlStateNormal];
    if (locked){
        [self addSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_locked"]]];
    }
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 38, BUTTON_WIDTH-10, BUTTON_HEIGHT)];
    [myLabel setTextAlignment:UITextAlignmentCenter];
    [myLabel setText:caption];
    [myLabel setBackgroundColor:[UIColor clearColor]];
    [myLabel setFont:[UIFont systemFontOfSize:14]];
    [myLabel setTextColor:[UIColor grayColor]];
    [myLabel setNumberOfLines:1];
    //[myLabel text
    [self addSubview:myLabel];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
