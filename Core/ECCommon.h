/*
 
 File:ECCommon.h
 Abstract:iPhone SDK extend class,including string,date,file access.
 
 Version:1.4
 
 Require
 Frameworks:none
 Classes:none
 
 Copyright 2009 ris shin. All rights reserved.
 
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm:ss")
#define kDEFAULT_DATE_FORMAT (@"yyyy-MM-dd")
#define kDEFAULT_TIME_FORMAT (@"HH:mm:ss")
#define kDEFAULT_HOUR_FORMAT (@"HH")
#define kDEFAULT_DATE_WITHOUT_YEAR_FORMAT (@"MM-dd")
#define kALERT_TITLE @"iPology"
#define ECCAST(CLASSNAME,OBJNAME) ((CLASSNAME *)OBJNAME)
#define ECZERO(NUM) NUM

@interface ECCommon : NSObject {
    
}
#pragma mark ===================================about string==================================
/*
 clear space through a given string */
+ (NSString *)sClearSpaceOfS:(NSString *)aString;
/*
 clear front space through a given string */
+ (NSString *)sClearFrontSpaceOfS:(NSString *)aString;

/*
 clear \n through a given string */
+ (NSString *)sClearNOfS:(NSString *)aString;
/*
 add enter at the end of a given string */
+ (NSString *)sAddEnterOfS:(NSString *)aString;
/*
 return a string build by 2 key words in the given string*/
+ (NSString *)sBetweenW1:(NSString *)w1 W2:(NSString *)w2 OfS:(NSString *)aString;
/*
 fill blank to the string to a certain length*/
+ (NSString *)sFillBlankOfS:(NSString *)aString Length:(int)length;
/*
 split each word by multi space(without one space)*/
+ (NSMutableArray *)saSplitMultiSpaceOfS:(NSString *)aString; //powerful
/*
 replace string of a given string */
+ (NSString *)sReplace:(NSString *)oriString ToS:(NSString *)repString OfS:(NSString *)aString;
/*
 build string by index*/
//if startIndex is equal to -1 return the string from index 0 to endIndex,if endIndex is equal to -1 return the string from start index to the end.
+ (NSString *)sStartIndex:(int)startindex EndIndex:(int)endindex OfS:(NSString *)aString;  
/*
 add quotation mark to a given string*/
+ (NSString *)sAddQuotationMarkOfS:(NSString *)aString;
/*
 return string from a int value*/
+ (NSString *)sOfI:(int)intValue;
/*
 give a split by thousand*/
+ (NSString *)sSplitByThousandOfS:(NSString *)aString;
/*
 reverse a string*/
+ (NSString *)sReverseOfS:(NSString *)aString;

/*
 add a separate to a given string e.g. 111,222,333*/
+ (NSString *)sAddSeparate:(NSString *)sepString ByStep:(NSInteger)step OfS:(NSString *)aString;

+ (void)vStringCompareOfA:(NSMutableArray *)aArray;

+(NSString *)sOfBool:(bool)aBool;

#pragma mark ===================================about date==================================
/*
 convert string type to date type */
+ (NSDate *)dOfS:(NSString *)aString withFormat:(NSString *)format;

/*
 change a string time by a given timezone e.g.[NSTimeZone systemTimeZone]*/
+ (NSString *) sTimeByZoneOfS:(NSString *)aString TimeZone:(NSTimeZone *)zone;
/*
 
 convert date type to string type*/
+ (NSString *)sOfD:(NSDate*)aDate Withforamt:(NSString *)format;
/*
 interconvert date type 31-Aug-2009 to date type 2009-08-31*/
+ (NSString *)sWordMiddleToAllNumberOfS:(NSString *)aString SplitS:(NSString *)splitString;
+ (NSString *)sAllNumberToWordMiddleOfS:(NSString *)aString SplitS:(NSString *)splitString;
/*
 intercovert Jan to 1*/
+ (NSString *)sMonthToNumberOfS:(NSString *)month;
+(NSString *)sNumberToMonthOfS:(NSString *)number;
/*
 get now date,time*/
+ (NSString *)sGetNowDate;
+ (NSString *)sGetNowTime;
+ (NSString *)sGetNowDateAndTime;

/*
 add year,month,day to date*/
+ (NSDate *)dAddYearOfD:(NSDate *)aDate Months:(NSInteger)years;
+ (NSDate *)dAddMonthOfD:(NSDate *)aDate Months:(NSInteger)months;
+ (NSDate *)dAddDayOfD:(NSDate *)aDate Months:(NSInteger)days;
+ (NSDate *)dRemoveTimeOfD:(NSDate *)aDate;

#pragma mark ===================================ECFileAccess======================================
/*
 Serializable*/
+ (BOOL)bSaveToFileSerializable:(NSString *)fileName OfObj:(id)object;
+ (id)objLoadFromFile:(NSString *)fileName;

#pragma mark ===================================Help======================================
+(void)vBarButtonWithTitle:(NSString *)title tar:(id)tar sel:(SEL)sel right:(BOOL)right ofNav:(UINavigationItem *)nav;
+(void)vAlertWithTitle:(NSString *)title mes:(NSString *)mes del:(id)del cBtnTitle:(NSString *)cBtnTitle oBtnTitle:(NSString *)oBtnTitle tag:(NSInteger)tag;
+(void)vAddCoverViewTo:(UIView *)view refObj:(UIView *)obj;
+(void)vRemoveCoverViewFrom:(UIView *)view refObj:(UIView *)obj; 
+(NSMutableArray  *)arrDistinct:(NSMutableArray  *)arr;
+(void)vMergeSort:(NSMutableArray *)arr type:(NSString *)type;
+(void)vMerge_Sort:(NSMutableArray *)arr left:(int)left right:(int)right type:(NSString *)type;
+(void)vMerge:(NSMutableArray *)arr left:(int)left center:(int)center right:(int)right type:(NSString *)type;
+(int)getMAXValueFrom:(NSMutableArray *)arr;
@end
