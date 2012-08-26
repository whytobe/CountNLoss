//
//  calorieProgess.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/24/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "calorieProgess.h"
#define kCustomProgressViewFillOffsetX 2
#define kCustomProgressViewFillOffsetTopY 1
#define kCustomProgressViewFillOffsetBottomY 4
@implementation calorieProgess

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGSize backgroundStretchPoints = {21, 18}, fillStretchPoints = {15,15};
    
    // Initialize the stretchable images.
    UIImage *background = [[UIImage imageNamed:@"progress-bar-bg.png"] stretchableImageWithLeftCapWidth:backgroundStretchPoints.width 
                                                                                           topCapHeight:backgroundStretchPoints.height];
    
    UIImage *fill = [[UIImage imageNamed:@"progress-bar-fill.png"] stretchableImageWithLeftCapWidth:fillStretchPoints.width 
                                                                                       topCapHeight:fillStretchPoints.height];  
    
    // Draw the background in the current rect
    [background drawInRect:rect];
    
    // Compute the max width in pixels for the fill.  Max width being how
    // wide the fill should be at 100% progress.
    NSInteger maxWidth = rect.size.width - (2 * kCustomProgressViewFillOffsetX);
    
    // Compute the width for the current progress value, 0.0 - 1.0 corresponding 
    // to 0% and 100% respectively.
    NSInteger curWidth = floor([self progress] * maxWidth);
    
    // Create the rectangle for our fill image accounting for the position offsets,
    // 1 in the X direction and 1, 3 on the top and bottom for the Y.
    CGRect fillRect = CGRectMake(rect.origin.x + kCustomProgressViewFillOffsetX,
                                 rect.origin.y + kCustomProgressViewFillOffsetTopY,
                                 curWidth,
                                 rect.size.height - kCustomProgressViewFillOffsetBottomY);
   
    // Draw the fill
    [fill drawInRect:fillRect];
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
