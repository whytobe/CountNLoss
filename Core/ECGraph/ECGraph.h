//
//  ECGraph.h
//  ECGraph
//
//  Created by ris on 10-4-17.
//  Copyright 2010 tigris.shin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECGraphItem.h"
#import "ECGraphPoint.h"
#import "ECGraphLine.h"
#import "ECCommon.h"

typedef enum
{
	ECGraphStatusPortrait,
	ECGraphStatusLandspace = 1 << 1
}ECGraphStatus;

typedef enum
{
	ECGraphTimeFormat24,
	ECGraphTimeFormatAMPM = 1 << 1
}ECGraphTimeFormat;

typedef enum
{
	ECGraphModeNormal,
	ECGraphModeAdvancedMenu = 1 << 1,
	ECGraphModeAdvancedDynamicLine = 1 << 2,
	ECGraphModeAdvancedMenuAndDynamicLine = 1 <<3
}ECGraphMode;

typedef enum
{
	ECGraphPointTypeNone,
	ECGraphPointTypeCircle = 1 << 1,
	ECGraphPointTypeTriangle = 1 << 2,
	ECGraphPointTypeSquare = 1 << 3
}ECGraphPointType;


@protocol ECGraphDelegate

@end


@interface ECGraph : NSObject {
	CGContextRef		_context;
	UIColor				*_backgroundColor;
	CGRect				_frame;
	CGFloat				_screenHeight;
	CGFloat				_screenWidth;
	int						_xSpacing;
	int						_ySpacing;
	float						_xaxisLength;
	float						_yaxisLength;
	
	//titles
	NSString			*_xaxisTitle;
	NSString			*_yaxisTitle;
	NSString			*_graphicTitle;
	
	//ECGraph enum
	ECGraphStatus					_graphStatus;
	ECGraphTimeFormat		_timeFormat;
	ECGraphMode					_graphMode;
	ECGraphPointType			_pointType;
	
	//Date Format
	NSString			*_xaxisDateFormat;
	NSString			*_yaxisDateFormat;
	
	//Axis Points
	CGPoint				_xaxisStart;
	CGPoint				_xaxisEnd;
	CGPoint				_yaxisStart;
	CGPoint				_yaxisEnd;
	
	//draw lines
 	float		_xPointsCount;
	float		_xSpacingLength;
	float		_ySpacingScale;
	float		_ySpacingLength;
	
	NSDate *_minDate;
	
	float		_histogramStartX;
	float		_histogramSpacing;
	
	id<ECGraphDelegate>	_delegate;
	
}
//get a flag to point draw a protrait graphic or a landspace graphic,default is portrait
@property (nonatomic, readonly) ECGraphStatus graphStatus;

/*
 ECGraphic set and get property,please set them before calling function 
 drawGraphicWithXaxisPoints:withYaxisPoints:lineWidth:color:*/
//set grahic background color
@property (nonatomic, retain) UIColor *backgroundColor;
//x-axis spacing of graphic default is 50
@property (nonatomic, assign) int xSpacing;
//y-axis spacing of graphic default is 30
@property (nonatomic, assign) int ySpacing;
@property (nonatomic, retain) NSString *xaxisTitle;
@property (nonatomic, retain) NSString *yaxisTitle;
@property (nonatomic, retain) NSString *graphicTitle;
//if the input point array is date type,it will use to decide time display format,24 or AMPM,default is 24
@property (nonatomic, assign) ECGraphTimeFormat timeFormat;
//set ECGraphic display mode,defalut is ECGraphicModeNormal
@property (nonatomic, assign) ECGraphMode graphMode;
//set Point Type,default is ECGraphPointTypeCircle
@property (nonatomic, assign) ECGraphPointType pointType;
@property (nonatomic, retain) id<ECGraphDelegate> delegate;
/*
 set date format of x-axis and y-axis default is mm-dd*/
@property(nonatomic, retain) NSString *xaxisDateFormat;
@property(nonatomic, retain) NSString *yaxisDateFormat;

-(id)initWithFrame:(CGRect)frame withContext:(CGContextRef)context isPortrait:(BOOL)isPortrait;
-(void)drawLineWithPoints:(NSArray *)points lineWidth:(int)lineWidth color:(UIColor *)color;
-(void)drawCurveWithLines:(NSArray *)lines lineWidth:(int)lineWidth color:(UIColor *)color;
-(void)drawHistogramWithItems:(NSArray *)items lineWidth:(int)lineWidth color:(UIColor *)color;
-(void)drawHistogramWithItem:(ECGraphItem *)item index:(int)index color:(UIColor *)color;

@end

