//
//  searchTextField.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/20/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "searchTextField.h"

@implementation searchTextField

-(CGRect)textRectForBounds:(CGRect)bounds{
CGRect inset = CGRectMake(bounds.origin.x + 5,bounds.origin.y, bounds.size.width -10, bounds.size.height);
return inset;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 5,bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
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
