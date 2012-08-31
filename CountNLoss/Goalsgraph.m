//
//  Goalsgraph.m
//  CountNLoss
//
//  Created by Shoo on 8/30/55 BE.
//  Copyright (c) 2555 A. All rights reserved.
//

#import "Goalsgraph.h"

#define gGraphHeight 200
#define gDefaultGraphWidth 280

#define gStepX 20
#define gStepY 20
//Offset
#define gOffsetX 30
#define gOffsetY 10

#define gCircleRadius 3
#define gGraphTop 10
#define gGraphBottom 200
@implementation Goalsgraph
float gdata[] = {0.7, 0.4, 0.9, 1.0, 0.2, 0.85, 0.11, 0.75, 0.53, 0.44, 0.88, 0.77, 0.99, 0.55};
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
    CGContextSetStrokeColorWithColor(context, [[UIColor grayColor] CGColor]);
    //CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
   
   
    // How many lines?
    //int howMany = (gDefaultGraphWidth - gOffsetX) / gStepX;
    // Here the lines go
    /*for (int i = 0; i < howMany; i++)
     {
     CGContextMoveToPoint(context, gOffsetX + i * gStepX, gGraphTop);
     CGContextAddLineToPoint(context, gOffsetX + i * gStepX, gGraphBottom);
     }*/
    CGContextMoveToPoint(context, gOffsetX, gOffsetY);
    CGContextAddLineToPoint(context, gOffsetX ,gGraphHeight-10);
    //CGContextMoveToPoint(context, gOffsetX + gGraphHeight, gOffsetY + gGraphHeight);
    CGContextAddLineToPoint(context, gOffsetX +gDefaultGraphWidth,gGraphHeight-10);
    CGContextSetLineWidth(context,1);
    CGContextStrokePath(context);
    
    
    CGContextSelectFont(context,"TH SarabunPSK", 18, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    //CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0] CGColor]);
    CGContextSetTextMatrix (context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    int howMany = (gDefaultGraphWidth - gOffsetX) / gStepX;
    
    // Here the lines go
    for (int i = 0; i <= howMany; i++)
    {
        if(i!=0){
            NSString *date = [NSString stringWithFormat:@"%d", i];
            CGContextShowTextAtPoint(context,  (gOffsetX + i * gStepX)-3, gGraphBottom+5, [date cStringUsingEncoding:NSUTF8StringEncoding], [date length]);
            CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:0.2] CGColor]);
            CGContextMoveToPoint(context, gOffsetX + i * gStepX, 10);
            CGContextAddLineToPoint(context, gOffsetX + i * gStepX, gGraphBottom-10);
            CGContextSetLineWidth(context,12);
            CGContextStrokePath(context);
        }
    }
    int howManyHorizontal = (gGraphBottom - gGraphTop - gOffsetY) / gStepY;
    NSLog(@"%d",howManyHorizontal);
    int cal=20;
    int avg=cal/10;
    for (int i = 0; i <= howManyHorizontal; i++)
    {
        NSString *theText = [NSString stringWithFormat:@"%d",cal];
        CGContextShowTextAtPoint(context,  gOffsetX-20, (gOffsetY + (i * gStepY))+5, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
        CGContextSetStrokeColorWithColor(context, [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] CGColor]);
        CGContextMoveToPoint(context, gOffsetX, gGraphBottom - gOffsetY - i * gStepY);
		CGContextAddLineToPoint(context, gDefaultGraphWidth, gGraphBottom - gOffsetY - i * gStepY);
        CGContextSetLineWidth(context,0.5);
        CGContextStrokePath(context);
        cal=cal-avg;
    }
    //CGFloat dash[] = {2.0, 2.0};
    //CGContextSetLineDash(context, 0.0, dash, 2);
    CGContextSetLineWidth(context,1);
    CGContextStrokePath(context);
    [self drawLineGraphWithContext:context];
	//NSLog(@"Graph Init %i line",howManyHorizontal);
}
- (void)drawLineGraphWithContext:(CGContextRef)ctx
{
    
    
    CGContextSetFillColorWithColor(ctx, [[UIColor grayColor] CGColor]);
    
    //CGContextSetTextMatrix (ctx, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0));
    //CGContextShowTextAtPoint(ctx, 100, 100, [theText cStringUsingEncoding:NSUTF8StringEncoding], [theText length]);
    
    
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    int maxGraphHeight = gGraphHeight - gOffsetY;
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, gOffsetX, gGraphHeight - maxGraphHeight * gdata[0]);
    for (int i = 1; i < sizeof(gdata); i++)
    {
        CGContextAddLineToPoint(ctx, gOffsetX + i * gStepX, gGraphHeight - maxGraphHeight * gdata[i]);
        
    }
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:1.0 green:0.5 blue:0 alpha:1.0] CGColor]);
    for (int i = 1; i < sizeof(gdata) - 1; i++)
    {
        float x = gOffsetX + i * gStepX;
        float y = gGraphHeight - maxGraphHeight * gdata[i];
        CGRect rect = CGRectMake(x - gCircleRadius, y - gCircleRadius, 2 * gCircleRadius, 2 * gCircleRadius);
        CGContextAddEllipseInRect(ctx, rect);
    }
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
}
@end
