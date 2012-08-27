//
// ECGraphItem.m
//
// Create By ECGenerateCode
// Date:2010-05-12 02:27:50
//
//!--
//--

#import "ECGraphItem.h"

@implementation ECGraphItem

@synthesize name;
@synthesize color;
@synthesize yValue;
@synthesize yDateValue;
@synthesize isYDate;
@synthesize isPercentage;
@synthesize width;

- (id)init{
	if(self = [super init]){
		name = @"";
		color = nil;
		yDateValue = nil;
	}
	return self;
}

- (void)dealloc{
	//[name release];
	//[color release];
	//[yDateValue release];
	//[super dealloc];
    name = nil;
    color =nil;
    yDateValue = nil;
}

@end