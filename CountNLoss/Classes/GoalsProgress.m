//
//  GoalsProgress.m
//  CountNLoss
//
//  Created by Shoo on 8/30/55 BE.
//  Copyright (c) 2555 A. All rights reserved.
//

#import "GoalsProgress.h"
#define kCustomProgressViewFillOffsetX 0
#define kCustomProgressViewFillOffsetTopY 1
#define kCustomProgressViewFillOffsetBottomY 3
@implementation GoalsProgress

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
    UIImage *background = [[UIImage imageNamed:@"progress-goals-bg.png"] stretchableImageWithLeftCapWidth:backgroundStretchPoints.width
                                                                                           topCapHeight:backgroundStretchPoints.height];
    
    UIImage *fill = [[UIImage imageNamed:@"progress-goals-fill.png"] stretchableImageWithLeftCapWidth:fillStretchPoints.width
                                                                                       topCapHeight:fillStretchPoints.height];
    
    // Draw the background in the current rect
    [background drawInRect:rect];
    
    // Compute the max width in pixels for the fill.  Max width being how
    // wide the fill should be at 100% progress.
    NSInteger maxWidth = rect.size.width - (2 * kCustomProgressViewFillOffsetX);
    
    // Compute the width for the current progress value, 0.0 - 1.0 corresponding
    // to 0% and 100% respectively.
    NSInteger curWidth = floor([self progress] * maxWidth);
    curWidth = (curWidth < 15)? 15 : curWidth;
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
