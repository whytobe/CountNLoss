//
//  EPUploader.h
//  CountNLoss
//
//  Created by MacBookPro MacBookPro on 8/30/12.
//  Copyright (c) 2012 A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPUploader : NSObject {
    NSURL *serverURL;
    NSString *filePath;
    id delegate;
    SEL doneSelector;
    SEL errorSelector;
    
    BOOL uploadDidSucceed;
}

-   (id)initWithURL: (NSURL *)serverURL 
           filePath: (NSString *)filePath 
           fileName: (NSString *)fileName
           delegate: (id)delegate 
       doneSelector: (SEL)doneSelector 
      errorSelector: (SEL)errorSelector;

-   (NSString *)filePath;

@end
