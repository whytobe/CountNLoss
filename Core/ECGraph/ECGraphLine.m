//
// ECGraphLine.m
//
// Create By ECGenerateCode
// Date:2010-05-12 01:58:19
//
//!--
//--

#import "ECGraphLine.h"

@implementation ECGraphLine

@synthesize points;
@synthesize name;
@synthesize color;
@synthesize isXDate;
@synthesize isYDate;

- (id)init{
	if(self = [super init]){
		points = nil;
		name = @"";
		color = nil;
	}
	return self;
}

- (void)dealloc{
	//[points release];
	//[name release];
	//[color release];
	//[super dealloc];
    points = nil;
    name = nil;
    color = nil;
    
}

@end