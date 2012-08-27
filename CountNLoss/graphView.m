//
//  graphView.m
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/27/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import "graphView.h"
#define kGraphHeight 250
#define kGraphWidth 250

#define kStepX 20
#define kStepY 20
//Offset
#define kOffsetX 50
#define kOffsetY 20

#define kCircleRadius 3

@implementation graphView
float data[] = {0.7, 0.4, 0.9, 1.0, 0.2, 0.85, 0.11, 0.75, 0.53, 0.44, 0.88, 0.77, 0.99, 0.55};
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.6);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    
    
    // How many lines?
    //int howMany = (kDefaultGraphWidth - kOffsetX) / kStepX;
    // Here the lines go
    /*for (int i = 0; i < howMany; i++)
    {
        CGContextMoveToPoint(context, kOffsetX + i * kStepX, kGraphTop);
        CGContextAddLineToPoint(context, kOffsetX + i * kStepX, kGraphBottom);
    }*/
    CGContextMoveToPoint(context, kOffsetX, kOffsetY);
    CGContextAddLineToPoint(context, kOffsetX ,10 +kGraphHeight);
    //CGContextMoveToPoint(context, kOffsetX + kGraphHeight, kOffsetY + kGraphHeight);
    CGContextAddLineToPoint(context, kOffsetX +kGraphWidth, 10+kGraphHeight);
    CGContextSetLineWidth(context,2);
    CGContextStrokePath(context);
    
    int howManyHorizontal = kGraphHeight / kStepY;
    for (int i = 1; i <= howManyHorizontal; i++)
    {
        CGContextMoveToPoint(context, kOffsetX, kOffsetY + (i * kStepY));
        CGContextAddLineToPoint(context, kOffsetX + kGraphWidth, kOffsetY + (i * kStepY));
    }
    //CGFloat dash[] = {2.0, 2.0};
    //CGContextSetLineDash(context, 0.0, dash, 2);
    CGContextSetLineWidth(context,1);
    CGContextStrokePath(context);
    
    [self drawLineGraphWithContext:context];
	NSLog(@"Graph Init %i line",howManyHorizontal);
}
- (void)drawLineGraphWithContext:(CGContextRef)ctx
{
    

    CGContextSetFillColorWithColor(ctx, [[UIColor grayColor] CGColor]);
    NSString *theText = @"แคลอรี่";
    [theText drawAtPoint:CGPointMake(80, 80)
               withFont:[UIFont systemFontOfSize:12]];
    //CGContextSetTextMatrix (ctx, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    //CGContextShowTextAtPoint(ctx, 100, 100, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    
    
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    int maxGraphHeight = kGraphHeight - kOffsetY;
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, kOffsetX, kGraphHeight - maxGraphHeight * data[0]);
    for (int i = 1; i < sizeof(data); i++)
    {
        CGContextAddLineToPoint(ctx, kOffsetX + i * kStepX, kGraphHeight - maxGraphHeight * data[i]);
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    for (int i = 1; i < sizeof(data) - 1; i++)
    {
        float x = kOffsetX + i * kStepX;
        float y = kGraphHeight - maxGraphHeight * data[i];
        CGRect rect = CGRectMake(x - kCircleRadius, y - kCircleRadius, 2 * kCircleRadius, 2 * kCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
}


@end
